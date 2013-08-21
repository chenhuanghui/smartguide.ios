//
//  AlertViewCity.h
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UIAlertTableView.h"

@class City;

@interface AlertViewCity : UIAlertTableView<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_cities;
}

-(AlertViewCity*) initAlertViewCityWithCity:(NSArray*) cities;
@property (nonatomic, readonly) City *selectedCity;

@end
