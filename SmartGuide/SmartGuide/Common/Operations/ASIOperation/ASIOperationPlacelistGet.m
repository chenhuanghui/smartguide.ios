//
//  ASIOperationPlacelistDetail.m
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPlacelistGet.h"

@implementation ASIOperationPlacelistGet
@synthesize values,place;

-(ASIOperationPlacelistGet *)initWithIDPlacelist:(int)idPlaceList userLat:(double)userLat userLng:(double)userLng sort:(enum SORT_LIST)sort page:(NSUInteger)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_PLACELIST_GET)]];
    
    values=@[@(idPlaceList),@(userLat),@(userLng),@(sort),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"idPlacelist",@"userLat",@"userLng",@"sort",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    place=[Placelist placeListWithID:[values[0] integerValue]];
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
