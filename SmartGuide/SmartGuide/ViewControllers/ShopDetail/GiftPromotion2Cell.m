//
//  GiftPromotion2Cell.m
//  SmartGuide
//
//  Created by MacMini on 10/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GiftPromotion2Cell.h"
#import "Utility.h"

@implementation GiftPromotion2Cell

-(void)setReward:(NSString *)reward p:(NSString *)p numberVoucher:(NSString *)numberVoucher
{
    lblReward.backgroundColor=[UIColor clearColor];
    lblReward.font=[UIFont boldSystemFontOfSize:12];
    lblReward.textAlignment=NSTextAlignmentCenter;
    lblReward.textColor=[UIColor blackColor];
    
    [lblReward setText:reward];
    
    [lblReward scrollLabelIfNeeded];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.font=[UIFont italicSystemFontOfSize:11];
    style.color=[UIColor blackColor];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"p"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor color255WithRed:201 green:84 blue:54 alpha:255];
    style.font=[UIFont boldSystemFontOfSize:11];
    
    [lblP addStyle:style];
    
    lblP.backgroundColor=[UIColor clearColor];
    
    lblVoucherNumber.text=[NSString stringWithFormat:@"%@", numberVoucher];
    
    [self setP:p];
}

-(void)setLineVisible:(bool)isVisible
{
    line.hidden=!isVisible;
}

-(void) setP:(NSString*) p
{
    [lblP setText:[NSString stringWithFormat:@"<text>Tích luỹ <p>%@P</p> trên 1 lượt quét thẻ</text>",p]];
}

+(CGSize)size
{
    return CGSizeMake(222, 67);
}

+(NSString *)reuseIdentifier
{
    return @"GiftPromotion2Cell";
}

@end
