//
//  HTTPOperation.m
//  Infory
//
//  Created by XXX on 7/16/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "HTTPOperation.h"

@implementation HTTPOperation

-(void)startWithDelegate:(id<HTTPOperation>)delegate
{
    self.delegate=delegate;
    
    __weak HTTPOperation *wSelf=self;
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(wSelf && wSelf.delegate)
        {
            [wSelf onCompletedWithResponseObject:responseObject error:nil];
            [wSelf.delegate HTTPOperationFinished:wSelf error:nil];
            [wSelf finished];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(wSelf && wSelf.delegate)
        {
            [wSelf onCompletedWithResponseObject:nil error:error];
            [wSelf.delegate HTTPOperationFinished:wSelf error:error];
            [wSelf finished];
        }
    }];
    
    [self start];
}

-(void) finished
{
    self.delegate=nil;
}

-(void)cleanDelegateAndCancel
{
    self.delegate=nil;
    [self setCompletionBlockWithSuccess:nil failure:nil];
    [self cancel];
}

@end
