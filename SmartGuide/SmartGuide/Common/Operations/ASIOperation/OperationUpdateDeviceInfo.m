//
//  OperationUpdateDeviceInfo.m
//  Infory
//
//  Created by XXX on 8/5/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "OperationUpdateDeviceInfo.h"
#import "TokenManager.h"

@implementation OperationUpdateDeviceInfo

-(OperationUpdateDeviceInfo *)initUpdateDeviceInfo
{
    self=[super initRouterWithMethod:OPERATION_METHOD_TYPE_GET url:SERVER_IP_MAKE(@"user/updateDeviceInfo")];
    
    [self.keyValue setObject:[[UIDevice currentDevice] platformRawString] forKey:@"deviceInfo"];
    [self.keyValue setObject:@"iOS" forKey:@"os"];
    [self.keyValue setObject:[UIDevice currentDevice].systemVersion forKey:@"osVersion"];
    [self.keyValue setObject:SMARTUIDE_VERSION forKey:@"appVersion"];
    
    bool isLogin=![[TokenManager shareInstance].accessToken isEqualToString:DEFAULT_USER_ACCESS_TOKEN];
    [self.keyValue setObject:@(isLogin) forKey:@"isLogin"];
    
    if([[SGData shareInstance].remoteToken hasData])
    {
        [self.keyValue setObject:[SGData shareInstance].remoteToken forKey:@"pushToken"];
    }
    
    return self;
}

+(void)callUpdateDeviceInfo
{
    OperationUpdateDeviceInfo *ope=[[OperationUpdateDeviceInfo alloc] initUpdateDeviceInfo];
    
    [ope addToQueue];
}

@end
