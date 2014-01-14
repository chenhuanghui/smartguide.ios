//
//  ASIOperationUserPlacelist.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserPlacelist.h"

@implementation ASIOperationUserPlacelist
@synthesize values,userPlacelists;

-(ASIOperationUserPlacelist *)initWithUserLat:(double)userLat userLng:(double)userLng page:(int)page
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_PLACELIST)]];
    
    values=@[@(userLat),@(userLng),@(page)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"userLat",@"userLng",@"page"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    userPlacelists=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        UserPlacelist *obj = [UserPlacelist makeWithDictionary:dict];
        
        [userPlacelists addObject:obj];
    }
    
    [[DataManager shareInstance] save];
}

@end
