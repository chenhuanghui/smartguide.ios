//
//  OperationNotificationCountBySender.h
//  Infory
//
//  Created by XXX on 6/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationNotificationCountBySender : ASIOperationPost

-(OperationNotificationCountBySender*) initWithIDSender:(int) idSender type:(enum NOTIFICATION_COUNT_TYPE) type userLat:(double) userLat userLng:(double) userLng;

@end
