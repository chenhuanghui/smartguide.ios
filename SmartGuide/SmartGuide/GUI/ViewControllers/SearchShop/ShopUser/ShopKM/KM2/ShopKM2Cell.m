//
//  ShopKM2Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopKM2Cell.h"
#import "Utility.h"

@implementation ShopKM2Cell

-(void)loadWithKM2:(KM2Voucher *)voucher
{
    _voucher=voucher;
    
    lblType.text=voucher.type;
    lblTitle.text=voucher.name;
    
    if(voucher.highlightKeywords.length==0)
        [lblCondition setText:[voucher.condition stringByAppendingTagName:@"text"]];
    else
        [lblCondition highlightWithText:voucher.condition pairs:voucher.highlightKeywords normalStyleName:@"text" styleBoldName:@"bold"];
    
    icon.highlighted=voucher.isAfford.integerValue==0;
    
    [lblCondition l_v_setY:lblTitle.l_v_y+voucher.nameHeight+12];
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM2Cell";
}

+(float)heightWithKM2:(KM2Voucher *)voucher
{
    voucher.voucherHeight=65;
    
    voucher.nameHeight=[voucher.name sizeWithFont:[UIFont fontWithName:@"Georgia" size:14] constrainedToSize:CGSizeMake(189, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    voucher.voucherHeight+=MAX(voucher.nameHeight-16,0);
    
    voucher.conditionHeight=[voucher.condition sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:11] constrainedToSize:CGSizeMake(189, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    voucher.voucherHeight+=MAX(voucher.conditionHeight-16,0);
    
    return voucher.voucherHeight;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.color=[UIColor colorWithRed:0.608 green:0.608 blue:0.608 alpha:1];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:11];
    style.textAlignment=FTCoreTextAlignementCenter;
    
    [lblCondition addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"bold"];
    style.color=[UIColor redColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:11];
    style.textAlignment=FTCoreTextAlignementCenter;
    
    [lblCondition addStyle:style];
    
    lblTitle.alignTextY=1;
}

@end