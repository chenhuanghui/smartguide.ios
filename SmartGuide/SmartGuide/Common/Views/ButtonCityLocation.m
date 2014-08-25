//
//  ButtonCityLocation.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ButtonCityLocation.h"
#import "DataManager.h"

@implementation ButtonCityLocation

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLabel.font=FONT_SIZE_NORMAL(14);
}

-(void) makeTitleWithIDCity:(int)idCity
{
    NSString *cityName=CITY_NAME(idCity);
    
    if(cityName.length>0)
        [self setTitle:[NSString stringWithFormat:@"Vị trí hiện tại %@",cityName] forState:UIControlStateNormal];
    else
        [self setTitle:@"Vị trí hiện tại" forState:UIControlStateNormal];
}

@end

@implementation ButtonUserCityLocation

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self makeTitleWithIDCity:currentUser().idCity.integerValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userCityChanged:) name:NOTIFICATION_USER_CITY_CHANGED object:nil];
}

-(void) userCityChanged:(NSNotification*) notification
{
    [self makeTitleWithIDCity:currentUser().idCity.integerValue];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end