//
//  ASIOperationNotificationCheck.h
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationNotificationCount : ASIOperationPost

-(ASIOperationNotificationCount*) initWithUserLat:(double) userLat userLng:(double) userLng uuid:(NSString*) uuid;

@property (nonatomic, strong) NSString *numOfNotification;
@property (nonatomic, strong) NSNumber *totalNotification;

@end
