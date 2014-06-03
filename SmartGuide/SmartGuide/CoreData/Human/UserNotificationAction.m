#import "UserNotificationAction.h"

@implementation UserNotificationAction

+(UserNotificationAction *)makeWithAction:(NSDictionary *)action
{
    UserNotificationAction *obj=[UserNotificationAction insert];
    obj.actionTitle=[NSString stringWithStringDefault:action[@"actionTitle"]];
    obj.actionType=[NSNumber numberWithObject:action[@"actionType"]];
    
    switch (obj.enumActionType) {
        case NOTIFICATION_ACTION_TYPE_UNKNOW:
            
            break;
            
        case NOTIFICATION_ACTION_TYPE_CALL_API:
            obj.url=[NSString stringWithStringDefault:action[@"url"]];
            obj.method=[NSNumber numberWithObject:action[@"method"]];
            obj.params=[NSString stringWithStringDefault:action[@"params"]];
            break;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_USER:
            obj.idShop=[NSNumber numberWithObject:action[@"idShop"]];
            break;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            if(action[@"idPlacelist"])
                obj.idPlacelist=[NSNumber numberWithObject:action[@"idPlacelist"]];
            else
            {
                NSString *str=[NSString stringWithStringDefault:action[@"keywords"]];
                
                if(str.length>0)
                    obj.keywords=str;
                else
                {
                    str=[NSString stringWithStringDefault:action[@"idShops"]];
                    
                    if(str.length>0)
                        obj.idShops=str;
                }
            }
            break;
            
        case NOTIFICATION_ACTION_TYPE_POPUP_URL:
            obj.url=[NSString stringWithStringDefault:action[@"url"]];
            break;
            
        case NOTIFICATION_ACTION_TYPE_USER_SETTING:
        case NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            break;
    }
    
    return obj;
}

-(enum NOTIFICATION_ACTION_TYPE)enumActionType
{
    switch (self.actionType.integerValue) {
        case NOTIFICATION_ACTION_TYPE_CALL_API:
            return NOTIFICATION_ACTION_TYPE_CALL_API;
            
        case NOTIFICATION_ACTION_TYPE_POPUP_URL:
            return NOTIFICATION_ACTION_TYPE_POPUP_URL;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            return NOTIFICATION_ACTION_TYPE_SHOP_LIST;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_USER:
            return NOTIFICATION_ACTION_TYPE_SHOP_USER;
            
        case NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            return NOTIFICATION_ACTION_TYPE_USER_PROMOTION;
            
        case NOTIFICATION_ACTION_TYPE_USER_SETTING:
            return NOTIFICATION_ACTION_TYPE_USER_SETTING;
            
        default:
            return NOTIFICATION_ACTION_TYPE_UNKNOW;
    }
}

-(enum NOTIFICATION_METHOD_TYPE)enumMethodType
{
    if(!self.method)
        return NOTIFICATION_METHOD_TYPE_UNKNOW;
    
    switch (self.method.integerValue) {
        case NOTIFICATION_METHOD_TYPE_GET:
            return NOTIFICATION_METHOD_TYPE_GET;
            
        case NOTIFICATION_METHOD_TYPE_POST:
            return NOTIFICATION_METHOD_TYPE_POST;
            
        default:
            return NOTIFICATION_METHOD_TYPE_UNKNOW;
    }
}

-(NSString *)methodName
{
    switch (self.enumMethodType) {
        case NOTIFICATION_METHOD_TYPE_GET:
            return @"GET";
            
        case NOTIFICATION_METHOD_TYPE_POST:
            return @"POST";
            
        case NOTIFICATION_METHOD_TYPE_UNKNOW:
            return @"";
    }
}

-(enum NOTIFICATION_ACTION_SHOP_LIST_TYPE)enumShopListDataType
{
    if(self.idPlacelist)
        return NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDPLACELIST;
    
    if(self.idShops.length>0)
        return NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDSHOPS;
    
    return NOTIFICATION_ACTION_SHOP_LIST_TYPE_KEYWORDS;
}

@end
