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
#import "DataManager.h"

enum AFOPEARTION_METHOD_TYPE
{
    AFOPEARTION_METHOD_TYPE_POST=0,
    AFOPEARTION_METHOD_TYPE_GET=1,
};

NSString* afOperationMethodDescription(enum AFOPEARTION_METHOD_TYPE type);

@protocol AFOperationDelegate <NSObject>

-(void) AFOperationFinished:(id) operation;
-(void) AFOperationFailed:(id) operaion;

@end

@interface AFOperation : AFHTTPRequestOperation
{
}

@property (nonatomic, weak) id<AFOperationDelegate> delegate;

@end

@interface AFOperationManager : AFHTTPRequestOperationManager

+(AFOperationManager*) shareInstance;

-(AFOperation *)afGET:(NSString *)URLString parameters:(NSDictionary*)parameters delegate:(id<AFOperationDelegate>) delegate;
-(AFOperation *)afPOST:(NSString *)URLString parameters:(NSDictionary*)parameters delegate:(id<AFOperationDelegate>) delegate;

-(AFOperation *)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary*)parameters delegate:(id<AFOperationDelegate>) delegate;

@end