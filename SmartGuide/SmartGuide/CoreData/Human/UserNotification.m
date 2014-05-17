#import "UserNotification.h"
#import "ASIOperationUserNotificationRead.h"
#import "NotificationManager.h"

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

+(UserNotification *)userNotificationWithIDNotification:(int)idNotification
{
    return [UserNotification queryUserNotificationObject:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_IdNotification,idNotification]];
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
            {
                obj.shopListType=@(USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_PLACELIST);
                obj.idPlacelist=[NSNumber numberWithObject:data[@"idPlacelist"]];
            }
            else if(data[@"keywords"])
            {
                obj.shopListType=@(USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_KEYWORDS);
                obj.keywords=[NSString stringWithStringDefault:data[@"keywords"]];
            }
            else if(data[@"idShops"])
            {
                obj.shopListType=@(USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_IDSHOPS);
                obj.idShops=[NSString stringWithStringDefault:data[@"idShops"]];
            }
            
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_POPUP_URL:
            obj.url=[NSString stringWithStringDefault:data[@"url"]];
            
        case USER_NOTIFICATION_ACTION_TYPE_CONTENT:
        case USER_NOTIFICATION_ACTION_TYPE_USER_SETTING:
        case USER_NOTIFICATION_ACTION_TYPE_LOGIN:
        case USER_NOTIFICATION_ACTION_TYPE_SCAN_CODE:
        case USER_NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            //Nothing do in here
            break;
    }
    
    return obj;
}

-(enum USER_NOTIFICATION_SHOP_LIST_DATA_TYPE)enumShopListDataType
{
    switch (self.shopListType.integerValue) {
        case USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_IDSHOPS:
            return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_IDSHOPS;
            
        case USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_KEYWORDS:
            return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_KEYWORDS;
            
        case USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_PLACELIST:
            return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_PLACELIST;
            
        case USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_UNKNOW:
            return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_UNKNOW;
            
        default:
            return USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_UNKNOW;
    }
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
    return USER_NOTIFICATION_ACTION_TYPE_CONTENT;
    
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

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ id %i status %i action %i read %i idShop %i idPlacelist %i keywords %@ idShops %@ url %@",CLASS_NAME,self.idNotification.integerValue,self.status.integerValue,self.actionType.integerValue,self.readAction.integerValue,self.idShop.integerValue,self.idPlacelist.integerValue,self.keywords,self.idShops,self.url];
}

-(NSString *)url1
{
    return @"http://google.com";
}

-(NSNumber *)idPlacelist1
{
    return @(-1);
}

-(NSNumber *)shopListType1
{
    return @(USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_IDSHOPS);
}

-(NSString *)idShops1
{
    return @"112,113,114";
}

@end