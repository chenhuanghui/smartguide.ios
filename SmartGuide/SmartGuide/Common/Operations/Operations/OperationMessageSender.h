//
//  OperationMessageSender.h
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

enum MESSAGE_SENDER_TYPE
{
    MESSAGE_SENDER_TYPE_UNREAD=0,
    MESSAGE_SENDER_TYPE_READ=1,
    MESSAGE_SENDER_TYPE_ALL=2,
};

@interface OperationMessageSender : ASIOperationPost

-(OperationMessageSender*) initWithPage:(int) page type:(enum MESSAGE_SENDER_TYPE) type userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *messages;

@end