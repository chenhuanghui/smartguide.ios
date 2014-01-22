//
//  ShopKM2NonConditionCell.m
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopKM2NonConditionCell.h"

@implementation ShopKM2NonConditionCell

-(void)loadWithVoucher:(KM2Voucher *)voucher
{
    _voucher=voucher;
    
    lblType.text=voucher.type;
    lblTitle.text=voucher.name;
    icon.highlighted=voucher.isAfford.integerValue==0;
}

+(float)heightWithVoucher:(KM2Voucher *)voucher
{
    voucher.voucherHeight=44;
    
    voucher.nameHeight=[voucher.name sizeWithFont:[UIFont fontWithName:@"Georgia" size:14] constrainedToSize:CGSizeMake(198, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    voucher.voucherHeight+=voucher.nameHeight;
    
    voucher.conditionHeight=0;
    
    return voucher.voucherHeight;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM2NonConditionCell";
}

@end
