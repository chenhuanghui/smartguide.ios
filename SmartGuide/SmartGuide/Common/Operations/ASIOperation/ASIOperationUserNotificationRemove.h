//
//  ASIOperationUserNotificationRemove.h
//  Infory
//
//  Created by XXX on 5/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUserNotificationRemove : ASIOperationPost

-(ASIOperationUserNotificationRemove*) initWithIDNotification:(NSNumber*) idNotification idSender:(NSNumber*) idSender userLat:(double) userLat userLng:(double) userLng;

@end
