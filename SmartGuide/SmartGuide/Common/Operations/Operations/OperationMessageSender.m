//
//  OperationMessageSender.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationMessageSender.h"
#import "MessageSender.h"
#import "MessageList.h"

@implementation OperationMessageSender

-(OperationMessageSender *)initWithPage:(int)page type:(enum MESSAGE_SENDER_TYPE)type userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_NEWEST)];
    
    [self.keyValue setObject:@(page) forKey:PAGE];
    [self.keyValue setObject:@(type) forKey:@"type"];
    [self.keyValue setObject:@(userLat) forKey:USER_LATITUDE];
    [self.keyValue setObject:@(userLng) forKey:USER_LONGITUDE];
    
    return self;
}

-(void)onFinishLoading
{
    self.messages=[NSMutableArray new];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if(![json hasData])
        return;
    
    for(NSDictionary *dict in json)
    {
        MessageSender *obj=[MessageSender makeWithData:dict];
        
        NSDictionary *newestMessage=dict[@"newestMessage"];
        
        if([newestMessage hasData])
        {
            MessageList *msg=[MessageList makeWithData:newestMessage];
            
            obj.content=msg.content;
            obj.messageNewest=msg;
        }
        else
            obj.content=@"";
        
        [self.messages addObject:obj];
    }
    
    if(self.messages.count>0)
        [[DataManager shareInstance] save];
}

@end
