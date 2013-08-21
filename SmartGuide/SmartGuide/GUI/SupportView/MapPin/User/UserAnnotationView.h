//
//  UserAnnotationView.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface UserAnnotationView : MKAnnotationView

-(UserAnnotationView*) initWithUserLocation:(MKUserLocation*) userLocation;
-(void) setUserLocation:(MKUserLocation*) userLocation;

+(NSString *)reuseIdentifier;

@end
