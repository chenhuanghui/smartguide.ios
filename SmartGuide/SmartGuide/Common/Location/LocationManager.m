//
//  LocationManager.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LocationManager.h"
#import "Constant.h"
#import "Utility.h"

#define LOCATION_MANAGER_LAST_LOCATION_KEY @"locationManagerLastLocation"

CLLocationCoordinate2D USER_LOCATION()
{
    return [[LocationManager shareInstance] userlocation];
}

CLLocationCoordinate2D HOME_LOCATION()
{
    return [[LocationManager shareInstance] homeLocation];
}

@interface LocationManager()<CLLocationManagerDelegate>

@end

static LocationManager *_locationManager=nil;
@implementation LocationManager
@synthesize userlocation,homeLocation;

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
        
        userlocation=CLLocationCoordinate2DMake(-1, -1);
        
        id obj=[[NSUserDefaults standardUserDefaults] objectForKey:LOCATION_MANAGER_LAST_LOCATION_KEY];
        if(obj && [obj length]>0)
        {
            if([obj rangeOfString:@"|"].location!=NSNotFound)
            {
                NSString *coor=[[NSUserDefaults standardUserDefaults] objectForKey:LOCATION_MANAGER_LAST_LOCATION_KEY];
                userlocation=CLLocationCoordinate2DMake([[coor componentsSeparatedByString:@"|"][0] floatValue], [[coor componentsSeparatedByString:@"|"][1] floatValue]);
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOCATION_MANAGER_LAST_LOCATION_KEY];
            }
        }
        
        homeLocation=CLLocationCoordinate2DMake(-1, -1);
    }
    return self;
}

-(void)startTrackingLocation
{
    if(_locationManager)
    {
        [self stopTrackingLcoation];
        return;
    }
 
    NSLog(@"startTrackingLocation");
    
    _locationManager=[[CLLocationManager alloc] init];
    _locationManager.delegate=self;
    _locationManager.distanceFilter=kCLLocationAccuracyBest;
    
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(isVailCLLocationCoordinate2D(manager.location.coordinate))
        [self updateLocation:manager.location.coordinate];//Khi có thông tin vị trí thì cập nhật 2 vị trí
    else
        self.homeLocation=CLLocationCoordinateInvail;//Khi thông tin vị trí không xác định thì giử lại vị trí user, cập nhật vị trí home

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOCATION_CHANGED object:[NSValue valueWithMKCoordinate:manager.location.coordinate]];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.homeLocation=CLLocationCoordinateInvail;//Khi thông tin vị trí không xác định thì giữ lại vị trí user, cập nhật vị trí home
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOCATION_CHANGED object:[NSValue valueWithMKCoordinate:manager.location.coordinate]];
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

-(void)updateLocation:(CLLocationCoordinate2D)location
{
    if(isVailCLLocationCoordinate2D(location))
    {
        self.userlocation=location;
        self.homeLocation=location;
    }
    else
    {
        self.homeLocation=CLLocationCoordinate2DMake(-1, -1);
    }
}

-(void)setUserlocation:(CLLocationCoordinate2D)userlocation_
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f|%f",userlocation_.latitude,userlocation_.longitude] forKey:LOCATION_MANAGER_LAST_LOCATION_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"LocationManager userLocation (%f, %f)->(%f, %f)",self.userlocation.latitude,self.userlocation.longitude,userlocation_.latitude,userlocation_.longitude);
    
    userlocation=userlocation_;
}

-(void)setHomeLocation:(CLLocationCoordinate2D)homeLocation_
{
    NSLog(@"LocationManager homeLocation (%f, %f)->(%f, %f)",self.homeLocation.latitude,self.homeLocation.longitude,homeLocation_.latitude,homeLocation_.longitude);
    
    homeLocation=homeLocation_;
}

@end