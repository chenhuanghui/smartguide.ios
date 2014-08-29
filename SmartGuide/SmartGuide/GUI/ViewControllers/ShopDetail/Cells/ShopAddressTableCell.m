//
//  ShopAddressTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopAddressTableCell.h"

@implementation ShopAddressTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopAddressTableCell";
}

@end

@implementation UITableView(ShopAddressTableCell)

-(void) registerShopAddressTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopAddressTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopAddressTableCell reuseIdentifier]];
}

-(ShopAddressTableCell*) shopAddressTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopAddressTableCell reuseIdentifier]];
}

@end