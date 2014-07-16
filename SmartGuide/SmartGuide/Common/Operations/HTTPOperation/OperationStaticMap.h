//
//  OperationStaticMap.h
//  Infory
//
//  Created by XXX on 7/16/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HTTPOperation.h"
#import <CoreLocation/CoreLocation.h>

enum MARKER_SIZE_TYPE
{
    MARKER_SIZE_TYPE_TINY=0,
    MARKER_SIZE_TYPE_MID=1,
    MARKER_SIZE_TYPE_SMALL=2,
};

enum MARKER_COLOR_TYPE
{
    MARKER_COLOR_TYPE_BLACK=0,
    MARKER_COLOR_TYPE_BROWN=1,
    MARKER_COLOR_TYPE_GREEN=2,
    MARKER_COLOR_TYPE_PURPLE=3,
    MARKER_COLOR_TYPE_YELLOW=4,
    MARKER_COLOR_TYPE_BLUE=5,
    MARKER_COLOR_TYPE_GRAY=6,
    MARKER_COLOR_TYPE_ORANGE=7,
    MARKER_COLOR_TYPE_RED=8,
    MARKER_COLOR_TYPE_WHITE=9,
};

@interface OperationStaticMap : HTTPOperation

-(OperationStaticMap*) initWithSize:(CGSize) size markerSizeType:(enum MARKER_SIZE_TYPE) markerSizeType markerColorType:(enum MARKER_COLOR_TYPE) markerColorType markerLocation:(CLLocationCoordinate2D) markerLocation;

@property (nonatomic, strong) UIImage *image;

@end
