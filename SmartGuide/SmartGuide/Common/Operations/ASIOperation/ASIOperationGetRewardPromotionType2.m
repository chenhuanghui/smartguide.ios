//
//  ASIOperaionGetReward.m
//  SmartGuide
//
//  Created by XXX on 8/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetRewardPromotionType2.h"

@implementation ASIOperationGetRewardPromotionType2
@synthesize values,status,money,time,shopName,content,code,idShop;

-(ASIOperationGetRewardPromotionType2 *)initWithIDUser:(int)idUser promotionID:(int)promotionID code:(NSString *)_code lat:(double)lat lon:(double)lon
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_REWARD)];
    
    self=[super initWithURL:_url];
    
    values=@[@(idUser),@(promotionID),_code,@(lat),@(lon)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"promotion_2_id",@"code",@"user_lat",@"user_lng"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    status=[dict integerForKey:@"status"];
    content=[NSString stringWithStringDefault:[dict objectForKey:@"content"]];
    code=[self.values objectAtIndex:2];
    
    if(status==1)
    {
        time=[NSString stringWithStringDefault:[dict objectForKey:@"time"]];
        shopName=[NSString stringWithStringDefault:[dict objectForKey:@"shop_name"]];
        money=[dict doubleForKey:@"money"];
        idShop  =[[NSNumber numberWithObject:[dict objectForKey:@"shop_id"]] integerValue];
    }
}
@end
