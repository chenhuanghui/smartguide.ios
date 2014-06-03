//
//  OperationNotificationAction.h
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AFOperation.h"

@interface OperationNotificationAction : AFOperation

+(AFOperation*) operationWithURL:(NSString*) url method:(NSString*) method params:(NSString*) params;

@end
