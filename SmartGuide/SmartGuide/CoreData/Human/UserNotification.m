#import "UserNotification.h"
#import "ASIOperationUserNotificationMarkRead.h"
#import "NotificationManager.h"

@implementation UserNotification
@synthesize displayContentHeight,displayContentAttribute,actionsHeight;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.displayContentHeight=@(-1);
    self.displayContentAttribute=nil;
    self.actionsHeight=@(-1);
    
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
    
    if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD)
        obj.highlightUnread=@(true);
    
    NSArray *actions=data[@"actions"];
    
    NSMutableArray *array=[NSMutableArray array];
    
    for(int i=0;i<5;i++)
    {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        
        [dict setObject:[NSString stringWithFormat:@"action %i",i] forKey:@"actionTitle"];
        [dict setObject:@(i) forKey:@"actionType"];
        
        switch ([dict[@"actionType"] integerValue]) {
            case 0:
                [dict setObject:@"user/notification/markRead" forKey:@"url"];
                [dict setObject:@"method" forKey:@"POST"];
                
                
                [dict setObject:[@{@"idNotification":obj.idNotification,@"userLat":@(userLat()),@"userLng":@(userLng())} jsonString] forKey:@"params"];
                break;
                
            case 1:
                [dict setObject:@(1000) forKey:@"idShop"];
                break;
                
            case 2:
                
                switch (random_int(0, 2)) {
                    case 0:
                        [dict setObject:[dict[@"actionTitle"] stringByAppendingString:@" placelist" ] forKey:@"actionTitle"];
                        [dict setObject:@"-1" forKey:@"idPlacelist"];
                        break;
                        
                    case 1:
                        [dict setObject:[dict[@"actionTitle"] stringByAppendingString:@" keywords" ] forKey:@"actionTitle"];
                        [dict setObject:@"a" forKey:@"keywords"];
                        break;
                        
                    case 2:
                        [dict setObject:[dict[@"actionTitle"] stringByAppendingString:@" idShops" ] forKey:@"actionTitle"];
                        [dict setObject:@"111,112,113" forKey:@"isShops"];
                        break;
                        
                    default:
                        break;
                }
                
                break;
                
            case 3:
                [dict setObject:@"google.com" forKey:@"url"];
                break;
                
            default:
                break;
        }
        
        [array addObject:dict];
    }
    
    actions=array;
    
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

-(NSArray *)actionTitles
{
    if(self.actionsObjects.count>0)
        return [self.actionsObjects valueForKey:UserNotificationAction_ActionTitle];
    
    return [NSArray array];
}

-(NSArray *)actionsObjects
{
    if([super actionsObjects].count>0)
    {
        return [[super actionsObjects] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserNotificationAction_SortOrder ascending:true]]];
    }
    
    return [NSArray array];
}

-(UserNotificationAction *)actionFromTitle:(NSString *)title
{
    if([super actionsObjects].count>0)
    {
        NSArray *array=[[super actionsObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K LIKE %@",UserNotificationAction_ActionTitle,title]];
        
        if(array.count>0)
            return array[0];
    }
    
    return nil;
}

@end