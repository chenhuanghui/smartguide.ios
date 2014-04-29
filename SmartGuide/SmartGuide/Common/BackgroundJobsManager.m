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

+(BackgroundJobsManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _backgroundJobsManager=[BackgroundJobsManager new];
    });
    
    return _backgroundJobsManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queueJobs=[NSOperationQueue new];
        [self addDefaultJobs];
    }
    return self;
}

-(void) addDefaultJobs
{
    
}

-(void)addJobs:(BackgroundJob *)job
{
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ANNOUNCEMENT_HIDED object:nil];
}

@end