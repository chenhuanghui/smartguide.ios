//
//  ScanResultObjectCell.m
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultObjectCell.h"
#import "ScanCodeRelated.h"
#import "ImageManager.h"
#import "Label.h"
#import "Utility.h"

@implementation ScanResultObjectCell

-(void) loadWithRelated:(ScanCodeRelated *)obj
{
    _object=obj;
    
    switch (_object.enumType) {
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            [imgvLogo defaultLoadImageWithURL:_object.authorAvatar];
            break;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
            [imgvLogo defaultLoadImageWithURL:_object.logo];
            break;
            
        case SCANCODE_RELATED_TYPE_SHOPS:
            [imgvLogo defaultLoadImageWithURL:_object.logo];
            break;
            
        case SCANCODE_RELATED_TYPE_UNKNOW:
            break;
    }
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(ScanCodeRelated *)obj
{
    switch (obj.enumType) {
        case SCANCODE_RELATED_TYPE_PLACELISTS:
            
            imgvLogo.O=CGPointMake(12, 12);
            lblTitle.text=obj.placelistName;
            
            if(CGRectIsZero(obj.nameRect))
            {
                float x=imgvLogo.xw+5;
                lblTitle.frame=CGRectMake(x, imgvLogo.OY, self.SW-x*2-10, 0);
                [lblTitle defautSizeToFit];
                
                obj.nameRect=lblTitle.frame;
            }
            else
                lblTitle.frame=obj.nameRect;
            
            lblContent.text=obj.desc;
            
            float y=lblTitle.yh;
            
            if(lblTitle.yh>0)
                y+=5;
            
            if(CGRectIsZero(obj.descRect))
            {
                lblContent.frame=CGRectMake(lblTitle.OX, y, self.SW-lblTitle.OX*2-10, 0);
                [lblContent defautSizeToFit];
                
                obj.descRect=lblContent.frame;
            }
            else
                lblContent.frame=obj.descRect;
            
            if(lblContent.yh>imgvLogo.yh)
            {
                imgvLogo.OY+=(lblContent.yh-imgvLogo.yh)/2;
            }
            
            line.frame=CGRectMake(10, imgvLogo.yh+5, self.SW-20, 1);
            imgvArrow.frame=CGRectMake(303, 0, 11, line.yh);
            
            return line.yh;
            
        case SCANCODE_RELATED_TYPE_PROMOTIONS:
        {
            imgvLogo.O=CGPointMake(12, 12);
            lblTitle.text=obj.promotionName;
            
            if(CGRectIsZero(obj.nameRect))
            {
                float x=imgvLogo.xw+5;
                lblTitle.frame=CGRectMake(x, imgvLogo.OY, self.SW-x*2-10, 0);
                [lblTitle defautSizeToFit];
                
                obj.nameRect=lblTitle.frame;
            }
            else
                lblTitle.frame=obj.nameRect;
            
            lblContent.text=obj.desc;
            
            float y=lblTitle.yh;
            
            if(lblTitle.yh>0)
                y+=5;
            
            if(CGRectIsZero(obj.descRect))
            {
                lblContent.frame=CGRectMake(lblTitle.OX, y, self.SW-lblTitle.OX*2-10, 0);
                [lblContent defautSizeToFit];
                
                obj.descRect=lblContent.frame;
            }
            else
                lblContent.frame=obj.descRect;
            
            if(lblContent.yh>imgvLogo.yh)
            {
                imgvLogo.OY+=(lblContent.yh-imgvLogo.yh)/2;
            }
            
            line.frame=CGRectMake(10, imgvLogo.yh+5, self.SW-20, 1);
            imgvArrow.frame=CGRectMake(303, 0, 11, line.yh);
            
            return line.yh;
        }
            
            case SCANCODE_RELATED_TYPE_SHOPS:
        {
            imgvLogo.O=CGPointMake(12, 12);
            lblTitle.text=obj.shopName;
            
            if(CGRectIsZero(obj.nameRect))
            {
                float x=imgvLogo.xw+5;
                lblTitle.frame=CGRectMake(x, imgvLogo.OY, self.SW-x*2-10, 0);
                [lblTitle defautSizeToFit];
                
                obj.nameRect=lblTitle.frame;
            }
            else
                lblTitle.frame=obj.nameRect;
            
            lblContent.text=obj.desc;
            
            float y=lblTitle.yh;
            
            if(lblTitle.yh>0)
                y+=5;
            
            if(CGRectIsZero(obj.descRect))
            {
                lblContent.frame=CGRectMake(lblTitle.OX, y, self.SW-lblTitle.OX*2-10, 0);
                [lblContent defautSizeToFit];
                
                obj.descRect=lblContent.frame;
            }
            else
                lblContent.frame=obj.descRect;
            
            if(lblContent.yh>imgvLogo.yh)
            {
                imgvLogo.OY+=(lblContent.yh-imgvLogo.yh)/2;
            }
            
            line.frame=CGRectMake(10, imgvLogo.yh+5, self.SW-20, 1);
            imgvArrow.frame=CGRectMake(303, 0, 11, line.yh);
            
            return line.yh;
        }
            
        case SCANCODE_RELATED_TYPE_UNKNOW:
            return 0;
    }
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
    return @"ScanResultObjectCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];

    [imgvLogo.layer setBorderWidth:1];
    [imgvLogo.layer setBorderColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5f].CGColor];
}

@end

#import <objc/runtime.h>
static char ScanResultObjectPrototypeCell;
@implementation UITableView(ScanResultObjectCell)

-(void)registerScanResultObjectCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultObjectCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultObjectCell reuseIdentifier]];
}

-(ScanResultObjectCell *)scanResultObjectCell
{
    ScanResultObjectCell *cell=[self dequeueReusableCellWithIdentifier:[ScanResultObjectCell reuseIdentifier]];
    
    cell.isPrototypeCell=false;
    
    return cell;
}

-(ScanResultObjectCell *)scanResultObjectPrototypeCell
{
    ScanResultObjectCell *obj=objc_getAssociatedObject(self, &ScanResultObjectPrototypeCell);
    
    if(!obj)
    {
        obj=[self scanResultObjectCell];
        objc_setAssociatedObject(self, &ScanResultObjectPrototypeCell, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end