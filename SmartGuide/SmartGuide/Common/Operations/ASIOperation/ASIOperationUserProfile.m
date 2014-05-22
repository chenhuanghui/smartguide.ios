//
//  ASIOperationUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 06/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserProfile.h"

@implementation ASIOperationUserProfile

-(ASIOperationUserProfile *)initOperation
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_PROFILE)]];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    User *user=[DataManager shareInstance].currentUser;
    
    if(!user)
    {
        [User markDeleteAllObjects];
        [[DataManager shareInstance] save];
        
        user=[User insert];
        [DataManager shareInstance].currentUser=user;
    }
    
    user.idUser=[NSNumber numberWithObject:dict[@"idUser"]];
    user.name=[NSString stringWithStringDefault:dict[@"name"]];
    user.gender=[NSNumber numberWithObject:dict[@"gender"]];
    user.cover=[NSString stringWithStringDefault:dict[@"cover"]];
    user.avatar=[NSString stringWithStringDefault:dict[@"avatar"]];
    user.phone=[NSString stringWithStringDefault:dict[@"phone"]];
    user.socialType=[NSNumber numberWithObject:dict[@"socialType"]];
    user.birthday=[NSString stringWithStringDefault:dict[@"dob"]];
    user.idCity=[NSNumber numberWithObject:dict[@"idCity"]];
    
    if(user.idCity.integerValue==0)
        user.idCity=@(IDCITY_HCM());
    
    [[DataManager shareInstance] save];
}

+(void)makeTest
{
    ASIOperationUserProfile *ope=[[ASIOperationUserProfile alloc] initOperation];
    
    [ope startAsynchronous];
}

@end