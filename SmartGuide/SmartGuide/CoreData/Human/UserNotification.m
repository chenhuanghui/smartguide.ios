#import "UserNotification.h"

@implementation UserNotification
@synthesize contentHeight;
@synthesize contentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.contentHeight=@(-1);
    self.contentAttribute=nil;
    
    return self;
}

+(UserNotification *)makeWithDictionary:(NSDictionary *)data
{
    UserNotification *obj=[UserNotification insert];

    obj.idNotification=[NSNumber numberWithObject:data[@"idNotification"]];
    obj.sender=[NSString stringWithStringDefault:data[@"sender"]];
    obj.content=[NSString stringWithStringDefault:data[@"content"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    obj.status=[NSNumber numberWithObject:data[@"status"]];
    obj.actionType=[NSNumber numberWithObject:data[@"actionType"]];
    obj.readAction=[NSNumber numberWithObject:data[@"readAction"]];
    
    obj.highlight=@"";
    NSMutableArray *array=data[@"highlight"];
    
    if(array && [array isKindOfClass:[NSArray class]])
    {
        obj.highlight=[array componentsJoinedByString:@";"];
    }
    
    switch (obj.enumActionType) {
        case USER_NOTIFICATION_ACTION_TYPE_SHOP_USER:
            obj.idShop=[NSNumber numberWithObject:data[@"idShop"]];
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            
            if(data[@"idPlacelist"])
                obj.idPlacelist=[NSNumber numberWithObject:data[@"idPlacelist"]];
            else if(data[@"keywords"])
                obj.keywords=[NSString stringWithStringDefault:data[@"keywords"]];
            else if(data[@"idShops"])
                obj.idShops=[NSString stringWithStringDefault:data[@"idShops"]];
            
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_POPUP_URL:
            obj.url=[NSString stringWithStringDefault:@"url"];
            
        case USER_NOTIFICATION_ACTION_TYPE_CONTENT:
        case USER_NOTIFICATION_ACTION_TYPE_USER_SETTING:
        case USER_NOTIFICATION_ACTION_TYPE_LOGIN:
        case USER_NOTIFICATION_ACTION_TYPE_SCAN_CODE:
        case USER_NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            break;
    }
    
    return obj;
}

-(enum USER_NOTIFICATION_SHOP_LIST_DATA_TYPE)enumShopListDataType
{
    if(self.idPlacelist)
        return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_PLACELIST;
    else if(self.keywords.length>0)
        return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_KEYWORDS;
    else if(self.idShops.length>0)
        return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_IDSHOPS;
    
    return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_UNKNOW;
}

-(NSArray *)highlightIndex
{
    if(self.highlight.length>0)
        return [self.highlight componentsSeparatedByString:@";"];
    
    return [NSArray new];
}

-(NSString *)content1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
}

-(NSString *)time1
{
    return @"Nov 22, 2013 11:23 AM";
}

-(NSNumber *)status1
{
    return @(rand()%2==0);
}

-(enum USER_NOTIFICATION_STATUS)enumStatus
{
    switch (self.status.intValue) {
        case USER_NOTIFICATION_STATUS_READ:
            return USER_NOTIFICATION_STATUS_READ;

        case USER_NOTIFICATION_STATUS_UNREAD:
            return USER_NOTIFICATION_STATUS_UNREAD;
            
        default:
            return USER_NOTIFICATION_STATUS_READ;
    }
}

-(enum USER_NOTIFICATION_ACTION_TYPE)enumActionType
{
    switch (self.actionType.integerValue) {
        case USER_NOTIFICATION_ACTION_TYPE_CONTENT:
            return USER_NOTIFICATION_ACTION_TYPE_CONTENT;
            
        case USER_NOTIFICATION_ACTION_TYPE_LOGIN:
            return USER_NOTIFICATION_ACTION_TYPE_LOGIN;
            
        case USER_NOTIFICATION_ACTION_TYPE_POPUP_URL:
            return USER_NOTIFICATION_ACTION_TYPE_POPUP_URL;
            
        case USER_NOTIFICATION_ACTION_TYPE_SCAN_CODE:
            return USER_NOTIFICATION_ACTION_TYPE_SCAN_CODE;
            
        case USER_NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            return USER_NOTIFICATION_ACTION_TYPE_SHOP_LIST;
            
        case USER_NOTIFICATION_ACTION_TYPE_SHOP_USER:
            return USER_NOTIFICATION_ACTION_TYPE_SHOP_USER;
            
        case USER_NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            return USER_NOTIFICATION_ACTION_TYPE_USER_PROMOTION;
            
        case USER_NOTIFICATION_ACTION_TYPE_USER_SETTING:
            return USER_NOTIFICATION_ACTION_TYPE_USER_SETTING;
            
        default:
            return USER_NOTIFICATION_ACTION_TYPE_CONTENT;
    }
}

-(enum USER_NOTIFICATION_READ_ACTION)enumReadAction
{
    switch (self.readAction.integerValue) {
        case USER_NOTIFICATION_READ_ACTION_GOTO:
            return USER_NOTIFICATION_READ_ACTION_GOTO;
            
        case USER_NOTIFICATION_READ_ACTION_TOUCH:
            return USER_NOTIFICATION_READ_ACTION_TOUCH;
            
        default:
            return USER_NOTIFICATION_READ_ACTION_TOUCH;
    }
}

@end
