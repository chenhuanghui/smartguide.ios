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

@implementation ASIOperationShopUser
@synthesize values,shop;

-(ASIOperationShopUser *) initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_DETAIL)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(userLat),@(userLng)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idShop",@"userLat",@"userLng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    shop=[Shop makeShopWithDictionary:json[0]];
    
    [[DataManager shareInstance] save];
}

@end