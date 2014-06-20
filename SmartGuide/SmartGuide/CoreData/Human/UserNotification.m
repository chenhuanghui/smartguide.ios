#import "UserNotification.h"
#import "UserNotificationContent.h"

@implementation UserNotification
@synthesize displayContentHeight,displayContentAttribute;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.displayContentHeight=@(-1);
    self.displayContentAttribute=nil;
    
    return self;
}

+(UserNotification *)userNotificationWithIDSender:(int)idSender
{
    return [UserNotification queryUserNotificationObject:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_IdSender,idSender]];
}

+(UserNotification *)makeWithDictionary:(NSDictionary *)data
{
    UserNotification *obj=[UserNotification insert];

    obj.idSender=[NSNumber numberWithObject:data[@"idSender"]];
    obj.sender=[NSString stringWithStringDefault:data[@"sender"]];
    
    NSDictionary *dictCount=data[@"count"];
    
    if([dictCount hasData] && [dictCount isKindOfClass:[NSDictionary class]])
    {
        NSArray *array=dictCount[@"number"];
        
        if([array hasData] && array.count==3)
        {
            obj.numberUnread=[NSNumber numberWithObject:array[0]];
            obj.numberRead=[NSNumber numberWithObject:array[1]];
            obj.numberAll=[NSNumber numberWithObject:array[2]];
        }
        else
        {
            obj.numberUnread=@(0);
            obj.numberRead=@(0);
            obj.numberAll=@(0);
        }
        
        array=dictCount[@"string"];
        
        if([array hasData] && array.count==3)
        {
            obj.totalUnread=[NSString stringWithStringDefault:array[0]];
            obj.totalRead=[NSString stringWithStringDefault:array[1]];
            obj.totalAll=[NSString stringWithStringDefault:array[2]];
        }
        else
        {
            obj.totalUnread=@"";
            obj.totalRead=@"";
            obj.totalAll=@"";
        }
    }
    
    obj.status=[NSNumber numberWithObject:data[@"status"]];
    
    if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD)
        obj.highlightUnread=@(true);
        
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

-(NSArray *)notificationContentsObjects
{
    NSArray *array=[super notificationContentsObjects];
    
    if([array hasData])
    {
        return [array sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:UserNotificationContent_Page ascending:true], [NSSortDescriptor sortDescriptorWithKey:UserNotificationContent_SortOrder ascending:true]]];
    }
    
    return array?:@[];
}

-(UserNotificationContent*) firstNotificationContent
{
    NSArray *array=[self notificationContentsObjects];
    
    if([array hasData])
        return array[0];
    
    return nil;
}

-(NSString *)time
{
    UserNotificationContent *obj=[self firstNotificationContent];
    if(obj)
        return obj.time;
    
    return @"";
}

-(NSString *)content
{
    UserNotificationContent *obj=[self firstNotificationContent];
    if(obj)
        return obj.content;
    
    return @"";
}

-(NSString *)displayCount
{
    if(self.totalUnread.length>0 && self.numberUnread.integerValue>0)
        return [NSString stringWithFormat:@"%@ tin chưa đọc",self.totalUnread];
    
    return @"";
}

#if DEBUG
-(NSString *)totalUnread
{
    return @"1";
}
-(NSNumber *)numberUnread
{
    return @(1);
}

#endif

@end