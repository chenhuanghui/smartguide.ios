//
//  ASIOperationPlacelistGetList.m
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPlacelistGetList.h"

@implementation ASIOperationPlacelistGetList
@synthesize placeLists;

-(ASIOperationPlacelistGetList *)initWithUserLat:(double)userLat userLng:(double)userLng page:(NSUInteger)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_PLACELIST_GET_LIST)]];

    [self.keyValue setObject:@(userLat) forKey:@"userLat"];
    [self.keyValue setObject:@(userLng) forKey:@"userLng"];
    [self.keyValue setObject:@(page) forKey:@"page"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    placeLists=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        Placelist *obj = [Placelist makeWithDictionary:dict];
        
        [placeLists addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
