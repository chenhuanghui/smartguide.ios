//
//  OperationNotificationAction.h
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationPost.h"

@interface OperationNotificationAction : ASIOperationPost

+(OperationNotificationAction*) operationWithURL:(NSString*) url method:(NSString*) method params:(NSString*) params;
-(OperationNotificationAction*) initWithURL:(NSString*) url method:(NSString*) method params:(NSString*) params;

@end
