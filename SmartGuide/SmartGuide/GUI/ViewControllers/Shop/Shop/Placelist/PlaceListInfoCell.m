//
//  PlaceListInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlaceListInfoCell.h"

@implementation PlaceListInfoCell

-(void)loadWithUserPlace:(UserPlacelist *)place
{
    _place=place;
    
    lblNumOfShop.text=place.numOfShop;
    lblName.text=place.name;
    imgTick.highlighted=place.isTicked.boolValue;
}

-(UserPlacelist *)place
{
    return _place;
}

-(void)setIsTicked:(bool)isTicked
{
    imgTick.highlighted=isTicked;
}

-(void)setCellPosition:(enum CELL_POSITION)cellPos
{
    switch (cellPos) {
        case CELL_POSITION_TOP:
            lineBottom.hidden=false;
            break;
            
        case CELL_POSITION_BOTTOM:
            lineBottom.hidden=true;
            break;
            
        case CELL_POSITION_MIDDLE:
            lineBottom.hidden=false;
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"PlaceListInfoCell";
}

+(float)height
{
    return 49;
}

@end
