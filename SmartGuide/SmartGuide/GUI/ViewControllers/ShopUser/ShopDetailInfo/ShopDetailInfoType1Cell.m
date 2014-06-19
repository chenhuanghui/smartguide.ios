//
//  ShopDetailInfoToolCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType1Cell.h"
#import "InfoTypeBGView.h"
#import "ASIOperationShopDetailInfo.h"

@implementation ShopDetailInfoType1Cell

-(void) loadWithInfo1:(Info1 *)info1
{
    lblContent.text=info1.content;
    btnTick.enabled=info1.enumTickedType==DETAIL_INFO_TICKED;
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
    return @"ShopDetailInfoType1Cell";
}

+(float)heightWithInfo1:(Info1 *)info1
{
    float height=40;
    
    if(info1.contentHeight.floatValue==-1)
        info1.contentHeight=@([info1.content sizeWithFont:FONT_SIZE_LIGHT(12) constrainedToSize:CGSizeMake(230, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    height+=MAX(0,info1.contentHeight.floatValue-30);
    
    return height;
}

@end
