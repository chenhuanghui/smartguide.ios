//
//  AFOperation+API.h
//  Infory
//
//  Created by XXX on 6/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOperation.h"

@interface AFOperation(API)

+(AFOperation*) operationActionWithURL:(NSString*) url method:(NSString*) method params:(NSString*) params;
+(AFOperation*) operationUserNotificationRemoveWithIDSender:(NSNumber*) idSender idNotification:(NSNumber*) idNotification userLat:(NSNumber*) userLat userLng:(NSNumber*) userLng deletegate:(id<AFOperationDelegate>) delegate;
+(AFOperation*) operationUserNotificationNewestWithPage:(NSNumber*) page type:(NSNumber*) type userLat:(NSNumber*) userLat userLng:(NSNumber*) userLng delegate:(id<AFOperationDelegate>) delegate;

@end
