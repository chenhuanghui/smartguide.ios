//
//  ASIOperationNotificationCheck.h
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationNotificationCount : ASIOperationPost

-(ASIOperationNotificationCount*) initWithCountType:(enum NOTIFICATION_COUNT_TYPE) countType userLat:(double) userLat userLng:(double) userLng uuid:(NSString*) uuid;

@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) NSArray *strings;

@end
