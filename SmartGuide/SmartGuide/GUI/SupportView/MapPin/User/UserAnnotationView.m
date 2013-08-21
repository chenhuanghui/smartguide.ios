//
//  UserAnnotationView.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserAnnotationView.h"
#import "UserPin.h"
#import "Constant.h"

@interface UserAnnotationView()

@property (nonatomic, strong) UserPin *pin;

@end

@implementation UserAnnotationView
@synthesize pin;

-(UserAnnotationView *)initWithUserLocation:(MKUserLocation *)userLocation
{
    self=[super initWithAnnotation:userLocation reuseIdentifier:[UserAnnotationView reuseIdentifier]];
    
    self.image=UIIMAGE_USER_PIN;
    self.canShowCallout=true;
    
    [self setUserLocation:userLocation];
    
    self.pin=[[UserPin alloc] initWithUser:userLocation.title];
    
    
    return self;
}

-(void)setUserLocation:(MKUserLocation *)userLocation
{
    
}

+(NSString *)reuseIdentifier
{
    return @"UserAnnotationView";
}

@end
