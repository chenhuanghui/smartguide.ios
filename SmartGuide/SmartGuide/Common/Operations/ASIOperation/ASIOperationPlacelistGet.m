//
//  ASIOperationPlacelistDetail.m
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPlacelistGet.h"

@implementation ASIOperationPlacelistGet
@synthesize place;

-(ASIOperationPlacelistGet *)initWithIDPlacelist:(int)idPlaceList userLat:(double)userLat userLng:(double)userLng sort:(enum SORT_LIST)sort page:(NSUInteger)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_PLACELIST_GET)]];
    
    [self.keyValue setObject:@(idPlaceList) forKey:@"idPlacelist"];
    [self.keyValue setObject:@(userLat) forKey:@"userLat"];
    [self.keyValue setObject:@(userLng) forKey:@"userLng"];
    [self.keyValue setObject:@(sort) forKey:@"sort"];
    [self.keyValue setObject:@(page) forKey:@"page"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    place=[Placelist placeListWithID:[self.keyValue[@"idPlacelist"] integerValue]];
    self.shopsList=[NSMutableArray new];
    
    for(NSDictionary *dict in json)
    {
        ShopList *shop=[ShopList makeWithDictionary:dict];
        
        [place addShopsListObject:shop];
        [self.shopsList addObject:shop];
    }
    
    [[DataManager shareInstance] save];
}

@end
