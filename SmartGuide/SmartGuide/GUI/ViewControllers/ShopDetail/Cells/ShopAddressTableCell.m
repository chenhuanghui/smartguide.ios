//
//  ShopAddressTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopAddressTableCell.h"
#import "Label.h"
#import "ShopInfo.h"
#import "Utility.h"
#import "Button.h"

@implementation ShopAddressTableCell

-(void)loadWithShopInfo:(ShopInfo *)obj
{
    _object=obj;
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ShopInfo *)obj
{
    lblDiaChi.frame=CGRectMake(10, 10, self.SW, 0);
    [lblDiaChi defautSizeToFit];
    
    lblAddress.text=obj.address;
    
    if(CGRectIsEmpty(obj.addressRect))
    {
        float x=lblDiaChi.OX;
        lblAddress.frame=CGRectMake(x, lblDiaChi.yh+5, self.SW-x*2, 0);
        [lblAddress defautSizeToFit];
        
        obj.addressRect=lblAddress.frame;
    }
    else
        lblAddress.frame=obj.addressRect;
    
    btn.OY=lblAddress.yh+20;
    line.frame=CGRectMake(0, btn.yh+20, self.SW, 2);
    
    return line.yh;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    btn.layoutType=BUTTON_LAYOUT_TYPE_RED_BORDER;
}

+(NSString *)reuseIdentifier
{
    return @"ShopAddressTableCell";
}

+(float)height
{
    return 255;
}

@end

#import <objc/runtime.h>
static char ShopAddressTablePrototypeCell;
@implementation UITableView(ShopAddressTableCell)

-(void) registerShopAddressTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopAddressTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopAddressTableCell reuseIdentifier]];
}

-(ShopAddressTableCell*) shopAddressTableCell
{
    ShopAddressTableCell *cell=[self dequeueReusableCellWithIdentifier:[ShopAddressTableCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ShopAddressTableCell *)shopAddressTablePrototypeCell
{
    ShopAddressTableCell *cell=objc_getAssociatedObject(self, &ShopAddressTablePrototypeCell);
    
    if(!cell)
    {
        cell=[self shopAddressTableCell];
        objc_setAssociatedObject(self, &ShopAddressTablePrototypeCell, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end