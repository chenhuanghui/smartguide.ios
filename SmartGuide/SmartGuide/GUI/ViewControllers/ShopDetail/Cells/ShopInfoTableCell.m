//
//  ShopInfoTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopInfoTableCell.h"

@implementation ShopInfoTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopInfoTableCell";
}

@end

@implementation UITableView(ShopInfoTableCell)

-(void) registerShopInfoTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopInfoTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopInfoTableCell reuseIdentifier]];
}

-(ShopInfoTableCell*) shopInfoTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopInfoTableCell reuseIdentifier]];
}

@end