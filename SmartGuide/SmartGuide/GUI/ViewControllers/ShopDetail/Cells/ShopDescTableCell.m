//
//  ShopInfoTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDescTableCell.h"
#import "ShopInfo.h"
#import "Label.h"
#import "Utility.h"

@implementation ShopDescTableCell

-(void)loadWithShopInfo:(ShopInfo *)obj
{
    _object=obj;
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ShopInfo *)obj
{
    lblThongTin.frame=CGRectMake(10, 10, self.SW, 0);
    [lblThongTin defautSizeToFit];
    
    lblDesc.attributedText=[[NSAttributedString alloc] initWithString:obj.desc attributes:@{NSFontAttributeName:lblDesc.font
                                                                                            , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
    
    if(CGRectIsEmpty(obj.descRect))
    {
        float x=10;
        lblDesc.frame=CGRectMake(x, lblThongTin.yh+5, self.SW-x*2, 0);
        [lblDesc defautSizeToFit];
        
        obj.descRect=lblDesc.frame;
    }
    else
        lblDesc.frame=obj.descRect;
    
    line.frame=CGRectMake(0, lblDesc.yh+5, self.SW, 2);
    
    return line.yh;
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
}

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