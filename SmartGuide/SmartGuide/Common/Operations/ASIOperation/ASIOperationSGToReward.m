//
//  ASIOperationSGToReward.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationSGToReward.h"

@implementation ASIOperationSGToReward
@synthesize status,score,content,time,values,reward;

-(ASIOperationSGToReward *)initWithIDReward:(int)rewardID idUser:(int)idUser
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SG_TO_REWARD)];
    
    self=[super initWithURL:_url];
    
    values=@[@(rewardID),@(idUser)];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    status=[[NSNumber numberWithObject:[dict objectForKey:@"status"]] integerValue];
    content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
    
    if(status==2)
    {
        score=[[NSNumber numberWithObject:[dict objectForKey:@"score"]] integerValue];
        reward=[NSString stringWithStringDefault:[dict objectForKey:@"reward"]];
        time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
    }
}

-(NSArray *)keys
{
    return @[@"reward_id",@"user_id"];
}

@end
