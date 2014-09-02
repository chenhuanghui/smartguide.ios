//
//  ShopEventTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopEventTableCell.h"
#import "ShopInfo.h"
#import "ShopInfoEvent.h"
#import "Utility.h"
#import "Label.h"
#import "ImageManager.h"
#import "Button.h"

@implementation ShopEventTableCell

-(void)loadWithEvent:(ShopInfoEvent *)obj
{
    _object=obj;
    
    [self loadImages:_object];
    
    [self setNeedsLayout];
}

+(NSString *)reuseIdentifier
{
    return @"ShopEventTableCell";
}

+(float)height
{
    return 294;
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_object];
}

-(void) loadImages:(ShopInfoEvent*) obj
{
    imgvImage.hidden=false;
    if(obj.video.length>0)
        [imgvImage defaultLoadImageWithURL:obj.videoThumbnail];
    else if(obj.image.length>0)
        [imgvImage defaultLoadImageWithURL:obj.image];
    else
        imgvImage.hidden=true;
}

-(float)calculatorHeight:(ShopInfoEvent *)obj
{
    lblDuration.text=obj.duration;
    
    if(obj.video.length>0)
    {
        imgvImage.O=CGPointMake(10, lblDuration.yh+5);
        imgvImage.S=CGSizeResizeToWidth(300, CGSizeMake(obj.videoWidth.floatValue, obj.videoHeight.floatValue));
    }
    else if(obj.image.length>0)
    {
        imgvImage.O=CGPointMake(10, lblDuration.yh+5);
        imgvImage.S=CGSizeResizeToWidth(300, CGSizeMake(obj.imageWidth.floatValue, obj.imageHeight.floatValue));
    }
    else
    {
        imgvImage.O=CGPointMake(10, lblDuration.yh);
        imgvImage.S=CGSizeZero;
    }
    
    float y=imgvImage.yh;
    
    if(imgvImage.SH>0)
        y+=5;
    
    lblTitle.text=obj.title;
    
    if(CGRectIsEmpty(obj.titleRect))
    {
        lblTitle.frame=CGRectMake(imgvImage.OX, y, self.SW-imgvImage.OX*2, 0);
        [lblTitle defautSizeToFit];
        
        obj.titleRect=lblTitle.frame;
    }
    else
        lblTitle.frame=obj.titleRect;
    
    y=lblTitle.yh;
    if(lblTitle.SH>0)
        y+=5;
    
    lblContent.attributedText=attributedStringJustified(obj.content, lblContent.font);
    
    if(CGRectIsEmpty(obj.contentRect))
    {
        lblContent.frame=CGRectMake(imgvImage.OX, y, self.SW-imgvImage.OX*2, 0);
        [lblContent defautSizeToFit];
        
        obj.contentRect=lblContent.frame;
    }
    else
        lblContent.frame=obj.contentRect;

    NSString *btnText=@"Sự kiện đã diễn ra";

    [btn setTitle:btnText forState:UIControlStateNormal];
    btn.O=CGPointMake(10, lblContent.yh+20);
    btn.S=CGSizeMake(self.SW-btn.OX*2, 44);
    
    line.OY=btn.yh+20;
    
    return line.yh;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    btn.layoutType=BUTTON_LAYOUT_TYPE_RED_BORDER;
}

@end

#import <objc/runtime.h>
static char ShopEventTablePrototypeCellKey;
@implementation UITableView(ShopEventTableCell)

-(void) registerShopEventTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopEventTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopEventTableCell reuseIdentifier]];
}

-(ShopEventTableCell*) shopEventTableCell
{
    ShopEventTableCell *cell=[self dequeueReusableCellWithIdentifier:[ShopEventTableCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ShopEventTableCell*) shopEventTablePrototypeCell
{
    ShopEventTableCell *cell=objc_getAssociatedObject(self, &ShopEventTablePrototypeCellKey);
    
    if(!cell)
    {
        cell=[self shopEventTableCell];
        objc_setAssociatedObject(self, &ShopEventTablePrototypeCellKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    cell.isPrototypeCell=true;
    
    return cell;
}

@end