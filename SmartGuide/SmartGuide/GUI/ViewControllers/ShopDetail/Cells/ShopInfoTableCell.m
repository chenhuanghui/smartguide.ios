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
#import "ImageManager.h"

@implementation ShopInfoTableCell

-(void)loadWithShop:(ShopInfo *)obj
{
    _obj=obj;
    
    [imgvLogo defaultLoadImageWithURL:_obj.logo];
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ShopInfo *)obj
{
    lblName.text=obj.name;
    
    if(CGRectIsEmpty(obj.nameRect))
    {
        float x=imageBorder.xw+imageBorder.OX;
        lblName.frame=CGRectMake(x, imageBorder.OY, self.SW-x-10, 0);
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
    
    line.O=CGPointMake(0, imageBorder.yh+imageBorder.OY);
    
    return line.yh;
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    [self calculatorHeight:_obj];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    imgvLogo.layer.masksToBounds=true;
    imgvLogo.layer.cornerRadius=8;
    imageBorder.backgroundColor=[UIColor clearColor];
    imageBorder.layer.borderWidth=3;
    imageBorder.layer.borderColor=[UIColor whiteColor].CGColor;
    imageBorder.layer.cornerRadius=imgvLogo.layer.cornerRadius;
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