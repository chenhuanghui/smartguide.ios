//
//  BackgroundJobsManager.m
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "BackgroundJobsManager.h"
#import "ASIOperationNotificationCheck.h"
#import "SGData.h"

static BackgroundJobsManager *_backgroundJobsManager=nil;
@implementation BackgroundJobsManager

+(void)load
{
    [[BackgroundJobsManager shareInstance] startup];
}

+(BackgroundJobsManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _backgroundJobsManager=[BackgroundJobsManager new];
    });
    
    return _backgroundJobsManager;
}

-(void)startup
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NOTIFICATION_USER_LOGOUT object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NOTIFICATION_USER_LOGIN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:NOTIFICATION_INFORY_LAUNCHED object:nil];
        
        _queueJobs=[NSOperationQueue new];
    }
    return self;
}

-(void) receiveNotification:(NSNotification*) notification
{
    if([notification.name isEqualToString:NOTIFICATION_USER_LOGIN])
    {
        [self addNotificationCheck];
    }
    else if([notification.name isEqualToString:NOTIFICATION_USER_LOGOUT])
    {
        [_queueJobs cancelAllOperations];
    }
    else if([notification.name isEqualToString:NOTIFICATION_INFORY_LAUNCHED])
    {
        [self addNotificationCheck];
    }
}

-(bool) isHasJob:(Class) jobClass
{
    for(NSOperation *ope in _queueJobs.operations)
        if([ope isKindOfClass:jobClass] && (!ope.isCancelled || !ope.isFinished))
            return true;
    
    return false;
}

-(void)addJobs:(BackgroundJob *)job
{
    [_queueJobs addOperation:job];
}

-(void) addNotificationCheck
{
    if([self isHasJob:[NotificationCheck class]])
        return;
    
    switch (currentUser().enumDataMode) {
        case USER_DATA_CREATING:
        case USER_DATA_FULL:
        {
            NotificationCheck *noti=[NotificationCheck new];
            
            [self addJobs:noti];
        }
            break;
            
        case USER_DATA_TRY:
            break;
    }
}

@end

@implementation BackgroundJob



@end

@interface NotificationCheck()<ASIOperationPostDelegate>
{
    ASIOperationNotificationCheck *_operation;
}

@end

@implementation NotificationCheck

-(id)init
{
    self=[super init];
    
    _operation=[[ASIOperationNotificationCheck alloc] initWithUserLat:userLat() userLng:userLng()];
    _operation.delegate=self;
    
    return self;
}

-(void)start
{
    [super start];
    
    [_operation startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationNotificationCheck *ope=(ASIOperationNotificationCheck*) operation;
    [SGData shareInstance].numOfNotification=ope.numOfNotification;
    [SGData shareInstance].totalNotification=ope.totalNotification;
    
    [self finished];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self finished];
}

-(void) finished
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_NOTIFICATION_CHECK object:nil];
}

@end