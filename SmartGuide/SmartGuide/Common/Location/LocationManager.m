//
//  LocationManager.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LocationManager.h"
#import "Constant.h"
#import <AddressBook/AddressBook.h>
#import "City.h"
#import "Utility.h"

@interface LocationManager()<CLLocationManagerDelegate>

@end

static LocationManager *_locationManager=nil;
@implementation LocationManager

+(LocationManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _locationManager=[[LocationManager alloc] init];
    });
    
    return _locationManager;
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)startTrackingLocation
{
    if(_locationManager)
        return;
 
    NSLog(@"startTrackingLocation");
    
    _locationManager=[[CLLocationManager alloc] init];
    _locationManager.delegate=self;
    _locationManager.distanceFilter=kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(isVailCLLocationCoordinate2D(manager.location.coordinate))
    {
        setUserLocation(manager.location.coordinate);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOCATION_CHANGED object:[NSValue valueWithMKCoordinate:manager.location.coordinate]];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    setUserLocation(manager.location.coordinate);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOCATION_CHANGED object:[NSValue valueWithMKCoordinate:manager.location.coordinate]];
}

-(void)stopTrackingLcoation
{
    if(!_locationManager)
        return;
    
    NSLog(@"stopTrackingLcoation");
    
    _locationManager.delegate=nil;
    [_locationManager stopUpdatingLocation];
    _locationManager=nil;
}

@end