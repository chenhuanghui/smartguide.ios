//
//  OperationVerifyActiveCode.m
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationVerifyActiveCode.h"

@interface OperationVerifyActiveCode()
{
}

@end

@implementation OperationVerifyActiveCode
@synthesize isSuccess,activeCode,idUser,avatar,name,isConnectedFacebook;

-(OperationVerifyActiveCode *)initWithPhone:(NSString *)phone aciveCode:(NSString *)_activeCode
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:phone forKey:@"phone"];
    [dict setObject:_activeCode forKey:@"code"];
    self=[super initWithRouter:SERVER_IP_MAKE(API_VERIFY_ACTIVE_CODE) params:dict];
    
    self.activeCode=[[NSString alloc]initWithString:_activeCode];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    for(User *uc in [User allObjects])
    {
        [[DataManager shareInstance].managedObjectContext deleteObject:uc];
    }
    
    NSDictionary *dict=[json objectAtIndex:0];
    isSuccess=[[dict objectForKey:@"result"] boolValue];
    if(isSuccess)
    {
        idUser=[dict integerForKey:@"user_id"];
        isConnectedFacebook=[dict boolForKey:@"connect_fb"];
        avatar=[NSString stringWithStringDefault:dict[@"avatar"]];
        name=[NSString stringWithStringDefault:dict[@"name"]];
    }
}

@end
