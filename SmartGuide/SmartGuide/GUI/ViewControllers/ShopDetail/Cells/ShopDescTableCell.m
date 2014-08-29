//
//  ShopInfoTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDescTableCell.h"

@implementation ShopDescTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopDescTableCell";
}

@end

@implementation UITableView(ShopDescTableCell)

-(void) registerShopDescTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopDescTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDescTableCell reuseIdentifier]];
}

-(ShopDescTableCell*) shopDescTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopDescTableCell reuseIdentifier]];
}

@end