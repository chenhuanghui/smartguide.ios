//
//  AFOperation.h
//  Infory
//
//  Created by XXX on 6/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constant.h"
#import "Utility.h"

@protocol AFOperationDelegate <NSObject>

-(void) AFOperationFinished:(id) operation;
-(void) AFOperationFailed:(id) operaion;

@end

@interface AFOperation : AFHTTPRequestOperation

@property (nonatomic, weak) id<AFOperationDelegate> delegate;

@end

@interface AFHTTPRequestOperationManager(AFOperation)

-(AFOperation *)afHTTPRequestOperationWithRequest:(NSURLRequest *)request delegate:(id<AFOperationDelegate>) delegate;
-(AFOperation *)afGET:(NSString *)URLString parameters:(id)parameters delegate:(id<AFOperationDelegate>) delegate;
-(AFOperation *)afPOST:(NSString *)URLString parameters:(id)parameters delegate:(id<AFOperationDelegate>) delegate;

-(AFOperation *)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(id)parameters delegate:(id<AFOperationDelegate>) delegate;

-(AFOperation *)afPOST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block delegate:(id<AFOperationDelegate>) delegate;

@end