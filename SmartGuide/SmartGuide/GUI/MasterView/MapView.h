//
//  MapView.h
//  SmartGuide
//
//  Created by XXX on 7/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapView : MKMapView

+(MapView*) shareInstance;

-(void) clearMap;

@end