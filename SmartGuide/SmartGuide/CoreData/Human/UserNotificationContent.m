#import "UserNotificationContent.h"

@implementation UserNotificationContent
@synthesize titleHeight,contentHeight,titleAttribute,contentAttribute,actionsHeight,imageHeightForNoti,videoHeightForNoti,videoPlaytime;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.titleHeight=@(-1);
    self.contentHeight=@(-1);
    self.actionsHeight=@(-1);
    self.imageHeightForNoti=@(-1);
    self.videoHeightForNoti=@(-1);
    self.videoPlaytime=@(0);
    
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
    
    if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD)
        obj.highlightUnread=@(true);
    
    if(data[@"image"])
    {
        obj.image=[NSString stringWithStringDefault:data[@"image"]];
        obj.imageWidth=[NSNumber numberWithObject:data[@"imageWidth"]];
        obj.imageHeight=[NSNumber numberWithObject:data[@"imageHeight"]];
    }
    
    if(data[@"video"])
    {
        obj.video=[NSString stringWithStringDefault:data[@"video"]];
        obj.videoWidth=[NSNumber numberWithObject:data[@"videoWidth"]];
        obj.videoHeight=[NSNumber numberWithObject:data[@"videoHeight"]];
        obj.videoThumbnail=[NSString stringWithStringDefault:data[@"videoThumbnail"]];
    }
    
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

#if DEBUG
-(NSString *)title1
{
    return @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod";
}
#endif

-(NSNumber *)imageWidth
{
    NSNumber *num=[super imageWidth];
    
    if(num.floatValue==0)
        return @(1);
    
    return num;
}

-(NSNumber *)videoWidth
{
    NSNumber *num=[super videoWidth];
    
    if(num.floatValue==0)
        return @(1);
    
    return num;
}

@end
