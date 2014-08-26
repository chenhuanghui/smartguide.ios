//
//  MapCollectionCell.m
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "MapCollectionCell.h"
#import "Label.h"
#import "Utility.h"

@implementation MapCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    frame.origin=CGPointZero;
    
    self.autoresizesSubviews=false;
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgv=[UIImageView new];
    imgv.image=[[UIImage imageNamed:@"bg_white.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    [self addSubview:imgv];
    _imgvBG=imgv;
    
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:frame];
    scroll.autoresizesSubviews=false;
    scroll.backgroundColor=[UIColor clearColor];
    
    [self addSubview:scroll];
    _scroll=scroll;
    
    Label *lbl=[Label new];
    lbl.font=FONT_SIZE_NORMAL(14);
    lbl.numberOfLines=0;
    lbl.textColor=[UIColor redColor];
    
    [_scroll addSubview:lbl];
    _lblTitle=lbl;
    
    lbl=[Label new];
    lbl.font=FONT_SIZE_NORMAL(12);
    lbl.numberOfLines=3;
    lbl.textColor=[UIColor darkTextColor];
    
    [_scroll addSubview:lbl];
    _lblContent=lbl;
    
    imgv=[UIImageView new];
    imgv.image=[UIImage imageNamed:@"line_content.png"];
    
    [_scroll addSubview:imgv];
    _imgvLine=imgv;
    
    imgv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    imgv.clipsToBounds=true;
    imgv.layer.cornerRadius=22;
    
    [_scroll addSubview:imgv];
    _imgvLogo=imgv;
    
    lbl=[Label new];
    lbl.font=FONT_SIZE_NORMAL(14);
    lbl.numberOfLines=1;
    lbl.textColor=[UIColor darkTextColor];
    
    [_scroll addSubview:lbl];
    _lblName=lbl;
    
    lbl=[Label new];
    lbl.font=FONT_SIZE_NORMAL(12);
    lbl.numberOfLines=2;
    lbl.textColor=[UIColor darkTextColor];
    
    [_scroll addSubview:lbl];
    _lblDesc=lbl;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"button_arrow_navigation.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnArrowTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scroll addSubview:btn];
    _btnArrow=btn;
    
    return self;
}

-(void) btnArrowTouchUpInside:(id) sender
{
    
}

-(void)loadWithMapObject:(id<MapObject>)obj
{
    _obj=obj;
    [self loadImage];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgvBG.frame=CGRectMake(4, 0, 312, self.SH-15);
    _scroll.frame=CGRectMake(5, 0, 310, self.SH);
    
    _lblTitle.frame=CGRectMake(10, 0, _scroll.SW-20, 0);
    _lblTitle.text=[_obj mapTitle];
    
    [_lblTitle defautSizeToFit];
    
    float y=_lblTitle.yh;
    
    if(_lblTitle.SH>0)
        y+=15;
    
    _lblContent.frame=CGRectMake(10, y, _scroll.SW-20, 0);
    _lblContent.attributedText=[[NSAttributedString alloc] initWithString:[_obj mapContent]
                                                               attributes:@{NSFontAttributeName:_lblContent.font,
                                                                            NSParagraphStyleAttributeName:paragraphStyleJustified()}];
    
    [_lblContent defautSizeToFit];
    
    _imgvLine.O=CGPointMake(0, _lblContent.yh+15);
    
    _imgvLogo.O=CGPointMake(15, _imgvLine.yh+15);
    
    _lblName.text=[_obj mapName];
    _lblName.frame=CGRectMake(_imgvLogo.xw+15, _imgvLine.yh+15, _scroll.SW-_imgvLogo.xw+15-10, 0);
    
    [_lblName defautSizeToFit];
    
    y=_lblName.yh;
    
    if(_lblName.yh>0)
        y+=5;
    
    _lblDesc.text=[_obj mapDesc];
    _lblDesc.frame=CGRectMake(_lblName.OX, y, _scroll.SW-_imgvLogo.xw+15-10, 0);
    
    [_lblDesc defautSizeToFit];
    
    _btnArrow.frame=CGRectMake(_scroll.SW-20, _imgvLogo.OY, 10, NMAX(@(_imgvLogo.SH),@(_lblDesc.yh-_lblName.OY),nil).floatValue);
    
    _scroll.contentSize=CGSizeMake(_scroll.SW, MAX(_scroll.SH, _btnArrow.yh));
}

-(void) loadImage
{
    
}

-(float)calculatorHeightWithObject:(id<MapObject>)obj
{
    return 0;
}

+(NSString *)reuseIdentifier
{
    return @"MapCollectionCell";
}

@end

#import <objc/runtime.h>

static char MapCollectionPrototypeCellKey;
@implementation UICollectionView(MapCollectionCell)

-(void)registerMapCollectionCell
{
    [self registerClass:[MapCollectionCell class] forCellWithReuseIdentifier:[MapCollectionCell reuseIdentifier]];
}

-(MapCollectionCell *)mapCollectionCell:(NSIndexPath *)idx
{
    MapCollectionCell *cell=[self dequeueReusableCellWithReuseIdentifier:[MapCollectionCell reuseIdentifier] forIndexPath:idx];
    
//    cell.isPrototypeCell=false;
    
    return cell;
}

-(MapCollectionCell *)MapCollectionPrototypeCell
{
    MapCollectionCell *cell=objc_getAssociatedObject(self, &MapCollectionPrototypeCellKey);
    
    if(!cell)
    {
        cell=[[MapCollectionCell alloc] initWithFrame:CGRectZero];
        objc_setAssociatedObject(self, &MapCollectionPrototypeCellKey, cell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
//    cell.isPrototypeCell=true;
    
    return cell;
}

@end