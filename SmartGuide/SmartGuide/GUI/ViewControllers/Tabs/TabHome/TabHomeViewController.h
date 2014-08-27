//
//  TabHomeViewController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@class NavigationView, NavigationTitleLabel, ButtonUserCityLocation, TableAPI;

@interface TabHomeViewController : ViewController
{
    __weak IBOutlet NavigationView *titleView;
    __weak IBOutlet UIButton *btnExpand;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet NavigationTitleLabel *lblTitle;
    __weak IBOutlet ButtonUserCityLocation *btnUserCity;
    __weak IBOutlet UIView *cityView;
    __weak IBOutlet TableAPI *table;
    __weak IBOutlet UIButton *btnTab;
}

@end