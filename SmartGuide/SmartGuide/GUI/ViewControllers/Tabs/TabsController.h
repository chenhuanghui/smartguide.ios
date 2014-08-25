//
//  TabsController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabbarController.h"

@class TabHomeViewController, TabInboxViewController, TabSearchViewController, TabUserViewController;

@interface TabsController : TabbarController

@property (nonatomic, weak, readonly) TabHomeViewController *tabHome;
@property (nonatomic, weak, readonly) TabSearchViewController *tabSearch;
@property (nonatomic, weak, readonly) TabInboxViewController *tabInbox;
@property (nonatomic, weak, readonly) TabUserViewController *tabUser;

@end
