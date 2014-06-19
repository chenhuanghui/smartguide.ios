//
//  OperationNotificationAction.m
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationNotificationAction.h"

@implementation OperationNotificationAction

+(OperationNotificationAction *)operationWithURL:(NSString *)url method:(NSString *)method params:(NSString *)params
{
    return [[OperationNotificationAction alloc] initWithURL:url method:method params:params];
}

-(OperationNotificationAction *)initWithURL:(NSString *)url method:(NSString *)method params:(NSString *)params
{
    enum OPERATION_METHOD_TYPE methodType=[method isEqualToString:@"POST"]?OPERATION_METHOD_TYPE_POST:OPERATION_METHOD_TYPE_GET;
    
    self=[super initRouterWithMethod:methodType url:url];
    
    [self.keyValue setObject:params forKey:@"params"];
    
    return self;
}

@end
