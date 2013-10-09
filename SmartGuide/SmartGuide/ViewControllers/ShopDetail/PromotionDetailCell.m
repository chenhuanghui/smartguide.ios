//
//  PromotionDetailCell.m
//  SmartGuide
//
//  Created by XXX on 8/1/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailCell.h"
#import "PromotionDetail.h"

@implementation PromotionDetailCell

-(void)setPromotionRequire:(PromotionRequire *)require
{
    lblSgp.text=[NSString stringWithFormat:@"%02d",require.sgpRequired.integerValue];
    
    [lblContent setText:require.content];
    [lblContent setTextAlignment:NSTextAlignmentCenter];
    [lblContent setTextColor:[UIColor whiteColor]];
    [lblContent setFont:[UIFont boldSystemFontOfSize:12]];
    lblContent.scrollDirection=CBAutoScrollDirectionLeft;
    
    [lblContent scrollLabelIfNeeded];
    
    bar.highlighted=require.promotion.sgp.longLongValue>=require.sgpRequired.longLongValue;
    
    lblNumberVoucher.text=require.numberVoucher;
}

+(NSString *)reuseIdentifier
{
    return @"PromotionDetailCell";
}

+(float)height
{
    return 36;
}

@end
