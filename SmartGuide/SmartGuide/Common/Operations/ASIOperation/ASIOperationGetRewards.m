//
//  ASIOperationGetRewards.m
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetRewards.h"
#import "Reward.h"

@implementation ASIOperationGetRewards
@synthesize rewards,values;

-(ASIOperationGetRewards *)initGetRewardsWithIDUser:(int)idUser
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_REWARDS)];
    self=[super initWithURL:_url];
    
    values=@[@(idUser)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(Reward *reward in [Reward allObjects])
        [[DataManager shareInstance].managedObjectContext deleteObject:reward];
    
    [[DataManager shareInstance] save];
    
    rewards=[NSMutableArray array];
    
    if([self isNullData:json])
        return;
    
    for(NSDictionary *dict in json)
    {
        Reward *reward=[Reward insert];
        
        reward.idReward=[NSNumber numberWithObject:[dict objectForKey:@"id"]];
        reward.score=[NSNumber numberWithObject:[dict objectForKey:@"score"]];
        reward.content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
        reward.status=[NSNumber numberWithObject:[dict objectForKey:@"status"]];
        reward.thumbnail=[NSString stringWithStringDefault:[dict objectForKey:@"thumbnail"]];
        
        [rewards addObject:reward];
    }
    
    [[DataManager shareInstance] save];
}

@end
