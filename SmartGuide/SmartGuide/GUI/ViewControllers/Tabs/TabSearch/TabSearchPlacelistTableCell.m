//
//  TabSearchPlacelistTableCell.m
//  Infory
//
//  Created by XXX on 8/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabSearchPlacelistTableCell.h"
#import "Label.h"
#import "Utility.h"
#import "SearchPlacelist.h"
#import "ImageManager.h"

@implementation TabSearchPlacelistTableCell

-(void)loadWithPlacelist:(SearchPlacelist *)obj
{
    _obj=obj;

    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_obj];
    
    [imgvImage defaultLoadImageWithURL:_obj.image];
}

-(float)calculatorHeight:(SearchPlacelist *)obj
{
    imgvImage.frame=CGRectMake(15, 0, 60, 0);
    
    lblTitle.OX=imgvImage.xw+5;
    lblTitle.frame=CGRectMake(lblTitle.OX, imgvImage.OY, self.SW-lblTitle.OX-10, 0);
    
    lblTitle.text=obj.title;
    
    [lblTitle defautSizeToFit];
    
    lblContent.OX=imgvImage.xw+5;
    lblContent.frame=CGRectMake(lblContent.OX, lblTitle.yh+5, self.SW-lblContent.OX-10, 0);
    lblContent.attributedText=[[NSAttributedString alloc] initWithString:obj.desc
                                                              attributes:@{NSFontAttributeName:lblContent.font
                                                                           , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
    
    [lblContent defautSizeToFit];
    
    imgvImage.SH=lblContent.yh;
    
    imgvLine.O=CGPointMake(imgvImage.OX, imgvImage.yh+5);
    imgvLine.SW=self.SW-imgvLine.OX*2;
    
    return imgvLine.yh+5;
}

+(NSString *)reuseIdentifier
{
    return @"TabSearchPlacelistTableCell";
}

@end

#import <objc/runtime.h>

static char TabSearchPlacelistTablePrototypeCellKey;
@implementation UITableView(TabSearchPlacelistTableCell)

-(void) registerTabSearchPlacelistTableCell
{
    [self registerNib:[UINib nibWithNibName:[TabSearchPlacelistTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TabSearchPlacelistTableCell reuseIdentifier]];
}

-(TabSearchPlacelistTableCell*) tabSearchPlacelistTableCell
{
    TabSearchPlacelistTableCell *cell=[self dequeueReusableCellWithIdentifier:[TabSearchPlacelistTableCell reuseIdentifier]];
    cell.isPrototypeCell=false;
    
    return cell;
}

-(TabSearchPlacelistTableCell *)tabSearchPlacelistTablePrototypeCell
{
    TabSearchPlacelistTableCell *obj=objc_getAssociatedObject(self, &TabSearchPlacelistTablePrototypeCellKey);
    
    if(!obj)
    {
        obj=[self tabSearchPlacelistTableCell];
        
        objc_setAssociatedObject(self, &TabSearchPlacelistTablePrototypeCellKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end