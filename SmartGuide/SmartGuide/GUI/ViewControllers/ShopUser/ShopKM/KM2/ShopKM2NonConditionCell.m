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
    float height=44.f;
    
    if(voucher.nameHeight.floatValue==-1)
        voucher.nameHeight=@([voucher.name sizeWithFont:[UIFont fontWithName:@"Georgia" size:14] constrainedToSize:CGSizeMake(228, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=voucher.nameHeight.floatValue;
    voucher.conditionHeight=@(0);
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM2NonConditionCell";
}

@end

@implementation UITableView(ShopKM2NonConditionCell)

-(void)registerShopKM2NonConditionCell
{
    [self registerNib:[UINib nibWithNibName:[ShopKM2NonConditionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM2NonConditionCell reuseIdentifier]];
}

-(ShopKM2NonConditionCell *)shopKM2NonConditionCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopKM2NonConditionCell reuseIdentifier]];
}

@end