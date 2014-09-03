//
//  OperationPlacelistDetail.m
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationPlacelistDetail.h"
#import "Place.h"
#import "ShopInfoList.h"

@implementation OperationPlacelistDetail

-(OperationPlacelistDetail *)initWithIDPlace:(int)idPlace userLat:(double)userLat userLng:(double)userLng sort:(enum PLACE_SORT_TYPE)sort
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_PLACELIST_GET_DETAIL)];
    
    [self.keyValue setObject:@(idPlace) forKey:@"idPlacelist"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(sort) forKey:@"sort"];
    
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
    
    NSDictionary *dict=json[0];
    
    self.place=[Place makeWithData:dict];
    
    for(NSDictionary *shop in dict[@"shops"])
    {
        ShopInfoList *obj=[ShopInfoList makeWithData:shop];
        
        [self.place addShopsObject:obj];
        [_shops addObject:obj];
    }
    
    if(self.place || _shops.count>0)
        [[DataManager shareInstance] save];
}

@end
