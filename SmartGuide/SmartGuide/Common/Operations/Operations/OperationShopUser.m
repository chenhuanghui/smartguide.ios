//
//  OperationShopUser.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationShopUser.h"
#import "ShopInfo.h"
#import "ShopInfoGallery.h"
#import "ShopInfoComment.h"
#import "ShopInfoUserGallery.h"
#import "ShopInfoEvent.h"

@implementation OperationShopUser

-(OperationShopUser *)initWithIDShop:(int)idShop userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_SHOP_DETAIL)];
    
    [self.keyValue setObject:@(idShop) forKey:IDSHOP];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}


-(void)onFinishLoading
{
    self.shopComments=[NSMutableArray array];
    self.shopGalleries=[NSMutableArray array];
    self.shopUserGalleries=[NSMutableArray array];
    self.shopEvents=[NSMutableArray array];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    NSDictionary *data=json[0];
    self.shop=[ShopInfo makeWithData:data];
    
    NSArray *array=data[@"shopGallery"];
    
    if([array hasData])
    {
        for(NSDictionary *gallery in array)
        {
            ShopInfoGallery *obj=[ShopInfoGallery makeWithData:gallery];

            [_shop addGalleriesObject:obj];
            [_shopGalleries addObject:obj];
        }
    }
    
    array=data[@"userGallery"];
    
    if([array hasData])
    {
        for(NSDictionary *userGallery in array)
        {
            ShopInfoUserGallery *obj = [ShopInfoUserGallery makeWithData:userGallery];
            
            [_shop addUserGalleriesObject:obj];
            [_shopUserGalleries addObject:obj];
        }
    }
    
    array=data[@"comments"];
    
    if([array hasData])
    {
        for(NSDictionary *comment in array)
        {
            ShopInfoComment *obj = [ShopInfoComment makeWithData:comment];
            
            [_shop addCommentsObject:obj];
            [_shopComments addObject:obj];
        }
    }
    
    array=data[@"promotionNews"];
    
    if([array hasData])
    {
    for(NSDictionary *kmNew in array)
    {
        ShopInfoEvent *obj=[ShopInfoEvent makeWithData:kmNew];
        
        [_shop addEventsObject:obj];
        [_shopEvents addObject:obj];
    }
    }
}

@end
