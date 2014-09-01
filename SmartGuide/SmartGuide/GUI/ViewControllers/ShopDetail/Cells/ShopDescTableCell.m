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

+(float)height
{
    return 195;
}

@end

#import <objc/runtime.h>
static char ShopDescTablePrototypeCell;
@implementation UITableView(ShopDescTableCell)

-(void) registerShopDescTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopDescTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDescTableCell reuseIdentifier]];
}

-(ShopDescTableCell*) shopDescTableCell
{
    ShopDescTableCell *cell=[self dequeueReusableCellWithIdentifier:[ShopDescTableCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ShopDescTableCell *)shopDescTablePrototypeCell
{
    ShopDescTableCell *cell=objc_getAssociatedObject(self, &ShopDescTablePrototypeCell);
    
    if(!cell)
    {
        cell=[self shopDescTableCell];
        objc_setAssociatedObject(cell, &ShopDescTablePrototypeCell, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end