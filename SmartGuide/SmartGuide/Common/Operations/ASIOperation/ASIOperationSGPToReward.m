//
//  ASIOperationSGPToReward.m
//  SmartGuide
//
//  Created by XXX on 8/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationSGPToReward.h"
#import "Shop.h"

@implementation ASIOperationSGPToReward
@synthesize status,sgp,award,time,shopName,content,values,totalSGP,code,idShop;

-(ASIOperationSGPToReward *)initWithIDUser:(int)idUser idRewward:(int)idReward code:(NSString *)_code idShop:(int)idShop
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SGP_TO_REWARD)];
    self=[super initWithURL:_url];

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
    code=[self.values objectAtIndex:2];
    
    if(status==2)
    {
        idShop=[[NSNumber numberWithObject:[dict objectForKey:@"shop_id"]] integerValue];
        Shop *shop=[Shop shopWithIDShop:idShop];
        totalSGP=[dict doubleForKey:@"total_sgp"];
        
        if(shop)
        {
        }
        
        sgp=[dict doubleForKey:@"sgp"];
        award=[NSString stringWithStringDefault:[dict objectForKey:@"award"]];
        time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
        shopName=[NSString stringWithStringDefault:[dict objectForKey:@"shop_name"]];
    }
}

@end
