//
//  ASIOperationSGPToReward.m
//  SmartGuide
//
//  Created by XXX on 8/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationSGPToReward.h"

@implementation ASIOperationSGPToReward
@synthesize status,sgp,award,time,shopName,content,values,totalSGP,code;

-(ASIOperationSGPToReward *)initWithIDUser:(int)idUser idRewward:(int)idReward code:(NSString *)_code
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SGP_TO_REWARD)];
    self=[super initWithURL:_url];
    
    code=[[NSString alloc] initWithString:_code];
    values=@[@(idUser),@(idReward),_code];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"award_id",@"code"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    status=[dict integerForKey:@"status"];
    content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
    
    if(status==2)
    {
        sgp=[dict doubleForKey:@"sgp"];
        award=[NSString stringWithStringDefault:[dict objectForKey:@"award"]];
        time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
        shopName=[NSString stringWithStringDefault:[dict objectForKey:@"shop_name"]];
        totalSGP=[dict doubleForKey:@"total_sgp"];
    }
}

@end
