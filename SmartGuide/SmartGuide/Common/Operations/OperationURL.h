//
//  OperationQueue.h
//  SmartGuide
//
//  Created by XXX on 7/18/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "Utility.h"
#import "DataManager.h"
#import "Constant.h"

@class OperationURL;

@protocol OperationURLDelegate <NSObject>

-(void) operationURLFinished:(OperationURL*) operation;
-(void) operationURLFailed:(OperationURL*) operation;

@end

@interface OperationURL : AFHTTPRequestOperation
{
}

-(OperationURL*) initWithURL:(NSURL*) url;
-(OperationURL*)initWithRequest:(NSURLRequest *)urlRequest;

-(void) onCompletedWithJSON:(NSArray*) json;
-(void) notifyCompleted;
-(void) notifyFailed:(NSError*) error;
-(bool) canManualHandleData:(id) responseObject;
-(bool)isNullData:(NSArray *)data;

@property (nonatomic, strong) NSError *error;
@property (nonatomic, weak) id<OperationURLDelegate> delegate;

@end
