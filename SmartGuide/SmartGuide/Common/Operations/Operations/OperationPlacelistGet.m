//
//  OperationPlacelistGet.m
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationPlacelistGet.h"
#import "ShopInfoList.h"

@implementation OperationPlacelistGet

-(OperationPlacelistGet *)initWithIDPlace:(int)idPlace userLat:(double)userLat userLng:(double)userLng sort:(enum PLACE_SORT_TYPE)sort page:(int)page
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_PLACELIST_GET)];
    
    [self.keyValue setObject:@(idPlace) forKey:IDPLACELIST];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    [self.keyValue setObject:@(page) forKey:PAGE];
    
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
    
    if(_shops.count)
        [[DataManager shareInstance] save];
}

@end
