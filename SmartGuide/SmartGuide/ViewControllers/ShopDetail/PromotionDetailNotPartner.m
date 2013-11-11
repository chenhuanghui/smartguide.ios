//
//  PromotionDetailNotPartner.m
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailNotPartner.h"

@implementation PromotionDetailNotPartner
@synthesize handler;

-(PromotionDetailNotPartner *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"PromotionDetailNotPartner") owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    return self;
}

-(void)setShop:(Shop *)shop
{
    if(!shop)
    {
        [self reset];
        return;
    }
    
    _shop=shop;
}

-(void)reset
{
    _shop=nil;
}

-(void)reloadWithShop:(Shop *)shop
{
    [self setShop:shop];
}

@end
