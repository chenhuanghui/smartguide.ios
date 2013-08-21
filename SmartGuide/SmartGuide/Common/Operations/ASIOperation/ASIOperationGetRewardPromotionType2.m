//
//  ASIOperaionGetReward.m
//  SmartGuide
//
//  Created by XXX on 8/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetRewardPromotionType2.h"

@implementation ASIOperationGetRewardPromotionType2
@synthesize values,status,money,time,shopName,content,code;

-(ASIOperationGetRewardPromotionType2 *)initWithIDUser:(int)idUser promotionID:(int)promotionID code:(NSString *)_code
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_REWARD)];
    
    self=[super initWithURL:_url];
    
    code=[[NSString alloc] initWithString:_code];
    values=@[@(idUser),@(promotionID),_code];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"promotion_2_id",@"code"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    status=[dict boolForKey:@"status"];
    content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
    
    if(status)
    {
        time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
        shopName=[NSString stringWithStringDefault:[dict objectForKey:@"shop_name"]];
        money=[dict doubleForKey:@"money"];
    }
}
@end
