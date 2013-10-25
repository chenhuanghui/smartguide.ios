//
//  MapView.m
//  SmartGuide
//
//  Created by XXX on 7/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "MapView.h"
#import <objc/runtime.h>
#import <objc/message.h>

static __strong MapView *_mapView=nil;
@implementation MapView

+(MapView *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mapView=[[MapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _mapView.showsUserLocation=true;
    });
    
    return _mapView;
}

-(void) clearMap
{
    NSMutableArray *array=[self.annotations mutableCopy];
    
    if(self.userLocation)
        [array removeObject:self.userLocation];
    
    [self removeAnnotations:array];
    
    [self removeOverlays:self.overlays];
}

-(void)removeFromSuperview
{
    self.delegate=nil;
    
    [super removeFromSuperview];
}

@end