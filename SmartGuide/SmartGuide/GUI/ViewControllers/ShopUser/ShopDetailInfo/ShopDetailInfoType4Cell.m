//
//  ShopDetailInfoType4Cell.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType4Cell.h"

@implementation ShopDetailInfoType4Cell

-(void)loadWithInfo4:(Info4 *)info4
{
    lblTitle.text=info4.title;
    lblDate.text=info4.date;
    lblContent.text=info4.content;
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
    return @"ShopDetailInfoType4Cell";
}

+(float)heightWithInfo4:(Info4 *)info4
{
    float height=50;
    
    if(info4.contentHeight.floatValue==-1)
        info4.contentHeight=@([info4.content sizeWithFont:FONT_SIZE_NORMAL(12) constrainedToSize:CGSizeMake(274, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);

    height+=info4.contentHeight.floatValue;
    
    return height;
}

@end
