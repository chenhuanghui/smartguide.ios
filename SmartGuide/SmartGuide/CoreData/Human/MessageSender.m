#import "MessageSender.h"

@implementation MessageSender
@synthesize titleRect, contentRect;

+(MessageSender *)makeWithData:(NSDictionary *)data
{
    MessageSender *obj=[MessageSender insert];
    
    obj.idSender=[NSNumber makeNumber:data[@"idSender"]];
    obj.sender=[NSString makeString:data[@"sender"]];
    
    NSDictionary *dictCount=data[@"count"];
    
    if([dictCount hasData] && [dictCount isKindOfClass:[NSDictionary class]])
    {
        NSArray *array=dictCount[@"number"];
        
        [obj updateNumbers:array];
        
        array=dictCount[@"string"];
        
        [obj updateTotals:array];
    }
    
    obj.status=[NSNumber makeNumber:data[@"status"]];
    
    if(obj.enumStatus==MESSAGE_VIEW_STATUS_UNREAD)
        obj.highlightUnread=@(true);
    
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

-(void)updateNumbers:(NSArray *)array
{
    if([array hasData] && array.count==3)
    {
        self.countUnread=[NSNumber makeNumber:array[0]];
        self.countRead=[NSNumber makeNumber:array[1]];
        self.countAll=[NSNumber makeNumber:array[2]];
    }
    else
    {
        self.countUnread=@(0);
        self.countRead=@(0);
        self.countAll=@(0);
    }
}

-(void)updateTotals:(NSArray *)array
{
    if([array hasData] && array.count==3)
    {
        self.numUnread=[NSString makeString:array[0]];
        self.numRead=[NSString makeString:array[1]];
        self.numAll=[NSString makeString:array[2]];
    }
    else
    {
        self.numUnread=@"";
        self.numRead=@"";
        self.numAll=@"";
    }
}

@end
