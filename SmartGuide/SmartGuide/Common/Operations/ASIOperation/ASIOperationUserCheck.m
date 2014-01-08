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
@synthesize isSuccess,message,phone,activeCode,refreshToken,accessToken,values;

-(ASIOperationUserCheck *)initWithPhone:(NSString *)_phone aciveCode:(NSString *)_activeCode
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_IP_MAKE(API_USER_CHECK)]];
    
    values=@[_phone,_activeCode];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"phone",@"activeCode"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    phone=values[0];
    activeCode=values[1];
    isSuccess=false;
    accessToken=@"";
    refreshToken=@"";
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    isSuccess=[NSNumber numberWithObject:dict[@"status"]];
    if(isSuccess)
    {
        [User markDeleteAllObjects];
        [[DataManager shareInstance] save];
        
        User *user=[User makeWithDictionary:dict[@"userProfile"]];
        [DataManager shareInstance].currentUser=user;
        
        [[DataManager shareInstance] save];
        
        [TokenManager shareInstance].accessToken=[NSString stringWithStringDefault:dict[@"accessToken"]];
        [TokenManager shareInstance].refreshToken=[NSString stringWithStringDefault:dict[@"refreshToken"]];
    }
}

@end
