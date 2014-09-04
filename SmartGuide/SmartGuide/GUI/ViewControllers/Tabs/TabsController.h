//
//  TabsController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabbarController.h"

@class TabHomeViewController, TabInboxViewController, TabSearchViewController, TabUserViewController, TabScanViewController, NavigationController;

@interface TabsController : TabbarController

-(NavigationController*) selectedTab;

@property (nonatomic, weak, readonly) NavigationController *tabHome;
@property (nonatomic, weak, readonly) NavigationController *tabSearch;
//@property (nonatomic, weak, readonly) NavigationController *tabScan;
@property (nonatomic, weak, readonly) NavigationController *tabInbox;
@property (nonatomic, weak, readonly) NavigationController *tabUser;

@end
