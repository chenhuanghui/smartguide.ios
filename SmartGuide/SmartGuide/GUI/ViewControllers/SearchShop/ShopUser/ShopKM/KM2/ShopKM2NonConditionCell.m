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
    if(voucher.voucherHeight.floatValue!=-1)
        return voucher.voucherHeight.floatValue;
    
    float height=44;
    
    if(voucher.nameHeight.floatValue==-1)
        voucher.nameHeight=@([voucher.name sizeWithFont:[UIFont fontWithName:@"Georgia" size:14] constrainedToSize:CGSizeMake(198, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=voucher.nameHeight.floatValue;
    voucher.conditionHeight=0;
    
    voucher.voucherHeight=@(height);
    
    return voucher.voucherHeight.floatValue;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM2NonConditionCell";
}

@end
