//
//  LocationManager.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define NOTIFICATION_USER_LOCATION_CHANGED @"notificationUserLocationChanged"

CLLocationCoordinate2D USER_LOCATION();
CLLocationCoordinate2D HOME_LOCATION();

@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

+(LocationManager*) shareInstance;
-(void) startTrackingLocation;
-(void) stopTrackingLcoation;

// Dùng để cập nhật vị trí khi đang ở màn hình có map (shop list, shop map)
-(void) updateLocation:(CLLocationCoordinate2D) location;

@property (nonatomic, assign) CLLocationCoordinate2D userlocation;//B
@property (nonatomic, assign) CLLocationCoordinate2D homeLocation;//A

@end
