#import "_UserNotification.h"
#import "Constant.h"
#import "UserNotificationAction.h"

@interface UserNotification : _UserNotification 
{
}

+(UserNotification*) makeWithDictionary:(NSDictionary*) data;
+(UserNotification*) userNotificationWithIDNotification:(int) idNotification;

-(enum NOTIFICATION_STATUS) enumStatus;

@property (nonatomic, strong) NSNumber *displayContentHeight;
@property (nonatomic, strong) NSMutableAttributedString *displayContentAttribute;

@end