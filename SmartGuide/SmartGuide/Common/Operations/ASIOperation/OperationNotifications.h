//
//  ASIOperationNotifications.h
//  SmartGuide
//
//  Created by MacMini on 9/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@class NotificationObject,NotificationItem;

@interface OperationNotifications : ASIOperationPost

-(OperationNotifications*) initVersion:(NSString*) version;

@property (nonatomic, strong) NotificationObject *object;

@end

@interface NotificationObject : NSObject<NSCopying>

@property (nonatomic, assign) int notificationType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *notificationList;
@property (nonatomic, strong) NSString *link;

@end

@interface NotificationItem : NSObject<NSCopying>

@property (nonatomic, assign) int idNotification;
@property (nonatomic, strong) NSString *content;

@end