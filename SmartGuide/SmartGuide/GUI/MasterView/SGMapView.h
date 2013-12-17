//
//  SGMapView.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface SGMapView : MKMapView

-(void) zoomToUserLocation:(bool) animate span:(double) span;
-(void) zoomToCoordinates:(NSArray*) array animate:(bool) animate span:(double) span;

@end
