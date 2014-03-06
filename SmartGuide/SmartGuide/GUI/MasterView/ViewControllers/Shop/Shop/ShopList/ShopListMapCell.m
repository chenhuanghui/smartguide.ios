//
//  ShopListMapCell.m
//  SmartGuide
//
//  Created by MacMini on 06/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopListMapCell.h"
#import "Utility.h"

@implementation ShopListMapCell

-(void)tableDidScroll
{
    if(CGRectIsEmpty(_mapFrame))
        _mapFrame=self.map.frame;
    
    [self.map l_v_setY:_mapFrame.origin.y+self.table.l_co_y/2];
}

+(NSString *)reuseIdentifier
{
    return @"ShopListMapCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self disabelMap];
}

-(void)disabelMap
{
    self.map.userInteractionEnabled=false;
    self.map.scrollEnabled=false;
    self.map.zoomEnabled=false;
    
    if([self.map respondsToSelector:@selector(setShowsBuildings:)])
        self.map.showsBuildings=false;
    
    if([self.map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        self.map.showsPointsOfInterest=false;
}

-(void)enableMap
{
    self.map.userInteractionEnabled=true;
    self.map.scrollEnabled=true;
    self.map.zoomEnabled=true;
    
    if([self.map respondsToSelector:@selector(setShowsBuildings:)])
        self.map.showsBuildings=false;
    
    if([self.map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        self.map.showsPointsOfInterest=false;
}

@end
