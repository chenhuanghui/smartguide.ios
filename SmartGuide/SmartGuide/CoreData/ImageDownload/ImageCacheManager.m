//
//  ImageCacheManager.m
//  Infory
//
//  Created by XXX on 4/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ImageCacheManager.h"
#import <CoreData/CoreData.h>
#import "UIImageView+WebCache.h"
#import "Utility.h"
#import "SDWebImageManager.h"

@interface ImageCacheManager()

@property (nonatomic, strong) NSManagedObjectModel *objectModel;
@property (nonatomic, strong) NSManagedObjectContext *objectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic, strong) NSMutableArray *downloadJobs;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@end

static ImageCacheManager *_shareInstance=nil;;
@implementation ImageCacheManager
@synthesize objectModel,objectContext,storeCoordinator;
@synthesize downloadJobs;

+(ImageCacheManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance=[ImageCacheManager new];
    });
    
    return _shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadDatabase];
    }
    
    self.downloadQueue=[[NSOperationQueue alloc] init];
    self.downloadQueue.maxConcurrentOperationCount=2;
    
    return self;
}

-(NSURL*) storeURL
{
    NSURL *url=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url=[url URLByAppendingPathComponent:@"ImageDB.sqlite"];
    
    return url;
}

-(void) loadDatabase
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ImageDB" withExtension:@"mom"];
    if(!modelURL)
    {
        modelURL = [[NSBundle mainBundle] URLForResource:@"ImageDB" withExtension:@"momd"];
    }
    
    self.objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    self.storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
    NSError *error=nil;
    [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self storeURL] options:options error:&error];
    
    if(error)
    {
        NSLog(@"persistentStoreCoordinator error %@",error);
        [[NSFileManager defaultManager] removeItemAtURL:[self storeURL] error:nil];
        [self loadDatabase];
        return;
    }
    
    self.objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.objectContext setPersistentStoreCoordinator:self.storeCoordinator];
    
    [self cleanImageCacheNotFinished];
}

-(void) cleanImageCacheNotFinished
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ImageDownloaded"];
    
    NSError *error=nil;
    NSArray *result=[self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ImageDownloaded query error %@",error);
    
    if(result && result.count>0)
    {
        for(ImageDownloaded *img in result)
        {
            if(!img.finished.boolValue)
                [self.objectContext deleteObject:img];
        }
        
        error=nil;
        [self.objectContext save:&error];
        
        if(error)
            NSLog(@"ImageDownloaded delete error %@",error);
    }
}

-(ImageDownloaded *)imageDownloadedWithURL:(NSString *)url
{
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"ImageDownloaded"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K==%@",@"url",url];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *result=[self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ImageDownloaded query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return result[0];
    
    return nil;
}

-(ImageResizedCache *)imageResizedWithURL:(NSString *)url size:(CGSize)size resizeMode:(enum IMAGE_RESIZED_MODE)resizeMode
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ImageResizedCache"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K==%@ AND %K==%f AND %K==%f AND %K==%i",@"url",url,@"width",size.width,@"height",size.height,@"resizeMode",resizeMode];
    
    [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context=self.objectContext;
    
    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if(error)
        NSLog(@"ImageCache query error %@ predicate %@",error,predicate);
    
    if(result && result.count>0)
        return [result objectAtIndex:0];
    
    return nil;
}

@end

@implementation UIImageView(ImageCache)

-(void)requestImageWithURL:(NSString *)url size:(CGSize)size resizeMode:(enum IMAGE_RESIZED_MODE)resizeMode
{
    if(url.length==0)
    {
        self.image=nil;
        return;
    }

    NSString *urlQueryDisk=[NSString stringWithFormat:@"%@%f%f%i",url,size.width,size.height,resizeMode];
    UIImage *imgQuery=[[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:urlQueryDisk];
    if(imgQuery)
    {
        self.image=imgQuery;
        [self setNeedsLayout];
    }
    else
    {
        __weak UIImageView *wSelf=self;
        [[SDWebImageManager sharedManager] downloadWithURL:URL(url) options:SDWebImageContinueInBackground progress:nil storeImage:^ResizeImageObject *(UIImage *downloadedImage) {
            
            UIImage *resizedImage=nil;
            
            switch (resizeMode) {
                case IMAGE_RESIZED_SCALE_TO_FILL:
                case IMAGE_RESIZED_ASPECT_TO_FILL:
                case IMAGE_RESIZED_ASPECT_TO_FIT:
                case IMAGE_RESIZED_ASPECT_TO_FIT_WIDTH:
                    resizedImage=downloadedImage;
                    break;
                    
                case IMAGE_RESIZED_ASPECT_TO_FIT_HEIGHT:
                    resizedImage=downloadedImage;
                    break;
            }
            
            ResizeImageObject *resizeObj=[[ResizeImageObject alloc] init];
            resizeObj.resizeImage=resizedImage;
            resizeObj.key=urlQueryDisk;
            
            return resizeObj;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            if(wSelf)
            {
                wSelf.image=image;
            }
        }];
    }
}

@end

@implementation ImageResizedCache(ResizeMode)

-(enum IMAGE_RESIZED_MODE)enumResizeMode
{
    switch (self.resizeMode.integerValue) {
        case IMAGE_RESIZED_SCALE_TO_FILL:
            return IMAGE_RESIZED_SCALE_TO_FILL;
            
        case IMAGE_RESIZED_ASPECT_TO_FIT:
            return IMAGE_RESIZED_ASPECT_TO_FIT;
            
        case IMAGE_RESIZED_ASPECT_TO_FIT_HEIGHT:
            return IMAGE_RESIZED_ASPECT_TO_FIT_HEIGHT;
            
        case IMAGE_RESIZED_ASPECT_TO_FIT_WIDTH:
            return IMAGE_RESIZED_ASPECT_TO_FIT_WIDTH;
            
        case IMAGE_RESIZED_ASPECT_TO_FILL:
            return IMAGE_RESIZED_ASPECT_TO_FILL;
            
        default:
            return IMAGE_RESIZED_SCALE_TO_FILL;
    }
}

@end