//
//  ShopEventTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopEventTableCell.h"

@implementation ShopEventTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopEventTableCell";
}

+(float)height
{
    return 294;
}

@end

@implementation UITableView(ShopEventTableCell)

-(void) registerShopEventTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopEventTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopEventTableCell reuseIdentifier]];
}

-(ShopEventTableCell*) shopEventTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopEventTableCell reuseIdentifier]];
}

@end