//
//  BackgroundJobsManager.h
//  Infory
//
//  Created by XXX on 4/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BackgroundJob;

@interface BackgroundJobsManager : NSObject
{
    NSOperationQueue *_queueJobs;
}

+(BackgroundJobsManager*) shareInstance;

-(void) addJobs:(BackgroundJob*) job;

@end

@interface BackgroundJob : NSOperation

@end

@interface NotificationCheck : BackgroundJob

@end