//
//  OperationVerifyActiveCode.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUserCheck.h"
#import "TokenManager.h"

@interface ASIOperationUserCheck()
{
}

@end

@implementation ASIOperationUserCheck
@synthesize isSuccess,message,phone,activeCode,refreshToken,accessToken;

-(ASIOperationUserCheck *)initWithPhone:(NSString *)_phone aciveCode:(NSString *)_activeCode
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_IP_MAKE(API_USER_CHECK)]];
    
    [self.keyValue setObject:_phone forKey:@"phone"];
    [self.keyValue setObject:_activeCode forKey:@"activeCode"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    phone=self.keyValue[@"phone"];
    activeCode=self.keyValue[@"activeCode"];
    isSuccess=false;
    accessToken=@"";
    refreshToken=@"";
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    isSuccess=[[NSNumber numberWithObject:dict[@"status"]] boolValue];
    if(isSuccess)
    {
        [User markDeleteAllObjects];
        [[DataManager shareInstance] save];
        
        User *user=[User makeWithDictionary:dict[@"userProfile"]];
        [DataManager shareInstance].currentUser=user;
        
        [[DataManager shareInstance] save];
        
        [TokenManager shareInstance].accessToken=[NSString stringWithStringDefault:dict[@"accessToken"]];
        [TokenManager shareInstance].refreshToken=[NSString stringWithStringDefault:dict[@"refreshToken"]];
        [TokenManager shareInstance].phone=phone;
        [TokenManager shareInstance].activeCode=activeCode;
    }
}

@end
