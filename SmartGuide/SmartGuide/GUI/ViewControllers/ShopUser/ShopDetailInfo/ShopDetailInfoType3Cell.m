//
//  ShopDetailInfoImageCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType3Cell.h"
#import "ImageManager.h"
#import "InfoTypeBGView.h"
#import "ASIOperationShopDetailInfo.h"

@implementation ShopDetailInfoType3Cell
@synthesize suggestHeight,isCalculatingSuggestHeight;

-(void)loadWithInfo3:(Info3 *)info3
{
    _info=info3;
    [imgv loadImageInfo3WithURL:info3.image];
    isCalculatingSuggestHeight=false;
    
    [self setNeedsLayout];
}

-(void)calculatingSuggestHeight
{
    isCalculatingSuggestHeight=true;
    [self layoutSubviews];
    isCalculatingSuggestHeight=false;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    lblTitle.text=_info.title;
    lblContent.text=_info.content;
    if(!isCalculatingSuggestHeight)
        [imgv loadImageInfo3WithURL:_info.image];
    
    [lblTitle l_v_setS:CGSizeMake(191, 0)];
    [lblContent l_v_setS:CGSizeMake(191, 0)];
    
    [lblTitle sizeToFit];
    [lblContent sizeToFit];
    
    float padding=5;
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+padding];
    [lblContent l_v_addH:5];
    
    suggestHeight=lblContent.l_v_y+lblContent.l_v_h;
    
    float textViewHeight=66;
    suggestHeight=MAX(textViewHeight,suggestHeight);
    [textView l_v_setH:suggestHeight];
    
    //align bot line
    suggestHeight+=8;
}

-(Info3 *)info
{
    return _info;
}

-(void)setCellPos:(enum CELL_POSITION)cellPos
{
    switch (cellPos) {
        case CELL_POSITION_BOTTOM:
            line.hidden=true;
            break;
            
        case CELL_POSITION_MIDDLE:
        case CELL_POSITION_TOP:
            line.hidden=false;
            break;
    }
}


+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType3Cell";
}

@end

@implementation UITableView(ShopDetailInfoType3Cell)

-(void)registerShopDetailInfoType3Cell
{
    [self registerNib:[UINib nibWithNibName:[ShopDetailInfoType3Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoType3Cell reuseIdentifier]];
}

-(ShopDetailInfoType3Cell *)shopDetailInfoType3Cell
{
    return [self dequeueReusableCellWithIdentifier:[ShopDetailInfoType3Cell reuseIdentifier]];
}

@end