#import "_UserNotification.h"

enum USER_NOTIFICATION_STATUS
{
    USER_NOTIFICATION_STATUS_UNREAD = 0,
    USER_NOTIFICATION_STATUS_READ = 1,
};

@interface UserNotification : _UserNotification 
{
}

+(UserNotification*) makeWithDictionary:(NSDictionary*) data;

-(enum USER_NOTIFICATION_STATUS) enumStatus;

@property (nonatomic, strong) NSNumber *contentHeight;

@end
