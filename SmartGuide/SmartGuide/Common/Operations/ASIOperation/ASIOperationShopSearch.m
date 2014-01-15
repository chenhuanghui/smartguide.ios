//
//  ASIOperationShopSearch.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationShopSearch.h"

@implementation ASIOperationShopSearch
@synthesize values,shopsList;

-(ASIOperationShopSearch *)initWithKeywords:(NSString *)keywords userLat:(double)userLat userLng:(double)userLng page:(NSUInteger)page sort:(enum SORT_LIST)sort
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_SEARCH)]];
    
    values=@[keywords,@(userLat),@(userLng),@(page),@(sort)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"keyWords",@"userLat",@"userLng",@"page",@"sort"];
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
