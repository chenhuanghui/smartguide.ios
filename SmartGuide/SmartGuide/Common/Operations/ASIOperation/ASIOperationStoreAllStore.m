//
//  ASIOperationStoreAllStore.m
//  SmartGuide
//
//  Created by MacMini on 15/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationStoreAllStore.h"

@implementation ASIOperationStoreAllStore
@synthesize values,shopsLatest,shopsTopSellers;

-(ASIOperationStoreAllStore *)initWithUserLat:(double)userLat withUserLng:(double)userLng
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_STORE_ALL_STORE)]];
    
    values=@[@(userLat),@(userLng)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"userLat",@"userLng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    shopsTopSellers=[NSMutableArray array];
    shopsLatest=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    NSArray *array=json[0][@"topSellers"];
    
    for(NSDictionary *dict in array)
    {
        StoreShop *store=[StoreShop makeWithDictionary:dict];
        
        [shopsTopSellers addObject:store];
    }
    
    array=json[0][@"latest"];
    for(NSDictionary *dict in array)
    {
        StoreShop *store=[StoreShop makeWithDictionary:dict];
        
        [shopsLatest addObject:store];
    }
    
    [[DataManager shareInstance] save];
}

@end
