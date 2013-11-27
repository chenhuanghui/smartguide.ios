//
//  ASIOperationShopDetail.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopDetail.h"
#import "ShopProduct.h"
#import "ShopUserComment.h"
#import "ShopUserGallery.h"
#import "ShopGallery.h"

@implementation ASIOperationShopDetail
@synthesize values,shop;

-(ASIOperationShopDetail *)initWithIDShop:(int)idShop latitude:(double)lat longtitude:(double)lon
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_DETAIL)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(lat),@(lon)];
    
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
    
    NSDictionary *dictJson=[json objectAtIndex:0];
    
    int idShop=[self.values[0] integerValue];
    shop=[Shop makeShopWithIDShop:idShop withJSONShopInGroup:dictJson];
    
    [[DataManager shareInstance] save];
}

@end
