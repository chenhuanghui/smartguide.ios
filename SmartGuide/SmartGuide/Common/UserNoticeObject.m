//
//  UserNoticeObject.m
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNoticeObject.h"
#import "ASIOperationUserNotice.h"
#import "SGData.h"

static UserNoticeObject *_userNoticeObject=nil;
@interface UserNoticeObject()<ASIOperationPostDelegate>

@end

@implementation UserNoticeObject

+(void)requestUserNotice
{
    // Đang request user notice
    if(_userNoticeObject)
        return;
    
    // Đã từng lấy user notice thành công
    if([SGData shareInstance].userNotice.length>0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
        return;
    }
    
    _userNoticeObject=[[UserNoticeObject alloc] init];
    ASIOperationUserNotice *operation=[[ASIOperationUserNotice alloc] initWithUserLat:userLat() userLng:userLng()];
    operation.delegatePost=_userNoticeObject;
    
    [operation startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotice class]])
    {
        ASIOperationUserNotice *ope=(ASIOperationUserNotice*) operation;
        
        [SGData shareInstance].userNotice=[ope.notifce copy];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
        _userNoticeObject=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotice class]])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
        _userNoticeObject=nil;
        
        // Request lại user notice sau 60s nếu thất bại
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UserNoticeObject requestUserNotice];
        });
    }
}

@end
