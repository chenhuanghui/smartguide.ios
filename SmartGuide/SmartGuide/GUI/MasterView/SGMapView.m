//
//  SGMapView.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGMapView.h"
#import "Constant.h"
#import "Utility.h"

@implementation SGMapView

-(void)zoomToUserLocation:(bool)animate span:(double)span
{
    if(!isVailCLLocationCoordinate2D(self.userLocation.coordinate))
        return;
    
    [self setRegion:MKCoordinateRegionMakeWithDistance(self.userLocation.location.coordinate, span, span) animated:animate];
}

-(void)zoomToCoordinates:(NSArray *)array animate:(bool)animate span:(double)span
{
    if(array.count==0)
        return;
    
    CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
    
    for(NSValue *value in array)
    {
        CLLocationCoordinate2D coordinate=[value MKCoordinateValue];
        
        CLLocationCoordinate2D currentLocation=coordinate;
        if(currentLocation.latitude>maxLat)
            maxLat=currentLocation.latitude;
        if(currentLocation.latitude<minLat)
            minLat=currentLocation.latitude;
        if(currentLocation.longitude>maxLon)
            maxLon=currentLocation.longitude;
        if(currentLocation.longitude<minLon)
            minLon=currentLocation.longitude;
    }
    
	MKCoordinateRegion region;
    //    CLLocationCoordinate2D location=CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
    
    double miles = span*0.000621371f;
    double scalingFactor = ABS( (cos(2 * M_PI * region.center.latitude / 360.0) ));
    
    region.span=MKCoordinateSpanMake(miles/69, miles/(scalingFactor*69));
    
	[self setRegion:region animated:animate];
}



@end
