//
//  TabInboxViewController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@class NavigationView, NavigationTitleLabel, TableAPI;

@interface TabInboxViewController : ViewController
{
    __weak IBOutlet NavigationView *titileView;
    __weak IBOutlet NavigationTitleLabel *lblTitle;
    __weak IBOutlet TableAPI *table;
}

@end
