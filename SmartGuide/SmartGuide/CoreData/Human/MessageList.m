#import "MessageList.h"
#import "MessageAction.h"

@implementation MessageList
@synthesize titleRectSmall, titleRectFull, contentRect, timeRect;

+(MessageList *)makeWithData:(NSDictionary *)data
{
    MessageList *obj=[MessageList insert];
    
    obj.idMessage=[NSNumber makeNumber:data[@"idMessage"]];
    obj.logo=[NSString makeString:data[@"logo"]];
    
    if(data[@"idShop"])
        obj.idShop=[NSNumber makeNumber:data[@"idShop"]];
    
    obj.time=[NSString makeString:data[@"time"]];
    obj.title=[NSString makeString:data[@"title"]];
    obj.content=[NSString makeString:data[@"content"]];
    obj.status=[NSNumber makeNumber:data[@"status"]];
    
    if(obj.enumStatus==MESSAGE_VIEW_STATUS_UNREAD)
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
            MessageAction *action=[MessageAction makeWithData:dict];
            action.sortOrder=@(i++);
            
            [obj addActionsObject:action];
        }
    }
    
    return obj;
}

-(enum MESSAGE_VIEW_STATUS)enumStatus
{
    switch ((enum MESSAGE_VIEW_STATUS)self.status) {
        case MESSAGE_VIEW_STATUS_READ:
            return MESSAGE_VIEW_STATUS_READ;
            
        case MESSAGE_VIEW_STATUS_UNREAD:
            return MESSAGE_VIEW_STATUS_UNREAD;
    }
    
    return MESSAGE_VIEW_STATUS_UNREAD;
}

@end
