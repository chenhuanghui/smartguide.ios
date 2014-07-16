//
//  HTTPOperation.h
//  Infory
//
//  Created by XXX on 7/16/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@class HTTPOperation;

@protocol HTTPOperation <NSObject>

-(void) HTTPOperationFinished:(HTTPOperation*) operation error:(NSError*) error;

@end

@interface HTTPOperation : AFHTTPRequestOperation

-(void) startWithDelegate:(id<HTTPOperation>) delegate;
-(void) onCompletedWithResponseObject:(id) responseObject error:(NSError*) error;

-(void) cleanDelegateAndCancel;

@property (nonatomic, weak) id<HTTPOperation> delegate;

@end
