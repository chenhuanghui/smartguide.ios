//
//  ImageCacheManager.h
//  Infory
//
//  Created by XXX on 4/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloaded.h"
#import "ImageResizedCache.h"
#import "SDWebImageOperation.h"

enum IMAGE_RESIZED_MODE
{
    IMAGE_RESIZED_SCALE_TO_FILL = 0,
    IMAGE_RESIZED_ASPECT_TO_FIT = 1,
    IMAGE_RESIZED_ASPECT_TO_FIT_HEIGHT = 2,
    IMAGE_RESIZED_ASPECT_TO_FIT_WIDTH = 3,
    IMAGE_RESIZED_ASPECT_TO_FILL = 4,
};

@interface ImageCacheManager : NSObject

+(ImageCacheManager*) shareInstance;

-(ImageResizedCache*) imageResizedWithURL:(NSString*) url size:(CGSize) size resizeMode:(enum IMAGE_RESIZED_MODE) resizeMode;
-(ImageDownloaded*) imageDownloadedWithURL:(NSString*) url;

@end

@interface UIImageView(ImageCache)

-(void) requestImageWithURL:(NSString*) url size:(CGSize) size resizeMode:(enum IMAGE_RESIZED_MODE) resizeMode;

@end