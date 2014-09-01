//
//  ShopInfoTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopInfoTableCell.h"
#import "Label.h"
#import "ShopInfo.h"
#import "Utility.h"

@implementation ShopInfoTableCell

-(void)loadWithShop:(ShopInfo *)obj
{
    _obj=obj;
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ShopInfo *)obj
{
    lblName.text=obj.name;
    
    if(CGRectIsEmpty(obj.nameRect))
    {
        float x=imgvLogo.xw+imgvLogo.OX;
        lblName.frame=CGRectMake(x, imgvLogo.OY, self.SW-x-10, 0);
        [lblName defautSizeToFit];
        
        obj.nameRect=lblName.frame;
    }
    else
        lblName.frame=obj.nameRect;
    
    lblType.text=obj.shopTypeText;
    
    if(CGRectIsEmpty(obj.shopTypeRect))
    {
        lblType.frame=CGRectMake(lblName.OX, lblName.yh+5, lblName.SW, 0);
        [lblType defautSizeToFit];
        
        obj.shopTypeRect=lblType.frame;
    }
    else
        lblType.frame=obj.shopTypeRect;
    
    line.O=CGPointMake(0, imgvLogo.yh+imgvLogo.OY);
    
    return line.yh;
}

+(NSString *)reuseIdentifier
{
    return @"ShopInfoTableCell";
}

+(float)height
{
    return 111;
}

@end

#import <objc/runtime.h>
static char ShopInfoTablePrototypeCellKey;
@implementation UITableView(ShopInfoTableCell)

-(void) registerShopInfoTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopInfoTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopInfoTableCell reuseIdentifier]];
}

-(ShopInfoTableCell*) shopInfoTableCell
{
    ShopInfoTableCell *cell=[self dequeueReusableCellWithIdentifier:[ShopInfoTableCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ShopInfoTableCell *)ShopInfoTablePrototypeCell
{
    ShopInfoTableCell *cell=objc_getAssociatedObject(self, &ShopInfoTablePrototypeCellKey);
    
    if(!cell)
    {
        cell=[self dequeueReusableCellWithIdentifier:[ShopInfoTableCell reuseIdentifier]];
        objc_setAssociatedObject(self, &ShopInfoTablePrototypeCellKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end