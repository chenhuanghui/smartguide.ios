#import "UserNotificationContent.h"

@implementation UserNotificationContent
@synthesize titleHeight,descHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.titleHeight=@(-1);
    self.descHeight=@(-1);
    
    return self;
}

+(UserNotificationContent *)makeWithDictionary:(NSDictionary *)data
{
    UserNotificationContent *obj=[UserNotificationContent insert];
    
    obj.idNotification=[NSNumber numberWithObject:data[@"idNotification"]];
    obj.logo=[NSString stringWithStringDefault:data[@"logo"]];
    
    if(data[@"idShopLogo"])
        obj.idShopLogo=[NSNumber numberWithObject:data[@"idShopLogo"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    obj.title=[NSString stringWithStringDefault:data[@"title"]];
    obj.content=[NSString stringWithStringDefault:data[@"content"]];
    obj.status=[NSNumber numberWithObject:data[@"status"]];
    obj.readAction=[NSNumber numberWithObject:data[@"readAction"]];
    obj.actionTitle=[NSString stringWithStringDefault:data[@"actionTitle"]];
    obj.actionType=[NSNumber numberWithObject:data[@"actionType"]];
    
    switch (obj.enumActionType) {
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_USER:
            obj.idShop=[NSNumber numberWithObject:data[@"idShop"]];
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_LIST:
            
            if(data[@"idPlacelist"])
            {
                obj.shopListType=@(USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_PLACELIST);
                obj.idPlacelist=[NSNumber numberWithObject:data[@"idPlacelist"]];
            }
            else if(data[@"keywords"])
            {
                obj.shopListType=@(USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_KEYWORDS);
                obj.keywords=[NSString stringWithStringDefault:data[@"keywords"]];
            }
            else if(data[@"idShops"])
            {
                obj.shopListType=@(USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_IDSHOPS);
                obj.idShops=[NSString stringWithStringDefault:data[@"idShops"]];
            }
            
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_POPUP_URL:
            obj.url=[NSString stringWithStringDefault:data[@"url"]];
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_CONTENT:
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_LOGIN:
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SCAN_CODE:
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_PROMOTION:
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_SETTING:
            break;
    }
    
    return obj;
}

-(enum USER_NOTIFICATION_CONTENT_STATUS)enumStatus
{
    switch (self.status.integerValue) {
        case USER_NOTIFICATION_CONTENT_STATUS_READ:
            return USER_NOTIFICATION_CONTENT_STATUS_READ;
            
        case USER_NOTIFICATION_CONTENT_STATUS_UNREAD:
            return USER_NOTIFICATION_CONTENT_STATUS_UNREAD;
            
        default:
            return USER_NOTIFICATION_CONTENT_STATUS_READ;
    }
}

-(enum USER_NOTIFICATION_CONTENT_ACTION_TYPE)enumActionType
{
    switch (self.actionType.integerValue) {
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_CONTENT:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_CONTENT;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_LOGIN:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_LOGIN;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_POPUP_URL:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_POPUP_URL;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SCAN_CODE:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_SCAN_CODE;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_LIST:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_LIST;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_USER:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_USER;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_PROMOTION:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_PROMOTION;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_SETTING:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_SETTING;
            
        default:
            return USER_NOTIFICATION_CONTENT_ACTION_TYPE_CONTENT;
    }
}

-(enum USER_NOTIFICATION_CONTENT_READ_ACTION)enumReadAction
{
    switch (self.readAction.integerValue) {
        case USER_NOTIFICATION_CONTENT_READ_ACTION_GOTO:
            return USER_NOTIFICATION_CONTENT_READ_ACTION_GOTO;
            
        case USER_NOTIFICATION_CONTENT_READ_ACTION_TOUCH:
            return USER_NOTIFICATION_CONTENT_READ_ACTION_TOUCH;
            
        default:
            return USER_NOTIFICATION_CONTENT_READ_ACTION_TOUCH;
    }
}

-(enum USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE)enumShopListDataType
{
    switch (self.shopListType.integerValue) {
        case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_IDSHOPS:
            return USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_IDSHOPS;
            
        case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_KEYWORDS:
            return USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_KEYWORDS;
            
        case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_PLACELIST:
            return USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_PLACELIST;
            
        case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_UNKNOW:
            return USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_UNKNOW;
            
        default:
            return USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_UNKNOW;
    }
}

-(NSNumber *)idNotification1
{
    return @(1);
}

-(NSString *)logo1
{
    return @"https://trello-avatars.s3.amazonaws.com/53696f6a46925e81408ac1f96f6a7701/30.png";
}

-(NSString *)time1
{
    return @"Nov 22, 2013 11:23 AM";
}

-(NSString *)title1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, ";
}

@end
