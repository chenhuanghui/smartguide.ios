//
//  TabHomeShopCell.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabHomeShopCell.h"
#import "Event.h"
#import "HomeShop.h"
#import "ImageManager.h"
#import "Utility.h"
#import "Constant.h"
#import "Label.h"
#import "ShopInfo.h"

@implementation TabHomeShopCell

-(void)loadWithEvent:(Event *)obj
{
    _object=obj;
    
    [self loadImage];
}

-(void) loadWithHomeShop:(HomeShop *)obj
{
    _object=obj;
    
    [self loadImage];
}

-(float)calculateHeight:(id)obj
{
    if([obj isKindOfClass:[HomeShop class]])
    {
        HomeShop *home=obj;
        float y=0;
        
        if([home.cover hasData])
        {
            self.imgvCover.S=CGSizeMake(310, 155);
            y=self.imgvCover.SH+15;
        }
        else
        {
            self.imgvCover.S=CGSizeZero;
        }
        
        self.lblTitle.text=home.title;
        
        if(CGRectEqualToRect(home.titleRect, CGRectZero))
        {
            self.lblTitle.frame=CGRectMake(10, y, _displayView.SW-20, 0);
            [self.lblTitle defautSizeToFit];
            
            home.titleRect=self.lblTitle.frame;
        }
        else
        {
            self.lblTitle.frame=home.titleRect;
        }
        
        y+=_lblTitle.SH;
        
        if(_lblTitle.SH>0)
            y+=15;
        
        self.lblContent.attributedText=[[NSAttributedString alloc] initWithString:home.content
                                                                       attributes:@{NSFontAttributeName:self.lblContent.font
                                                                                    , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
        
        if(CGRectEqualToRect(home.contentRect, CGRectZero))
        {
            self.lblContent.frame=CGRectMake(10, y, _displayView.SW-20, 0);
            [self.lblContent defautSizeToFit];
            
            home.contentRect=self.lblContent.frame;
        }
        else
        {
            self.lblContent.frame=home.contentRect;
        }
        
        [_imgvLine setOY:_lblContent.yh+15];
        
        [_imgvAvatar setO:CGPointMake(15, _imgvLine.yh+15)];
        
        _lblName.text=home.shop.name;
        
        if(CGRectEqualToRect(home.nameRect, CGRectZero))
        {
            _lblName.frame=CGRectMake(_imgvAvatar.xw+15, _imgvLine.yh+15, 210, 0);
            [_lblName defautSizeToFit];
            
            home.nameRect=_lblName.frame;
        }
        else
        {
            _lblName.frame=home.nameRect;
        }
        
        y=_lblName.yh;
        
        if(_lblName.SH>0)
            y+=5;
        
        _lblDesc.text=home.date;
        
        if(CGRectEqualToRect(home.descRect, CGRectZero))
        {
            _lblDesc.frame=CGRectMake(_imgvAvatar.xw+15, y, 210, 0);
            [_lblDesc defautSizeToFit];
            
            home.descRect=_lblDesc.frame;
        }
        else
        {
            _lblDesc.frame=home.descRect;
        }
        
        _imgvArrow.frame=CGRectMake(_displayView.SW-20, _imgvAvatar.OY, 10, NMAX(@(_imgvAvatar.SH),@(_lblDesc.yh-_lblName.OY),nil).floatValue);
        
        return _imgvArrow.yh+30;
    }
    else if([obj isKindOfClass:[Event class]])
    {
        Event *home=obj;
        float y=0;
        
        if([home.cover hasData])
        {
            self.imgvCover.S=CGSizeMake(310, 155);
            y=self.imgvCover.SH+15;
        }
        else
        {
            self.imgvCover.S=CGSizeZero;
        }
        
        self.lblTitle.text=home.title;
        
        if(CGRectEqualToRect(home.titleRect, CGRectZero))
        {
            self.lblTitle.frame=CGRectMake(10, y, _displayView.SW-20, 0);
            [self.lblTitle defautSizeToFit];
            
            home.titleRect=self.lblTitle.frame;
        }
        else
        {
            self.lblTitle.frame=home.titleRect;
        }
        
        y+=_lblTitle.SH;
        
        if(_lblTitle.SH>0)
            y+=15;
        
        self.lblContent.attributedText=[[NSAttributedString alloc] initWithString:home.desc
                                                                       attributes:@{NSFontAttributeName:self.lblContent.font
                                                                                    , NSParagraphStyleAttributeName:paragraphStyleJustified()}];
        
        if(CGRectEqualToRect(home.contentRect, CGRectZero))
        {
            self.lblContent.frame=CGRectMake(10, y, _displayView.SW-20, 0);
            [self.lblContent defautSizeToFit];
            
            home.contentRect=self.lblContent.frame;
        }
        else
        {
            self.lblContent.frame=home.contentRect;
        }
        
        [_imgvLine setOY:_lblContent.yh+15];
        
        [_imgvAvatar setO:CGPointMake(15, _imgvLine.yh+15)];
        
        _lblName.text=home.brandName;
        
        if(CGRectEqualToRect(home.nameRect, CGRectZero))
        {
            _lblName.frame=CGRectMake(_imgvAvatar.xw+15, _imgvLine.yh+15, 210, 0);
            [_lblName defautSizeToFit];
            
            home.nameRect=_lblName.frame;
        }
        else
        {
            _lblName.frame=home.nameRect;
        }
        
        y=_lblName.yh;
        
        if(_lblName.SH>0)
            y+=5;
        
        _lblDesc.text=home.date;
        
        if(CGRectEqualToRect(home.descRect, CGRectZero))
        {
            _lblDesc.frame=CGRectMake(_imgvAvatar.xw+15, y, 210, 0);
            [_lblDesc defautSizeToFit];
            
            home.descRect=_lblDesc.frame;
        }
        else
        {
            _lblDesc.frame=home.descRect;
        }
        
        _imgvArrow.frame=CGRectMake(_displayView.SW-20, _imgvAvatar.OY, 10, NMAX(@(_imgvAvatar.SH),@(_lblDesc.yh-_lblName.OY),nil).floatValue);
        
        return _imgvArrow.yh+30;
    }
    
    
    
    return 0;
}

-(void)layoutSubviews
{
    if(self.isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    self.displayView.frame=CGRectMake(5, 0, 310, self.SH);
    [self.displayView cornerRadiusWithRounding:UIRectCornerTopLeft|UIRectCornerTopRight cornerRad:CGSizeMake(4, 4)];
    self.imgvBG.frame=CGRectMake(4, 0, 312, self.SH-15);
    
    [self calculateHeight:_object];
}

-(void) loadImage
{
    if([_object isKindOfClass:[HomeShop class]])
    {
        HomeShop *obj=_object;
        [_imgvAvatar defaultLoadImageWithURL:obj.shop.logo];
        [_imgvCover defaultLoadImageWithURL:obj.cover];
    }
    else if([_object isKindOfClass:[Event class]])
    {
        Event *obj=_object;
        [_imgvAvatar defaultLoadImageWithURL:obj.logo];
        [_imgvCover defaultLoadImageWithURL:obj.cover];
    }
}

-(void) tapCover:(UITapGestureRecognizer*) ta
{
    [self.delegate tabHomeShopCellTouchedCover:self];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imgvBG.image=[[UIImage imageNamed:@"bg_white.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)];
    
    [self.imgvCover addGestureRecognizer:tap];
}

+(NSString *)reuseIdentifier
{
    return @"TabHomeShopCell";
}

@end

#import <objc/runtime.h>

static char TabHomeShopCellKey;
@implementation UITableView(TabHomeShopCell)

-(TabHomeShopCell *)tabHomeShopPrototypeCell
{
    TabHomeShopCell *obj=objc_getAssociatedObject(self, &TabHomeShopCellKey);
    
    if(!obj)
    {
        obj=[self tabHomeShopCell];
        objc_setAssociatedObject(self, &TabHomeShopCellKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

-(void) registerTabHomeShopCell
{
    [self registerNib:[UINib nibWithNibName:[TabHomeShopCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[TabHomeShopCell reuseIdentifier]];
}

-(TabHomeShopCell*) tabHomeShopCell
{
    TabHomeShopCell *cell=[self dequeueReusableCellWithIdentifier:[TabHomeShopCell reuseIdentifier]];
    cell.isPrototypeCell=false;
    
    return cell;
}

@end