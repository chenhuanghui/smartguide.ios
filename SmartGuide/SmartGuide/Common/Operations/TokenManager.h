//
//  TokenManager.h
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationRefreshToken.h"
#import "OperationGetToken.h"

@interface TokenManager : NSObject<OperationURLDelegate>
{
    bool _isRefreshingToken;
    bool _isGettingToken;
    OperationRefreshToken *_operationRefreshToken;
    OperationGetToken *_operationGetToken;
}

+(TokenManager*) shareInstance;

-(bool) isRefreshingToken;
-(void) refresh;

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;
@property (nonatomic, strong) NSString *activeCode;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, readonly) int retryCount;
@property (nonatomic, readonly) int retryGetTokenCount;

@end
