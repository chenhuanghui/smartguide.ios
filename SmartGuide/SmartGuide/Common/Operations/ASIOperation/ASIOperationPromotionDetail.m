//
//  ASIOperationPromotionDetail.m
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPromotionDetail.h"
#import "Shop.h"
#import "PromotionDetail.h"
#import "PromotionRequire.h"

@implementation ASIOperationPromotionDetail
@synthesize values,shop;

-(ASIOperationPromotionDetail*) initWithIDShop:(int) idShop idUser:(int) idUser
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_SHOP_PROMOTION_DETAIL)];
    self=[super initWithURL:_url];
    
    values=@[@(idShop),@(idUser)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"shop_id",@"user_id"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    shop=[Shop shopWithIDShop:[[values objectAtIndex:0] integerValue]];
    
    shop.promotionDetail=nil;
    
    PromotionDetail *detail=[PromotionDetail insert];
    detail.shop=shop;
    detail.promotionType=[dict objectForKey:@"promotion_type"];
    detail.sgp=[dict objectForKey:@"sgp"];
    detail.sp=[dict objectForKey:@"sp"];
    detail.cost=[dict objectForKey:@"cost"];
    detail.duration=[dict objectForKey:@"duration"];
    
    NSArray *array=[dict objectForKey:@"array_required"];
    for(NSDictionary *dictItem in array)
    {
        PromotionRequire *require=[PromotionRequire insert];
        require.promotion=detail;
        require.sgpRequired=[dictItem objectForKey:@"required"];
        require.content=[NSString stringWithStringDefault:[dictItem objectForKey:@"content"]];
    }
    
    [[DataManager shareInstance] save];
}

@end
