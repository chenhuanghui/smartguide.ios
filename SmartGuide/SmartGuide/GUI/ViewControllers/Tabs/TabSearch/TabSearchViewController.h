//
//  TabSearchViewController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@class NavigationView, TableAPI;

@interface TabSearchViewController : ViewController
{
    __weak IBOutlet NavigationView *titleView;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btnCancel;
    __weak IBOutlet UIView *keywordView;
    __weak IBOutlet UIButton *btnKeyword;
    __weak IBOutlet UIButton *btnCity;
    __weak IBOutlet TableAPI *table;
}

@end