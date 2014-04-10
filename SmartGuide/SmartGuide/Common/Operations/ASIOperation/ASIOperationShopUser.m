//
//  ASIOperationShopDetail.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopUser.h"
#import "ShopProduct.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"
#import "ShopGallery.h"
#import "UserUploadGalleryManager.h"

@implementation ASIOperationShopUser
@synthesize shop;

-(ASIOperationShopUser *) initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_DETAIL)];
    self=[super initWithURL:_url];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    shop=[Shop makeShopWithDictionary:json[0]];
    
    for(UserGalleryUpload *upload in [[UserUploadGalleryManager shareInstance] uploadFinishedWithIDShop:shop.idShop.integerValue])
    {
        [[DataManager shareInstance].managedObjectContext deleteObject:upload];
    }
    
    [[DataManager shareInstance] save];
}

@end
