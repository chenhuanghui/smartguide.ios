//
//  NotificationDetailViewController.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "UserNotification.h"
#import "ASIOperationUserNotificationContent.h"

@interface UserNotificationDetailViewController : SGViewController
{
    __weak UserNotification *_obj;
    __weak IBOutlet UITableView *table;
    NSMutableArray *_userNotificationContents;
    
    ASIOperationUserNotificationContent *_operationNotificationContent;
    int _page;
    bool _canLoadMore;
    bool _isLoadingMore;
}

-(UserNotificationDetailViewController*) initWithUserNotification:(UserNotification*) obj;

@end

@interface UserNotificationContent(DisplayType)

-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE) enumDisplayType;

@end