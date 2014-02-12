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

-(ASIOperationUploadUserGallery*) initWithIDShop:(int) idShop desc:(NSString*) desc photo:(NSData*) image shareFacebook:(bool) isSharedFacebook userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, readonly) bool status;
@property (nonatomic, readonly) NSString *message;

@end
