//
//  ShopKM1Cel.m
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopKM1Cell.h"

#define SHOP_KM1_FONT [UIFont fontWithName:@"Futura-Medium" size:14]
#define SHOP_KM1_CONTENT_WIDTH 198.f

@implementation ShopKM1Cell

-(void)setVoucher:(NSString *)voucher content:(NSString *)content sgp:(NSString *)sgp isHighlighted:(bool)isHighlighted
{
    lblVoucher.text=voucher;
    lblContent.text=content;
    lblSGP.text=sgp;
    imgvFlag.highlighted=isHighlighted;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM1Cell";
}

+(float)heightWithContent:(NSString *)content
{
    UIFont *font=SHOP_KM1_FONT;
    
    CGSize size=[content sizeWithFont:font constrainedToSize:CGSizeMake(SHOP_KM1_CONTENT_WIDTH, 9999) lineBreakMode:NSLineBreakByTruncatingTail];
   
    return MAX(42, size.height+10);
}

@end

@implementation ShopKM1ContentView

-(void)drawRect:(CGRect)rect
{
    [imgHead drawAtPoint:CGPointZero];
    [imgMid drawAsPatternInRect:CGRectMake(0, imgHead.size.height, rect.size.width, rect.size.height-imgHead.size.height-imgBot.size.height)];
    [imgBot drawAtPoint:CGPointMake(0, rect.size.height-imgBot.size.height)];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    imgMid=[UIImage imageNamed:@"bg_content_mid.png"];
    imgHead=[UIImage imageNamed:@"bg_content_head.png"];
    imgBot=[UIImage imageNamed:@"bg_content_bottom.png"];
}

-(void)dealloc
{
    imgBot=nil;
    imgHead=nil;
    imgMid=nil;
}

@end