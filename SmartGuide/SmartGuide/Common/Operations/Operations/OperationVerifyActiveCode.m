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
    NSString *_phone;
}

@end

@implementation OperationVerifyActiveCode
@synthesize isSuccess,user,activeCode;

-(OperationVerifyActiveCode *)initWithPhone:(NSString *)phone aciveCode:(NSString *)_activeCode
{
    NSURL *url=[NSURL URLWithString:API_VERIFY_ACTIVE_CODE(phone, _activeCode)];
    self=[super initWithURL:url];
    
    _phone=[[NSString alloc] initWithString:phone];
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
    int idUser=[dict integerForKey:@"user_id"];
    bool isConnectedFB=[[dict objectForKey:@"connect_fb"] boolValue];
    NSString *avatar=[NSString stringWithStringDefault:[dict objectForKey:@"avatar"]];
    
    if(isSuccess)
    {
        user=[User userWithIDUser:idUser];
        
        if(!user)
        {
            user=[User insert];
            [user setIdUser:@(idUser)];
        }

        user.isConnectedFacebook=@(isConnectedFB);
        user.avatar=[NSString stringWithStringDefault:avatar];
        user.name=[NSString stringWithStringDefault:[dict objectForKey:@"name"]];
        
        [[DataManager shareInstance] save];
        
        [[DataManager shareInstance] loadDefaultFilter];
        
        user=[User userWithIDUser:idUser];
        [DataManager shareInstance].currentUser=user;
    }
}

@end
