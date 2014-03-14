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

-(OperationURL*) initWithRouter:(NSString*) router params:(NSDictionary*) dict;

-(void) onCompletedWithJSON:(NSArray*) json;
-(void) notifyCompleted;
-(void) notifyFailed:(NSError*) error;
-(bool) canManualHandleData:(id) responseObject;
-(bool)isNullData:(NSArray *)data;

@property (nonatomic, weak) id<OperationURLDelegate> delegate;
@property (nonatomic, readonly) NSDictionary *params;
@property (nonatomic, readonly) NSString *router;

@end
