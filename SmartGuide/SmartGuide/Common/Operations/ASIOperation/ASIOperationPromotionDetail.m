//
//  ASIOperationPromotionDetail.m
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPromotionDetail.h"
#import "Shop.h"

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
    
    NSLog(@"%@ %@",CLASS_NAME,dict);
}

@end
