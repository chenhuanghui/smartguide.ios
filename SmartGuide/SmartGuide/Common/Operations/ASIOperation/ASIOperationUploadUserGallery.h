//
//  ASIOperationUploadUserGallery.h
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class ShopUserGallery;

@interface ASIOperationUploadUserGallery : ASIOperationPost

-(ASIOperationUploadUserGallery*) initWithIDShop:(int) idShop image:(NSData*) image userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) int status;
@property (nonatomic, readonly) int idUserGallery;

@end
