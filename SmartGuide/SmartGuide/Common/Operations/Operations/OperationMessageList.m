//
//  OperationMessageList.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationMessageList.h"
#import "MessageList.h"

@implementation OperationMessageList

-(OperationMessageList *)initWithIDSender:(int)idSender page:(int)page userLat:(double)userLat userLng:(double)userLng
{
    self=[super initPOSTWithURL:SERVER_API_URL_MAKE(API_USER_NOTIFICATION_LIST_BY_SENDER)];
    
    [self.keyValue setObject:@(idSender) forKey:@"idSender"];
    [self.keyValue setObject:@(page) forKey:PAGE];
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
        MessageList *obj=[MessageList makeWithData:dict];
        
        [self.messages addObject:obj];
    }
    
    if(self.messages.count>0)
        [[DataManager shareInstance] save];
}

@end
