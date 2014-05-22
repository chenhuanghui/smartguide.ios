//
//  ASIOperationShopSearch.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopSearch.h"

@implementation ASIOperationShopSearch
@synthesize shopsList;

-(ASIOperationShopSearch *)initWithKeywords:(NSString *)keywords userLat:(double)userLat userLng:(double)userLng page:(NSUInteger)page sort:(enum SORT_LIST)sort idCity:(int)idCity
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_SEARCH)]];
    
    [self.keyValue setObject:keywords forKey:@"keyWords"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(sort) forKey:SORT];
    [self.keyValue setObject:@(idCity) forKey:@"idCity"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shopsList=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        ShopList *sl=[ShopList makeWithDictionary:dict];
        
        [shopsList addObject:sl];
    }
}

@end
