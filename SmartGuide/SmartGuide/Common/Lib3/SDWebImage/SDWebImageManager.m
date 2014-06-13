/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageManager.h"
#import <objc/message.h>

@interface SDWebImageCombinedOperation : NSObject <SDWebImageOperation>

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) void (^cancelBlock)();
@property (strong, nonatomic) NSOperation *cacheOperation;

@end

@interface SDWebImageManager ()

@property (strong, nonatomic, readwrite) SDImageCache *imageCache;
@property (strong, nonatomic, readwrite) SDWebImageDownloader *imageDownloader;
@property (strong, nonatomic) NSMutableArray *failedURLs;
@property (strong, nonatomic) NSMutableArray *runningOperations;

@end

@implementation SDWebImageManager

+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    if ((self = [super init])) {
        _imageCache = [self createCache];
        _imageDownloader = [SDWebImageDownloader new];
        _failedURLs = [NSMutableArray new];
        _runningOperations = [NSMutableArray new];
    }
    return self;
}

- (SDImageCache *)createCache {
    return [SDImageCache sharedImageCache];
}

- (NSString *)cacheKeyForURL:(NSURL *)url {
    if (self.cacheKeyFilter) {
        return self.cacheKeyFilter(url);
    }
    else {
        return [url absoluteString];
    }
}

- (BOOL)diskImageExistsForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    return [self.imageCache diskImageExistsWithKey:key];
}

- (id <SDWebImageOperation>)downloadWithURL:(NSURL *)url options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedWithFinishedBlock)completedBlock {
    // Invoking this method without a completedBlock is pointless
    NSParameterAssert(completedBlock);

    // Very common mistake is to send the URL using NSString object instead of NSURL. For some strange reason, XCode won't
    // throw any warning for this type mismatch. Here we failsafe this error by allowing URLs to be passed as NSString.
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }

    // Prevents app crashing on argument type error like sending NSNull instead of NSURL
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }

    __block SDWebImageCombinedOperation *operation = [SDWebImageCombinedOperation new];
    __weak SDWebImageCombinedOperation *weakOperation = operation;

    BOOL isFailedUrl = NO;
    @synchronized (self.failedURLs) {
        isFailedUrl = [self.failedURLs containsObject:url];
    }

    if (!url || (!(options & SDWebImageRetryFailed) && isFailedUrl)) {
        dispatch_main_sync_safe(^{
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
            completedBlock(nil, error, SDImageCacheTypeNone, YES);
        });
        return operation;
    }

    @synchronized (self.runningOperations) {
        [self.runningOperations addObject:operation];
    }
    NSString *key = [self cacheKeyForURL:url];

    operation.cacheOperation = [self.imageCache queryDiskCacheForKey:key done:^(UIImage *image, SDImageCacheType cacheType, NSString *doneKey) {
        if (operation.isCancelled) {
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }

            return;
        }

        if ((!image || options & SDWebImageRefreshCached) && (![self.delegate respondsToSelector:@selector(imageManager:shouldDownloadImageForURL:)] || [self.delegate imageManager:self shouldDownloadImageForURL:url])) {
            if (image && options & SDWebImageRefreshCached) {
                dispatch_main_sync_safe(^{
                    // If image was found in the cache bug SDWebImageRefreshCached is provided, notify about the cached image
                    // AND try to re-download it in order to let a chance to NSURLCache to refresh it from server.
                    completedBlock(image, nil, cacheType, YES);
                });
            }

            // download if no image or requested to refresh anyway, and download allowed by delegate
            SDWebImageDownloaderOptions downloaderOptions = 0;
            if (options & SDWebImageLowPriority) downloaderOptions |= SDWebImageDownloaderLowPriority;
            if (options & SDWebImageProgressiveDownload) downloaderOptions |= SDWebImageDownloaderProgressiveDownload;
            if (options & SDWebImageRefreshCached) downloaderOptions |= SDWebImageDownloaderUseNSURLCache;
            if (options & SDWebImageContinueInBackground) downloaderOptions |= SDWebImageDownloaderContinueInBackground;
            if (options & SDWebImageHandleCookies) downloaderOptions |= SDWebImageDownloaderHandleCookies;
            if (options & SDWebImageAllowInvalidSSLCertificates) downloaderOptions |= SDWebImageDownloaderAllowInvalidSSLCertificates;
            if (options & SDWebImageHighPriority) downloaderOptions |= SDWebImageDownloaderHighPriority;
            if (image && options & SDWebImageRefreshCached) {
                // force progressive off if image already cached but forced refreshing
                downloaderOptions &= ~SDWebImageDownloaderProgressiveDownload;
                // ignore image read from NSURLCache if image if cached but force refreshing
                downloaderOptions |= SDWebImageDownloaderIgnoreCachedResponse;
            }
            id <SDWebImageOperation> subOperation = [self.imageDownloader downloadImageWithURL:url options:downloaderOptions progress:progressBlock completed:^(UIImage *downloadedImage, NSData *data, NSError *error, BOOL finished) {
                if (weakOperation.isCancelled) {
                    dispatch_main_sync_safe(^{
                        completedBlock(nil, nil, SDImageCacheTypeNone, finished);
                    });
                }
                else if (error) {
                    dispatch_main_sync_safe(^{
                        completedBlock(nil, error, SDImageCacheTypeNone, finished);
                    });

                    if (error.code != NSURLErrorNotConnectedToInternet) {
                        @synchronized (self.failedURLs) {
                            [self.failedURLs addObject:url];
                        }
                    }
                }
                else {
                    BOOL cacheOnDisk = !(options & SDWebImageCacheMemoryOnly);

                    if (options & SDWebImageRefreshCached && image && !downloadedImage) {
                        // Image refresh hit the NSURLCache cache, do not call the completion block
                    }
                            // NOTE: We don't call transformDownloadedImage delegate method on animated images as most transformation code would mangle it
                    else if (downloadedImage && !downloadedImage.images && [self.delegate respondsToSelector:@selector(imageManager:transformDownloadedImage:withURL:)]) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                            UIImage *transformedImage = [self.delegate imageManager:self transformDownloadedImage:downloadedImage withURL:url];

                            if (transformedImage && finished) {
                                BOOL imageWasTransformed = ![transformedImage isEqual:downloadedImage];
                                [self.imageCache storeImage:transformedImage recalculateFromImage:imageWasTransformed imageData:data forKey:key toDisk:cacheOnDisk];
                            }

                            dispatch_main_sync_safe(^{
                                completedBlock(transformedImage, nil, SDImageCacheTypeNone, finished);
                            });
                        });
                    }
                    else {
                        if (downloadedImage && finished) {
                            [self.imageCache storeImage:downloadedImage recalculateFromImage:NO imageData:data forKey:key toDisk:cacheOnDisk];
                        }

                        dispatch_main_sync_safe(^{
                            completedBlock(downloadedImage, nil, SDImageCacheTypeNone, finished);
                        });
                    }
                }

                if (finished) {
                    @synchronized (self.runningOperations) {
                        [self.runningOperations removeObject:operation];
                    }
                }
            }];
            operation.cancelBlock = ^{
                [subOperation cancel];
            };
        }
        else if (image) {
            dispatch_main_sync_safe(^{
                completedBlock(image, nil, cacheType, YES);
            });
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
        else {
            // Image not in cache and download disallowed by delegate
            dispatch_main_sync_safe(^{
                completedBlock(nil, nil, SDImageCacheTypeNone, YES);
            });
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
    }];

    return operation;
}

-(id<SDWebImageOperation>)downloadWithURL:(NSURL *)url options:(SDWebImageOptions)options download:(void (^)())onDownload progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedWithFinishedBlock)completedBlock willSize:(CGSize)willSize resize:(UIImage *(^)(UIImage *))resizeMethod
{
    // Invoking this method without a completedBlock is pointless
    NSParameterAssert(completedBlock);
    
    // Very common mistake is to send the URL using NSString object instead of NSURL. For some strange reason, XCode won't
    // throw any warning for this type mismatch. Here we failsafe this error by allowing URLs to be passed as NSString.
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    
    // Prevents app crashing on argument type error like sending NSNull instead of NSURL
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }
    
    __block SDWebImageCombinedOperation *operation = [SDWebImageCombinedOperation new];
    __weak SDWebImageCombinedOperation *weakOperation = operation;
    
    BOOL isFailedUrl = NO;
    @synchronized (self.failedURLs) {
        isFailedUrl = [self.failedURLs containsObject:url];
    }
    
    if (!url || (!(options & SDWebImageRetryFailed) && isFailedUrl)) {
        dispatch_main_sync_safe(^{
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
            completedBlock(nil, error, SDImageCacheTypeNone, YES);
        });
        return operation;
    }
    

    @synchronized (self.runningOperations) {
        [self.runningOperations addObject:operation];
    }
    NSString *key = [self cacheKeyForURL:url];
    NSString *keyResize=key;
    
    if(resizeMethod && [self.imageCache checkDiskCacheForKey:keyResize])
    {
        keyResize=[key stringByAppendingString:NSStringFromCGSize(willSize)];
    }
    
    operation.cacheOperation = [self.imageCache queryDiskCacheForKey:keyResize done:^(UIImage *image, SDImageCacheType cacheType, NSString *doneKey) {
        if (operation.isCancelled) {
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
            
            return;
        }
        
        if ((!image || options & SDWebImageRefreshCached) && (![self.delegate respondsToSelector:@selector(imageManager:shouldDownloadImageForURL:)] || [self.delegate imageManager:self shouldDownloadImageForURL:url])) {
            if (image && options & SDWebImageRefreshCached) {
                dispatch_main_sync_safe(^{
                    // If image was found in the cache bug SDWebImageRefreshCached is provided, notify about the cached image
                    // AND try to re-download it in order to let a chance to NSURLCache to refresh it from server.
                    completedBlock(image, nil, cacheType, YES);
                });
            }
            
            // download if no image or requested to refresh anyway, and download allowed by delegate
            SDWebImageDownloaderOptions downloaderOptions = 0;
            if (options & SDWebImageLowPriority) downloaderOptions |= SDWebImageDownloaderLowPriority;
            if (options & SDWebImageProgressiveDownload) downloaderOptions |= SDWebImageDownloaderProgressiveDownload;
            if (options & SDWebImageRefreshCached) downloaderOptions |= SDWebImageDownloaderUseNSURLCache;
            if (options & SDWebImageContinueInBackground) downloaderOptions |= SDWebImageDownloaderContinueInBackground;
            if (options & SDWebImageHandleCookies) downloaderOptions |= SDWebImageDownloaderHandleCookies;
            if (options & SDWebImageAllowInvalidSSLCertificates) downloaderOptions |= SDWebImageDownloaderAllowInvalidSSLCertificates;
            if (options & SDWebImageHighPriority) downloaderOptions |= SDWebImageDownloaderHighPriority;
            if (image && options & SDWebImageRefreshCached) {
                // force progressive off if image already cached but forced refreshing
                downloaderOptions &= ~SDWebImageDownloaderProgressiveDownload;
                // ignore image read from NSURLCache if image if cached but force refreshing
                downloaderOptions |= SDWebImageDownloaderIgnoreCachedResponse;
            }
            
            if(onDownload)
                onDownload();
            
            id <SDWebImageOperation> subOperation = [self.imageDownloader downloadImageWithURL:url options:downloaderOptions progress:progressBlock completed:^(UIImage *downloadedImage, NSData *data, NSError *error, BOOL finished) {
                if (weakOperation.isCancelled) {
                    dispatch_main_sync_safe(^{
                        completedBlock(nil, nil, SDImageCacheTypeNone, finished);
                    });
                }
                else if (error) {
                    dispatch_main_sync_safe(^{
                        completedBlock(nil, error, SDImageCacheTypeNone, finished);
                    });
                    
                    if (error.code != NSURLErrorNotConnectedToInternet) {
                        @synchronized (self.failedURLs) {
                            [self.failedURLs addObject:url];
                        }
                    }
                }
                else {
                    BOOL cacheOnDisk = !(options & SDWebImageCacheMemoryOnly);
                    
                    if (options & SDWebImageRefreshCached && image && !downloadedImage) {
                        // Image refresh hit the NSURLCache cache, do not call the completion block
                    }
                    // NOTE: We don't call transformDownloadedImage delegate method on animated images as most transformation code would mangle it
                    else if (downloadedImage && !downloadedImage.images && [self.delegate respondsToSelector:@selector(imageManager:transformDownloadedImage:withURL:)]) {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                            UIImage *transformedImage = [self.delegate imageManager:self transformDownloadedImage:downloadedImage withURL:url];
                            
                            if (transformedImage && finished) {
                                BOOL imageWasTransformed = ![transformedImage isEqual:downloadedImage];
                                [self.imageCache storeImage:transformedImage recalculateFromImage:imageWasTransformed imageData:data forKey:key toDisk:cacheOnDisk];
                            }
                            
                            dispatch_main_sync_safe(^{
                                completedBlock(transformedImage, nil, SDImageCacheTypeNone, finished);
                            });
                        });
                    }
                    else {
                        if (downloadedImage && finished) {
                            [self.imageCache storeImage:downloadedImage recalculateFromImage:NO imageData:data forKey:key toDisk:cacheOnDisk];
                        }
                        
                        if(resizeMethod && finished)
                        {
                            UIImage *img=resizeMethod(downloadedImage);
                            
                            if(img)
                            {
                                downloadedImage=img;
                                
                                NSLog(@"%@ resize %@ -> %@",key,NSStringFromCGSize(downloadedImage.size),NSStringFromCGSize(willSize));
                                
                                [self.imageCache storeImage:downloadedImage recalculateFromImage:NO imageData:UIImagePNGRepresentation(downloadedImage) forKey:[key stringByAppendingString:NSStringFromCGSize(willSize)] toDisk:true];
                            }
                        }
                        
                        dispatch_main_sync_safe(^{
                            completedBlock(downloadedImage, nil, SDImageCacheTypeNone, finished);
                        });
                    }
                }
                
                if (finished) {
                    @synchronized (self.runningOperations) {
                        [self.runningOperations removeObject:operation];
                    }
                }
            }];
            operation.cancelBlock = ^{
                [subOperation cancel];
            };
        }
        else if (image) {
            
            // Kiểm tra nếu image đã được download trước đó nhưng chưa resize
            if(resizeMethod)
            {
                if(![doneKey isEqualToString:[key stringByAppendingString:NSStringFromCGSize(willSize)]])
                {
                    NSLog(@"%@ disk|memory resize %@ -> %@",key,NSStringFromCGSize(image.size),NSStringFromCGSize(willSize));
                    
                    image=resizeMethod(image);
                    
                    if(image)
                        [self.imageCache storeImage:image recalculateFromImage:NO imageData:UIImagePNGRepresentation(image) forKey:[key stringByAppendingString:NSStringFromCGSize(willSize)] toDisk:true];
                }
            }
            
            dispatch_main_sync_safe(^{
                completedBlock(image, nil, cacheType, YES);
            });
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
        else {
            // Image not in cache and download disallowed by delegate
            dispatch_main_sync_safe(^{
                completedBlock(nil, nil, SDImageCacheTypeNone, YES);
            });
            @synchronized (self.runningOperations) {
                [self.runningOperations removeObject:operation];
            }
        }
    }];
    
    return operation;
}

- (void)cancelAll {
    @synchronized (self.runningOperations) {
        [self.runningOperations makeObjectsPerformSelector:@selector(cancel)];
        [self.runningOperations removeAllObjects];
    }
}

- (BOOL)isRunning {
    return self.runningOperations.count > 0;
}

@end

@implementation SDWebImageCombinedOperation

- (void)setCancelBlock:(void (^)())cancelBlock {
    if (self.isCancelled) {
        if (cancelBlock) cancelBlock();
    }
    else {
        _cancelBlock = [cancelBlock copy];
    }
}

- (void)cancel {
    self.cancelled = YES;
    if (self.cacheOperation) {
        [self.cacheOperation cancel];
        self.cacheOperation = nil;
    }
    if (self.cancelBlock) {
        self.cancelBlock();
        self.cancelBlock = nil;
    }
}

@end
