#import "_UserNotificationAction.h"
#import "Constant.h"

enum NOTIFICATION_METHOD_TYPE
{
    NOTIFICATION_METHOD_TYPE_UNKNOW=INT32_MAX,
    NOTIFICATION_METHOD_TYPE_GET=0,
    NOTIFICATION_METHOD_TYPE_POST=1,
};

@interface UserNotificationAction : _UserNotificationAction 
{
}

+(UserNotificationAction*) makeWithAction:(NSDictionary*) action;

-(enum NOTIFICATION_ACTION_TYPE) enumActionType;
-(enum NOTIFICATION_METHOD_TYPE) enumMethodType;

@end
