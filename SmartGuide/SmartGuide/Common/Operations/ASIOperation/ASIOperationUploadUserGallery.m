//
//  ASIOperationUploadUserGallery.m
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUploadUserGallery.h"
#import "ShopUserGallery.h"
#import "Shop.h"

@implementation ASIOperationUploadUserGallery

-(ASIOperationUploadUserGallery *) initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPLOAD_USER_GALLERY)]];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    self.status=[NSNumber numberWithObject:dict[STATUS]];
    self.idUserGallery=[NSNumber numberWithObject:dict[@"idUserGallery"]];
}

@end
