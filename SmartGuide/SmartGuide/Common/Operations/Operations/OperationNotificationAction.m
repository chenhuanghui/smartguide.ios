//
//  OperationNotificationAction.m
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationNotificationAction.h"

@implementation OperationNotificationAction

+(AFOperation *)operationWithURL:(NSString *)url method:(NSString *)method params:(NSString *)params
{
    return [[AFHTTPRequestOperationManager manager] requestWithMethod:method url:url parameters:[params jsonDictionary] delegate:nil];
}

@end
