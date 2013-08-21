//
//  LocationManager.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    bool _isTrackingLocationAuthorize;
    bool _isServicesEnabled;
    bool _isAuthorized;
    bool _isTryGetUserLocationInfo;
    bool _isTryGetUserCityInfo;
    CLGeocoder *_geoLocationInfo;
}

+(LocationManager*) shareInstance;

-(void) tryGetUserLocationInfo;
-(void) tryGetUserCityInfo;
-(bool) isTryingGetUserLocationInfo;
-(bool) isTryingGetUserCityInfo;
-(void) stopGetUserLocationInfo;
-(void) stopGetUserCityInfo;

-(void) checkLocationAuthorize;
-(void) startTrackingLocationAuthorize;
-(void) stopTrackingLocationAuthorize;
-(bool) isLocationServicesEnabled;
-(bool) isAuthorizeLocation;
-(bool) isAllowLocation;

@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong) NSString *userCurrentCity;
@property (nonatomic, strong) CLLocationManager* locationManager;

@end
