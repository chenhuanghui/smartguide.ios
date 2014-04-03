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
    
    obj.idNotification=[NSNumber numberWithObject:data[UserNotificationContent_IdNotification]];
    obj.logo=[NSString stringWithStringDefault:data[UserNotificationContent_Logo]];
    obj.time=[NSString stringWithStringDefault:data[UserNotificationContent_Time]];
    obj.title=[NSString stringWithStringDefault:data[UserNotificationContent_Title]];
    obj.desc=[NSString stringWithStringDefault:data[@"description"]];
    obj.type=[NSNumber numberWithObject:data[@"type"]];
    
    obj.goTo=rand()%2!=0?@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat":@"";
    
    if(obj.enumType!=USER_NOTIFICATION_CONTENT_TYPE_NONE)
    {
        NSDictionary *dict=data[@"data"];
        
        if(![dict isNullData])
        {
            obj.goTo=[NSString stringWithStringDefault:dict[@"goTo"]];
            
            switch (obj.enumType) {
                case USER_NOTIFICATION_CONTENT_TYPE_NONE:
                    break;
                    
                case USER_NOTIFICATION_CONTENT_TYPE_SHOP_DETAIL:
                    obj.idShop=[NSNumber numberWithObject:data[@"idShop"]];
                    break;
                    
                case USER_NOTIFICATION_CONTENT_TYPE_SHOP_LIST:
                    
                    if(data[@"idPlacelist"])
                        obj.idPlacelist=[NSNumber numberWithObject:data[@"idPlacelist"]];
                    
                    if(data[@"keywords"])
                        obj.keywords=[NSString stringWithStringDefault:data[@"keywords"]];
                    
                    if(data[@"idShops"])
                        obj.idShops=[NSString stringWithStringDefault:data[@"idShops"]];
                    
                    break;
                    
                case USER_NOTIFICATION_CONTENT_TYPE_TUTORIAL:
                    obj.urlTutorial=[NSString stringWithStringDefault:data[@"url"]];
                    break;
            }
        }
    }
    
    return obj;
}

-(enum USER_NOTIFICATION_CONTENT_TYPE)enumType
{
    switch (self.type.integerValue) {
        case USER_NOTIFICATION_CONTENT_TYPE_NONE:
            return USER_NOTIFICATION_CONTENT_TYPE_NONE;
            
        case USER_NOTIFICATION_CONTENT_TYPE_SHOP_DETAIL:
            return USER_NOTIFICATION_CONTENT_TYPE_SHOP_DETAIL;
            
        case USER_NOTIFICATION_CONTENT_TYPE_SHOP_LIST:
            return USER_NOTIFICATION_CONTENT_TYPE_SHOP_LIST;
            
        case USER_NOTIFICATION_CONTENT_TYPE_TUTORIAL:
            return USER_NOTIFICATION_CONTENT_TYPE_TUTORIAL;
            
        default:
            return USER_NOTIFICATION_CONTENT_TYPE_NONE;
    }
}

-(NSNumber *)idNotification
{
    return @(1);
}

-(NSString *)logo
{
    return @"https://trello-avatars.s3.amazonaws.com/07f2507dfa4cc9da9fa65a7c4b0ab9de/30.png";
}

-(NSString *)time
{
    return @"Nov 22, 2013 11:23 AM";
}

-(NSString *)desc
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
}

-(NSString *)title
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, ";
}

-(NSString *)goTo1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat";
}

@end
