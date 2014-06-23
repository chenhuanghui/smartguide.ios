//
//  ShopDetailInfoImageCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType3Cell.h"
#import "ImageManager.h"

@implementation ShopDetailInfoType3Cell

-(void)loadWithInfo3:(Info3 *)info3
{
    _info=info3;
    [imgv loadImageInfo3WithURL:info3.image];
    lblTitle.text=info3.title;
    lblContent.text=info3.content;
    
    [lblTitle l_v_setH:info3.titleHeight.floatValue];
 
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h];
    [lblContent l_v_setH:info3.contentHeight.floatValue];
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

+(float) heightWithInfo3:(Info3 *)info3
{
    float height=86;
    
    if(info3.titleHeight.floatValue==-1)
    {
        if([info3.title stringByTrimmingWhiteSpace].length==0)
            info3.titleHeight=@(0);
        else
            info3.titleHeight=@([info3.title sizeWithFont:FONT_SIZE_BOLD(14) constrainedToSize:CGSizeMake(191, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    if(info3.contentHeight.floatValue==-1)
    {
        if([info3.content stringByTrimmingWhiteSpace].length==0)
            info3.contentHeight=@(0);
        else
            info3.contentHeight=@([info3.content sizeWithFont:FONT_SIZE_NORMAL(12) constrainedToSize:CGSizeMake(191, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    if(info3.titleHeight.floatValue+info3.contentHeight.floatValue>66)
    {
        height+=(info3.titleHeight.floatValue+info3.contentHeight.floatValue)-66;
    }
    
    return MAX(86, height);
}

@end
