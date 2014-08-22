#import "UserNotificationContent.h"

@implementation UserNotificationContent
@synthesize titleHeight,contentHeight,titleAttribute,contentAttribute,actionsHeight,imageHeightForNoti,videoHeightForNoti,videoPlaytime, titleFrame, titleFrameFull, timeFrame, contentFrame;

-(id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    self.titleHeight=@(-1);
    self.contentHeight=@(-1);
    self.actionsHeight=@(-1);
    self.imageHeightForNoti=@(-1);
    self.videoHeightForNoti=@(-1);
    self.videoPlaytime=@(0);
    self.displayType=@(0);
    
    return self;
}

+(UserNotificationContent *)userNotifcationContentWithIDSender:(int)idSender IDMessage:(int)idMessage
{
    return [self queryUserNotificationContentObject:[NSPredicate predicateWithFormat:@"%K==%i && %K==%i", UserNotificationContent_IdSender, idSender, UserNotificationContent_IdMessage, idMessage]];
}

+(UserNotificationContent *)makeWithDictionary:(NSDictionary *)data
{
    UserNotificationContent *obj=[UserNotificationContent insert];
    
    obj.sender=[NSString makeString:data[@"sender"]];
    obj.idMessage=[NSNumber makeNumber:data[@"idMessage"]];
    obj.logo=[NSString makeString:data[@"logo"]];
    
    if(data[@"idShop"])
        obj.idShopLogo=[NSNumber makeNumber:data[@"idShop"]];
    
    obj.time=[NSString makeString:data[@"time"]];
    obj.title=[NSString makeString:data[@"title"]];
    obj.content=[NSString makeString:data[@"content"]];
    obj.status=[NSNumber makeNumber:data[@"status"]];
    
    if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD)
        obj.highlightUnread=@(true);
    
    if([data[@"image"] hasData])
    {
        obj.image=[NSString makeString:data[@"image"]];
        obj.imageWidth=[NSNumber makeNumber:data[@"imageWidth"]];
        obj.imageHeight=[NSNumber makeNumber:data[@"imageHeight"]];
    }
    
    if([data[@"video"] hasData])
    {
        obj.video=[NSString makeString:data[@"video"]];
        obj.videoWidth=[NSNumber makeNumber:data[@"videoWidth"]];
        obj.videoHeight=[NSNumber makeNumber:data[@"videoHeight"]];
        obj.videoThumbnail=[NSString makeString:data[@"videoThumbnail"]];
    }
    
    NSArray *actions=data[@"buttons"];
    if([actions hasData])
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
    switch ((enum NOTIFICATION_STATUS) self.status.intValue) {
        case NOTIFICATION_STATUS_READ:
            return NOTIFICATION_STATUS_READ;
            
        case NOTIFICATION_STATUS_UNREAD:
            return NOTIFICATION_STATUS_UNREAD;
    }
    
    return NOTIFICATION_STATUS_READ;
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
