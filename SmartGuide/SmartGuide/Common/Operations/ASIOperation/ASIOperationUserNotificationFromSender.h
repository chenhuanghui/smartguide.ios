//
//  ASIOperationUserPromotionDetail.h
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface ASIOperationUserNotificationFromSender : ASIOperationPost

-(ASIOperationUserNotificationFromSender*) initWithIDSender:(NSNumber*) idSender page:(int) page userLat:(double) userLat userLng:(double) userLng;

@property (nonatomic, strong) NSMutableArray *notifications;
@property (nonatomic, strong) NSString *sender;

@end
