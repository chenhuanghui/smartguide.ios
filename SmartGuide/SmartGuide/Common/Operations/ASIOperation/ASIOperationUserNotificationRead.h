//
//  ASIOperationUserNotificationRead.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUserNotificationRead : ASIOperationPost

-(ASIOperationUserNotificationRead*) initWithIDNotification:(int) idNotification userLat:(double) userLat userLng:(double) userLng uuid:(NSString*) uuid;

@end
