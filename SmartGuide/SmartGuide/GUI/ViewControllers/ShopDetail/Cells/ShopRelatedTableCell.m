//
//  ShopRelatedTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopRelatedTableCell.h"

@implementation ShopRelatedTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopRelatedTableCell";
}

+(float)height
{
    return 160;
}

@end

@implementation UITableView(ShopRelatedTableCell)

-(void) registerShopRelatedTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopRelatedTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopRelatedTableCell reuseIdentifier]];
}

-(ShopRelatedTableCell*) shopRelatedTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopRelatedTableCell reuseIdentifier]];
}

@end