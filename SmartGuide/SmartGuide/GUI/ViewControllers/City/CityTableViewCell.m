//
//  CityTableViewCell.m
//  Infory
//
//  Created by XXX on 5/21/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "CityTableViewCell.h"
#import "CityManager.h"
#import "Utility.h"

@implementation CityTableViewCell

-(void)loadWithCityObject:(CityObject *)obj marked:(bool)marked cellPos:(enum CELL_POSITION)cellPos
{
    _obj=obj;
    
    lblContent.text=obj.name;
    
    if(marked)
    {
        imgvIcon.backgroundColor=[UIColor clearColor];
        imgvIcon.image=[UIImage imageNamed:@"icon_location_city.png"];
    }
    else
    {
        imgvIcon.backgroundColor=[UIColor color255WithRed:206 green:206 blue:206 alpha:255];
        imgvIcon.image=nil;
    }
    
    switch (cellPos) {
        case CELL_POSITION_TOP:
            imgvTop.hidden=true;
            imgvBot.hidden=false;
            [bg cornerRadiusWithRounding:UIRectCornerTopLeft|UIRectCornerTopRight cornerRad:CGSizeMake(2, 2)];
            break;
            
        case CELL_POSITION_MIDDLE:
            imgvTop.hidden=false;
            imgvBot.hidden=false;
            bg.layer.masksToBounds=false;
            break;
            
        case CELL_POSITION_BOTTOM:
            imgvTop.hidden=false;
            imgvBot.hidden=true;
            [bg cornerRadiusWithRounding:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRad:CGSizeMake(2, 2)];
            break;
            
    }
}

+(NSString *)reuseIdentifier
{
    return @"CityTableViewCell";
}

+(float)heightWithCityObject:(CityObject *)obj
{
    return 36;
    float height=36;
    
    if(obj.nameHeight.floatValue==-1)
    {
        obj.nameHeight=@([obj.name sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(295, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail].height);
    }
    
    height+=obj.nameHeight.floatValue;
    
    return height;
}

-(CityObject *)cityObject
{
    return _obj;
}

@end
