//
//  LocationManager.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DataManager.h"

#define NOTIFICATION_USER_LOCATION_CHANGED @"notificationUserLocationChanged"

@interface LocationManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

+(LocationManager*) shareInstance;
-(void) startTrackingLocation;
-(void) stopTrackingLcoation;

@end
