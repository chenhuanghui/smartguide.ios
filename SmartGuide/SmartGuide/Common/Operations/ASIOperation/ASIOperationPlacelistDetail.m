//
//  ASIOperationPlacelistDetail.m
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPlacelistDetail.h"

@implementation ASIOperationPlacelistDetail
@synthesize values,place,shopsList;

-(ASIOperationPlacelistDetail *)initWithIDPlacelist:(int)idPlaceList userLat:(double)userLat userLng:(double)userLng sort:(enum SORT_PLACE_LIST)sort page:(NSUInteger)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_PLACELIST_DETAIL)]];
    
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
    shopsList=[NSMutableArray array];
    
    for(NSDictionary *dict in json)
    {
        ShopList *shop=[ShopList makeWithDictionary:dict];
        
        [place addShopsListObject:shop];
        [shopsList addObject:shop];
    }
    
    [[DataManager shareInstance] save];
}

@end
