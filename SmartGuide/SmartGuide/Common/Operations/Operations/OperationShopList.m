//
//  OperationShopList.m
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationShopList.h"
#import "ShopInfoList.h"

@implementation OperationShopList

-(OperationShopList *)initWithIDShops:(NSString *)idShops idBrand:(int)idBrand userLat:(double)userLat userLng:(double)userLng page:(int)page sort:(enum SHOP_LIST_SORT_TYPE)sortType
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_GET_SHOP_LIST)];
    
    if(idShops.length>0)
        [self.keyValue setObject:idShops forKey:IDSHOP];
    else
        [self.keyValue setObject:@(idBrand) forKey:@"idBrand"];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(sortType) forKey:@"sort"];
    
    return self;
}

-(void)onFinishLoading
{
    self.shops=[NSMutableArray array];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    for(NSDictionary *dict in json)
    {
        ShopInfoList *obj=[ShopInfoList makeWithData:dict];
        
        [_shops addObject:obj];
    }
    
    if(_shops.count>0)
        [[DataManager shareInstance] save];
}

@end
