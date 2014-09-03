//
//  OperationSearchShop.m
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationSearchShop.h"
#import "ShopInfoList.h"

@implementation OperationSearchShop

-(OperationSearchShop *)initWithKeyword:(NSString *)keyword userLat:(double)userLat userLng:(double)userLng page:(int)page sort:(enum SHOP_LIST_SORT_TYPE)sort idCity:(int)idCity
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_SHOP_SEARCH)];
    
    [self.keyValue setObject:keyword forKey:@"keyWords"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    [self.keyValue setObject:@(idCity) forKey:@"idCity"];
    
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
