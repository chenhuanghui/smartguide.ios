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
    
    CGSize size=[content sizeWithFont:font constrainedToSize:CGSizeMake(SHOP_KM1_CONTENT_WIDTH, 999999) lineBreakMode:NSLineBreakByTruncatingTail];
   
    return size.height+10;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    containView.layer.cornerRadius=8;
}

@end
