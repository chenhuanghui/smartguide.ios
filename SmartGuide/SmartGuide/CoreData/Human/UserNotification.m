#import "UserNotification.h"
#import "ASIOperationUserNotificationMarkRead.h"
#import "NotificationManager.h"

@implementation UserNotification
@synthesize displayContentHeight,displayContentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.displayContentHeight=@(-1);
    self.displayContentAttribute=nil;
    
    return self;
}

+(UserNotification *)userNotificationWithIDNotification:(int)idNotification
{
    return [UserNotification queryUserNotificationObject:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_IdNotification,idNotification]];
}

+(UserNotification *)makeWithDictionary:(NSDictionary *)data
{
    UserNotification *obj=[UserNotification insert];

    obj.idSender=[NSNumber numberWithObject:data[@"idSender"]];
    obj.sender=[NSString stringWithStringDefault:data[@"sender"]];
    obj.idNotification=[NSNumber numberWithObject:data[@"idNotification"]];
    obj.logo=[NSString stringWithStringDefault:data[@"logo"]];
    obj.time=[NSString stringWithStringDefault:data[@"time"]];
    obj.title=[NSString stringWithStringDefault:data[@"title"]];
    obj.content=[NSString stringWithStringDefault:data[@"content"]];
    obj.status=[NSNumber numberWithObject:data[@"status"]];
    
    NSArray *actions=data[@"actions"];
    
    if(![actions isNullData])
    {
        int i=0;
        for(NSDictionary *dict in actions)
        {
            UserNotificationAction *action=[UserNotificationAction makeWithAction:dict];
            action.sortOrder=@(i++);
            
            [obj addActionsObject:action];
        }
    }
    
    return obj;
}

-(enum NOTIFICATION_STATUS)enumStatus
{
    switch (self.status.intValue) {
        case NOTIFICATION_STATUS_READ:
            return NOTIFICATION_STATUS_READ;

        case NOTIFICATION_STATUS_UNREAD:
            return NOTIFICATION_STATUS_UNREAD;

        default:
            return NOTIFICATION_STATUS_READ;
    }
}

@end