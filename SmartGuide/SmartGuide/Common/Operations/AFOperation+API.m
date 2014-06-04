//
//  AFOperation+API.m
//  Infory
//
//  Created by XXX on 6/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AFOperation+API.h"

#define _USER_LATITUDE @"userLat"
#define _USER_LONGITUDE @"userLng"
#define _IDSENDER @"idSender"
#define _IDNOTIFICATION @"idNotification"
#define _PAGE @"page"
#define _TYPE @"type"

@implementation AFOperation(API)

+(AFOperation *)operationActionWithURL:(NSString *)url method:(NSString *)method params:(NSString *)params
{
    return [[AFOperationManager shareInstance] requestWithMethod:method url:url parameters:[params jsonDictionary] delegate:nil];
}

+(AFOperation *)operationUserNotificationRemoveWithIDSender:(NSNumber *)idSender idNotification:(NSNumber *)idNotification userLat:(NSNumber *)userLat userLng:(NSNumber *)userLng deletegate:(id<AFOperationDelegate>)delegate
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:userLat forKey:_USER_LATITUDE];
    [dict setObject:userLng forKey:_USER_LONGITUDE];
    
    if(idSender)
        [dict setObject:idSender forKey:_IDSENDER];
    if(idNotification)
        [dict setObject:idNotification forKey:_IDNOTIFICATION];
    
    return [[AFOperationManager shareInstance] afPOST:API_USER_NOTIFICATION_REMOVE parameters:@{_IDSENDER:idSender,_IDNOTIFICATION:idNotification,} delegate:delegate];
}

+(AFOperation *)operationUserNotificationNewestWithPage:(NSNumber *)page type:(NSNumber *)type userLat:(NSNumber *)userLat userLng:(NSNumber *)userLng delegate:(id<AFOperationDelegate>)delegate
{
    return [[AFOperationManager shareInstance] afPOST:API_USER_NOTIFICATION_NEWEST parameters:@{_PAGE:page,_TYPE:type,_USER_LATITUDE:userLat,_USER_LONGITUDE:userLng} delegate:delegate];
}

@end
