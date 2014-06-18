//
//  ASIOperationUserPlacelist.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserPlacelist.h"

@implementation ASIOperationUserPlacelist
@synthesize userPlacelists;

-(ASIOperationUserPlacelist *)initWithUserLat:(double)userLat userLng:(double)userLng page:(int)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_PLACELIST)]];
    
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    [self.keyValue setObject:@(page) forKey:PAGE];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    self.userPlacelists=[NSMutableArray new];
    
    if([json isNullData])
        return;
    
    for(NSDictionary *dict in json)
    {
        UserPlacelist *obj = [UserPlacelist makeWithDictionary:dict];
        
        [userPlacelists addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
