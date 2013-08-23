//
//  ASIOperationGetSGP.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationGetSGP.h"
#import "Shop.h"
#import "PromotionDetail.h"

@implementation ASIOperationGetSGP
@synthesize values,status,content,time,shopName,SGP,totalSGP,code;

-(ASIOperationGetSGP *)initWithUserID:(int)idUser code:(NSString *)_code idShop:(int)idShop
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_GET_SGP)];
    
    self=[super initWithURL:_url];
    
    code=[[NSString alloc] initWithString:_code];
    _idShop=idShop;
    values=@[@(idUser),code];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"user_id",@"code"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    status=[dict integerForKey:@"status"];
    content=[dict objectForKey:@"content"];
    
    if(status==2)
    {
        shopName=[dict objectForKey:@"shop_name"];
        SGP=[dict integerForKey:@"sgp"];
        time=[dict objectForKey:@"time"];
        totalSGP=[[dict objectForKey:@"total_sgp"] doubleValue];
        
        Shop *shop=[Shop shopWithIDShop:_idShop];
        
        if(shop)
        {
            if(shop.promotionDetail && shop.promotionDetail.promotionType.integerValue==1)
            {
                shop.promotionDetail.sgp=@(totalSGP);
                
                [[DataManager shareInstance] save];
            }
        }
    }
}

@end
