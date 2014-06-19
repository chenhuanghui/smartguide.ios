//
//  ShopDetailInfoDetailCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType2Cell.h"

@implementation ShopDetailInfoType2Cell

-(void)loadWithInfo2:(Info2 *)info2
{
    lblLeft.text=info2.title;
    lblRight.text=info2.content;
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
    return @"ShopDetailInfoType2Cell";
}

+(float)heightWithContent:(NSString *)content
{
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:12] constrainedToSize:CGSizeMake(160, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    height=MAX(height, 37);
    
    return height;
}

@end