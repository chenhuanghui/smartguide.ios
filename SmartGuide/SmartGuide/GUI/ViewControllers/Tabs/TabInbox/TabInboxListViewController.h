//
//  TabInboxListViewController.h
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@class TableAPI, NavigationView, NavigationTitleLabel, MessageSender;

@interface TabInboxListViewController : ViewController
{
    __weak IBOutlet TableAPI *table;
    __weak IBOutlet NavigationView *titleView;
    __weak IBOutlet NavigationTitleLabel *lblTitle;
    __weak IBOutlet UIButton *btnBack;
}

-(TabInboxListViewController*) initWithSender:(MessageSender*) sender;

@property (nonatomic, weak, readonly) MessageSender *sender;

@end
