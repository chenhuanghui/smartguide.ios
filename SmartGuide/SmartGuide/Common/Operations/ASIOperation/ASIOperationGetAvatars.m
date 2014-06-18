//
//  ASIOperationGetAvatars.m
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetAvatars.h"

@implementation ASIOperationGetAvatars
@synthesize avatars;

-(ASIOperationGetAvatars *)initGetAvatars
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_AVATARS)];
    
    self=[super initWithURL:_url];

    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    avatars=[NSMutableArray array];
    
    if([json isNullData])
        return;
    
    for(NSString *str in json)
    {
        [avatars addObject:[NSString stringWithStringDefault:str]];
    }
}

@end
