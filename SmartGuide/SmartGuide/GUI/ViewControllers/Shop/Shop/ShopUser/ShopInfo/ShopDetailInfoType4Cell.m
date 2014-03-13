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

+(float)heightWithContent:(NSString *)content
{
    float height=70;
    height+=MAX(0,[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:12] constrainedToSize:CGSizeMake(244, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-20);
    
    return height;
}

@end
