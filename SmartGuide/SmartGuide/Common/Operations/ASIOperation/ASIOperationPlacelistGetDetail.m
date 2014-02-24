//
//  ASIOperationPlacelistGetDetail.m
//  SmartGuide
//
//  Created by MacMini on 21/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPlacelistGetDetail.h"

@implementation ASIOperationPlacelistGetDetail

-(ASIOperationPlacelistGetDetail *)initWithIDPlacelist:(int)idPlacelist userLat:(double)userLat userLng:(double)userLng sort:(enum SORT_LIST)sort
{
    self=[super initWithURL:SERVER_API_URL_MAKE(API_PLACELIST_GET_DETAIL)];
    
    [self.keyValue setObject:@(idPlacelist) forKey:IDPLACELIST];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.place=nil;
    self.shops=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    self.place=[Placelist makeWithDictionary:dict];
    [self.place removeAllShopsList];
    
    for(NSDictionary *dictShop in dict[@"shops"])
    {
        ShopList *shop=[ShopList makeWithDictionary:dictShop];
        
        [self.shops addObject:shop];
        [self.place addShopsListObject:shop];
    }
    
    [[DataManager shareInstance] save];
}

@end
