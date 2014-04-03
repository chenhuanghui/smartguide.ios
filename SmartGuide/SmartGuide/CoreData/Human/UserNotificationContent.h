#import "_UserNotificationContent.h"

enum USER_NOTIFICATION_CONTENT_TYPE
{
    USER_NOTIFICATION_CONTENT_TYPE_NONE = 0,
    USER_NOTIFICATION_CONTENT_TYPE_SHOP_DETAIL = 1,
    USER_NOTIFICATION_CONTENT_TYPE_SHOP_LIST = 2,
    USER_NOTIFICATION_CONTENT_TYPE_TUTORIAL = 3
};

@interface UserNotificationContent : _UserNotificationContent 
{
}

+(UserNotificationContent*) makeWithDictionary:(NSDictionary*) data;

-(enum USER_NOTIFICATION_CONTENT_TYPE) enumType;

@property (nonatomic, strong) NSNumber *titleHeight;
@property (nonatomic, strong) NSNumber *descHeight;

@end