//
//  MapList.m
//  SmartGuide
//
//  Created by MacMini on 01/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "MapList.h"

static MapList *_mapList=nil;
@implementation MapList

+(MapList *)shareInstance
{
    return _mapList;
}

+(void)load
{
    _mapList=[[MapList alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mapList.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    
    if([_mapList respondsToSelector:@selector(setShowsBuildings:)])
        _mapList.showsBuildings=false;
    if([_mapList respondsToSelector:@selector(setShowsPointsOfInterest:)])
        _mapList.showsPointsOfInterest=false;
}

@end
