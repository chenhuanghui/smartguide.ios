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

-(ASIOperationUploadUserGallery*) initWithIDShop:(int) idShop userID:(int) idUser desc:(NSString*) desc photo:(NSData*) image;

@property (nonatomic, readonly) bool isSuccess;
@property (nonatomic, readonly) NSData *imageData;
@property (nonatomic, readonly) ShopUserGallery *userGallery;

@end
