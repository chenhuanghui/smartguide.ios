//
//  ASIOperationUserPromotionDetail.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"
#import "UserNotification.h"
#import "UserNotificationContent.h"

@interface ASIOperationUserNotificationContent : ASIOperationPost

-(ASIOperationUserNotificationContent*) initWithIDNotification:(int) idNotification page:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *notifications;

@end
