//
//  ListShopPlacelistTableCell.m
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ListShopPlacelistTableCell.h"
#import "Label.h"
#import "Place.h"
#import "Utility.h"
#import "ImageManager.h"

@implementation ListShopPlacelistTableCell

-(void)loadWithPlace:(Place *)place
{
    _object=place;
    
    [imgvAvatar defaultLoadImageWithURL:place.authorAvatar];
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
}

-(float)calculatorHeight:(Place *)place
{
    lblDesc.attributedText=attributedStringJustified(place.desc, lblDesc.font);
    
    if(CGRectIsEmpty(place.descRect))
    {
        lblDesc.frame=CGRectMake(10, 20, self.SW-20, 0);
        [lblDesc defautSizeToFit];
        
        place.descRect=lblDesc.frame;
    }
    else
        lblDesc.frame=place.descRect;
    
    line1.frame=CGRectMake(0, lblDesc.yh+5, self.SW, 2);
    
    imgvAvatar.O=CGPointMake(5, line1.yh+5);
    lblDanhSach.text=@"Danh sách được tạo bởi";
    lblDanhSach.O=CGPointMake(imgvAvatar.xw+5, imgvAvatar.OY);
    
    lblName.text=place.authorName;
    
    if(CGRectIsEmpty(place.nameRect))
    {
        lblName.frame=CGRectMake(lblDanhSach.OX, lblDanhSach.yh+5, self.SW-lblDanhSach.OX-10, 0);
        [lblName defautSizeToFit];
        
        place.nameRect=lblName.frame;
    }
    else
        lblName.frame=place.nameRect;
    
    line2.frame=CGRectMake(0, MAX(lblName.yh, imgvAvatar.yh)+5, self.SW, 2);
    
    return line2.yh+20;
}

+(NSString *)reuseIdentifier
{
    return @"ListShopPlacelistTableCell";
}

@end

#import <objc/runtime.h>

static char ListShopPlacelistTablePrototypeCell;
@implementation UITableView(ListShopPlacelistTableCell)

-(void) registerListShopPlacelistTableCell
{
    [self registerNib:[UINib nibWithNibName:[ListShopPlacelistTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ListShopPlacelistTableCell reuseIdentifier]];
}

-(ListShopPlacelistTableCell*) listShopPlacelistTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ListShopPlacelistTableCell reuseIdentifier]];
}

-(ListShopPlacelistTableCell *) listShopPlacelistTablePrototypeCell
{
    ListShopPlacelistTableCell *cell=objc_getAssociatedObject(self, &ListShopPlacelistTablePrototypeCell);
    
    if(!cell)
    {
        cell=[self listShopPlacelistTableCell];
        objc_setAssociatedObject(self, &ListShopPlacelistTablePrototypeCell, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end