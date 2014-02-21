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
    
    self.values=@[@(idPlacelist),@(userLat),@(userLng),@(sort)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idPlacelist",@"userLat",@"userLng",@"sort"];
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
