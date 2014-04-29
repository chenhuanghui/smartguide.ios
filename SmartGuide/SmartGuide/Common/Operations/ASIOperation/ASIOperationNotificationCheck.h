//
//  ASIOperationNotificationCheck.h
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationNotificationCheck : ASIOperationPost

-(ASIOperationNotificationCheck*) initWithUserLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSNumber *totalNotification;

@end
