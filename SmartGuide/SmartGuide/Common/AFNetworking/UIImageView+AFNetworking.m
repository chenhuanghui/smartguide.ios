// UIImageView+AFNetworking.m
//
// Copyright (c) 2011 Gowalla (http://gowalla.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "ActivityIndicator.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import "UIImageView+AFNetworking.h"

#pragma mark -

static char kAFImageRequestOperationObjectKey;

@interface UIImageView (_AFNetworking)
@property (readwrite, nonatomic, strong, setter = af_setImageRequestOperation:) AFImageRequestOperation *af_imageRequestOperation;
@end

@implementation UIImageView (_AFNetworking)
@dynamic af_imageRequestOperation;
@end

#pragma mark -

@implementation UIImageView (AFNetworking)

- (void)af_setImageRequestOperation:(AFImageRequestOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, &kAFImageRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AFHTTPRequestOperation *)af_imageRequestOperation {
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, &kAFImageRequestOperationObjectKey);
}

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_af_imageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _af_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_af_imageRequestOperationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    
    return _af_imageRequestOperationQueue;
}

#pragma mark -

- (void)setImageWithURL:(NSURL *)url {
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = [[AFImageCache af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        self.af_imageRequestOperation = nil;
        
        if (success) {
            success(nil, nil, cachedImage);
        } else {
            self.image = cachedImage;
        }
    } else {
        if (placeholderImage) {
            self.image = placeholderImage;
        }
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                if (self.af_imageRequestOperation == operation) {
                    self.af_imageRequestOperation = nil;
                }
                
                if (success) {
                    success(operation.request, operation.response, responseObject);
                } else if (responseObject) {
                    self.image = responseObject;
                }
            }
            
            [[AFImageCache af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                if (self.af_imageRequestOperation == operation) {
                    self.af_imageRequestOperation = nil;
                }
                
                if (failure) {
                    failure(operation.request, operation.response, error);
                }
            }
        }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

- (void)cancelImageRequestOperation {
    [self.af_imageRequestOperation cancel];
    self.af_imageRequestOperation = nil;
}

-(void)setSmartGuideImageWithURL:(NSURL *)url placeHolderImage:(UIImage *)placeholderImage success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, UIImage *))success failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, UIImage *))failure
{
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = [[AFImageCache af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage)
    {
        self.af_imageRequestOperation = nil;
        
        if (success)
        {
            success(nil, nil, cachedImage);
        }
        else
        {
            self.image = cachedImage;
        }
    }
    else
    {
        self.image = placeholderImage;
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                 if (self.af_imageRequestOperation == operation) {
                     self.af_imageRequestOperation = nil;
                 }
                 
                 if (success) {
                     success(operation.request, operation.response, responseObject);
                 } else if (responseObject) {
                     self.image = responseObject;
                 }
             }
             
             [[AFImageCache af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                 if (self.af_imageRequestOperation == operation) {
                     self.af_imageRequestOperation = nil;
                 }
                 
                 [[AFImageCache af_sharedImageCache] cacheEmptyImage:placeholderImage forRequest:urlRequest];
                 
                 if (failure) {
                     failure(operation.request, operation.response, placeholderImage);
                 }
                 else
                     self.image=placeholderImage;
             }
         }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

-(void)setImageWithLoading:(NSURL *)url emptyImage:(UIImage *)emptyImage success:(void (^)(UIImage *))success failure:(void (^)(UIImage *))failure
{
    [self removeLoading];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [self cancelImageRequestOperation];
    UIImage *cachedImage = [[AFImageCache af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage)
    {
        self.af_imageRequestOperation = nil;
        
        if(success)
            success(cachedImage);
        else
            self.image = cachedImage;
    }
    else
    {
        [self showLoadingWithTitle:nil];

        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
        
//        __block __weak AFImageRequestOperation *weakRequest=requestOperation;
//        [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//            
//            if(weakRequest)
//            {
//                self.image=[UIImage imageWithData:weakRequest.totalReceiveData];
//            }
//            
//        }];
        
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                 if (self.af_imageRequestOperation == operation) {
                     self.af_imageRequestOperation = nil;
                 }
                 
                 [self removeLoading];
                 
                 if (responseObject)
                 {
                     if(success)
                     {
                         success(responseObject);
                     }
                     else
                         self.image = responseObject;
                 }
             }
             
             [[AFImageCache af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if ([urlRequest isEqual:[self.af_imageRequestOperation request]]) {
                 if (self.af_imageRequestOperation == operation) {
                     self.af_imageRequestOperation = nil;
                 }
                 
                 if(failure)
                     failure(emptyImage);
                 else
                     self.image=emptyImage;
                 [self removeLoading];
                 
                 if(emptyImage)
                     [[AFImageCache af_sharedImageCache] cacheEmptyImage:emptyImage forRequest:urlRequest];
             }
         }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

@end

#pragma mark -

static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation AFImageCache

+ (AFImageCache *)af_sharedImageCache {
    static AFImageCache *_af_imageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _af_imageCache = [[AFImageCache alloc] init];
        [_af_imageCache setTotalCostLimit:1024*8];
    });
    
    return _af_imageCache;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.emptyImage=[[NSMutableArray alloc] init];
    }
    return self;
}

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
	return [self objectForKey:AFImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:AFImageCacheKeyFromURLRequest(request)];
    }
}

-(void)cacheEmptyImage:(UIImage *)image forRequest:(NSURLRequest *)request
{
    [self.emptyImage addObject:request];
    
    [self cacheImage:image forRequest:request];
}

-(void)clearEmptyImage
{
    while (self.emptyImage.count>0) {
        id request=[self.emptyImage objectAtIndex:0];
        [self removeObjectForKey:request];
        
        [self.emptyImage removeObjectAtIndex:0];
    }
}

@end

#endif