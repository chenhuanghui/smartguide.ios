//
//  ShopContactTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopContactTableCell.h"

@implementation ShopContactTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopContactTableCell";
}

@end

@implementation UITableView(ShopContactTableCell)

-(void) registerShopContactTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopContactTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopContactTableCell reuseIdentifier]];
}

-(ShopContactTableCell*) shopContactTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopContactTableCell reuseIdentifier]];
}

@end