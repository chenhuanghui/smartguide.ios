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

static LocationManager *_locationManager=nil;
@implementation LocationManager
@synthesize userLocation;
@synthesize locationManager;

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
        self.userCurrentCity=@"";
        self.userLocation=CLLocationCoordinate2DMake(-1, -1);
        [self checkLocationAuthorize];
    }
    return self;
}

-(void)tryGetUserLocationInfo
{
    if(_isTryGetUserLocationInfo)
        return;
    
    if(!self.locationManager)
        self.locationManager=[[CLLocationManager alloc] init];
    
    _isTryGetUserLocationInfo=true;
    
    if([self.locationManager respondsToSelector:@selector(purpose)])
    {
        //Remember set plist NSLocationUsageDescription
        self.locationManager.purpose=@"Xin location";
    }
    
    //trigger CatalogueBlockViewController detect city
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}

-(void)checkLocationAuthorize
{
    _isServicesEnabled=[CLLocationManager locationServicesEnabled];
    _isAuthorized=[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized;
}

-(void)startTrackingLocationAuthorize
{
    if(_isTrackingLocationAuthorize)
        return;
    
    if([NSThread isMainThread])
    {
        [self performSelectorInBackground:@selector(startTrackingLocationAuthorize) withObject:nil];
        return;
    }
    
    _isTrackingLocationAuthorize=true;
    
    while (_isTrackingLocationAuthorize) {
        bool isChanged=false;
        if(_isServicesEnabled!=[CLLocationManager locationServicesEnabled])
        {
            isChanged=true;
            NSLog(@"locationServices change %i to %i",_isServicesEnabled,[CLLocationManager locationServicesEnabled]);
            _isServicesEnabled=[CLLocationManager locationServicesEnabled];
        }
        if(_isAuthorized!=([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized))
        {
            isChanged=true;
            NSLog(@"authorizationStatus change %i to %i",_isAuthorized,[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized);
            _isAuthorized=[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorized;
        }
        
        if(isChanged)
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_AUTHORIZE_CHANGED object:nil];
        
        sleep(2);
    }
}

-(void)stopTrackingLocationAuthorize
{
    _isTrackingLocationAuthorize=false;
}

-(bool)isLocationServicesEnabled
{
    return _isServicesEnabled;
}

-(bool)isAuthorizeLocation
{
    return _isAuthorized;
}

-(bool)isAllowLocation
{
    return _isServicesEnabled && _isAuthorized;
}

#pragma mark CLLocationManger delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSMutableArray *array=[NSMutableArray array];
    
    if(oldLocation)
        [array addObject:oldLocation];
    if(newLocation)
        [array addObject:newLocation];
    
    [self locationManager:manager didUpdateLocations:array];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(locations.count>0)
    {
        self.userLocation=((CLLocation*)[locations lastObject]).coordinate;
        _isTryGetUserLocationInfo=false;
        self.locationManager.delegate=nil;
        self.locationManager=nil;
        
        NSLog(@"location");
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_AVAILABLE object:nil];
        
        [manager stopUpdatingLocation];
    }
}

-(void)tryGetUserCityInfo
{
    if(_isTryGetUserCityInfo)
        return;
    
    _isTryGetUserCityInfo=true;
    
    self.userCurrentCity=@"";
    
    CLLocation *location=[[CLLocation alloc] initWithLatitude:self.userLocation.latitude longitude:self.userLocation.longitude];
    _geoLocationInfo=[[CLGeocoder alloc] init];
    [_geoLocationInfo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error)
            NSLog(@"geoCoder error %@",error);
        else
        {
            for(CLPlacemark *placemark in placemarks)
            {
                NSString *city=[placemark.addressDictionary objectForKey:(NSString*)kABPersonAddressCityKey];
                
                if(city)
                    self.userCurrentCity=[NSString stringWithString:city];
            }
        }

        _geoLocationInfo=nil;
        _isTryGetUserLocationInfo=false;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_CITY_AVAILABLE object:self.userCurrentCity];
    }];
}

-(bool)isTryingGetUserLocationInfo
{
    return _isTryGetUserLocationInfo;
}

-(bool)isTryingGetUserCityInfo
{
    return _isTryGetUserCityInfo;
}

-(void)stopGetUserLocationInfo
{
    _isTryGetUserLocationInfo=false;
    self.locationManager.delegate=nil;
    self.locationManager=nil;
    self.userCurrentCity=nil;
}

-(void)stopGetUserCityInfo
{
    if(_geoLocationInfo)
    {
        [_geoLocationInfo cancelGeocode];
        _geoLocationInfo=nil;
    }
    
    self.userCurrentCity=@"";
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"LocationManager failed %@",error);
 
    self.userCurrentCity=[City HCMCity].name;
    _isTryGetUserLocationInfo=false;
    self.locationManager.delegate=nil;
    self.locationManager=nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_PERMISSION_DENIED object:nil];
}

@end