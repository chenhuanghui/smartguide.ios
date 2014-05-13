#import "_UserNotificationContent.h"

enum USER_NOTIFICATION_CONTENT_ACTION_TYPE
{
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_MARK_READ=0,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_USER=1,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_LIST=2,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_POPUP_URL=3,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_SETTING=4,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_LOGIN=5,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_SCAN_CODE=6,
    USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_PROMOTION=7
};

enum USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE
{
    USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_UNKNOW=0,
    USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_PLACELIST=1,
    USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_KEYWORDS=2,
    USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_IDSHOPS=3,
};

enum USER_NOTIFICATION_CONTENT_READ_ACTION
{
    USER_NOTIFICATION_CONTENT_READ_ACTION_TOUCH=0,
    USER_NOTIFICATION_CONTENT_READ_ACTION_GOTO=1,
};

enum USER_NOTIFICATION_CONTENT_STATUS
{
    USER_NOTIFICATION_CONTENT_STATUS_UNREAD = 0,
    USER_NOTIFICATION_CONTENT_STATUS_READ = 1,
};;

@interface UserNotificationContent : _UserNotificationContent
{
}

+(UserNotificationContent*) makeWithDictionary:(NSDictionary*) data;

-(enum USER_NOTIFICATION_CONTENT_STATUS) enumStatus;
-(enum USER_NOTIFICATION_CONTENT_ACTION_TYPE) enumActionType;
-(enum USER_NOTIFICATION_CONTENT_READ_ACTION) enumReadAction;
-(enum USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE) enumShopListDataType;

-(void)markAndSendRead;

@property (nonatomic, strong) NSNumber *titleHeight;
@property (nonatomic, strong) NSNumber *contentHeight;
@property (nonatomic, strong) NSAttributedString *titleAttribute;
@property (nonatomic, strong) NSAttributedString *contentAttribute;

@end