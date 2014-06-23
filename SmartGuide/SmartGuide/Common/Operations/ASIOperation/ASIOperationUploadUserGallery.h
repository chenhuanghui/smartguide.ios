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

-(ASIOperationUploadUserGallery*) initWithIDShop:(int) idShop userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *idUserGallery;

@end
