//
//  ASIOperationUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 06/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUserProfile.h"
#import "User.h"

@implementation ASIOperationUserProfile

-(ASIOperationUserProfile *)initOperation
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_PROFILE)]];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
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
    
    user.idUser=[NSNumber makeNumber:dict[@"idUser"]];
    user.name=[NSString makeString:dict[@"name"]];
    user.gender=[NSNumber makeNumber:dict[@"gender"]];
    user.cover=[NSString makeString:dict[@"cover"]];
    user.avatar=[NSString makeString:dict[@"avatar"]];
    user.phone=[NSString makeString:dict[@"phone"]];
    user.socialType=[NSNumber makeNumber:dict[@"socialType"]];
    user.birthday=[NSString makeString:dict[@"dob"]];
    user.idCity=[NSNumber makeNumber:dict[@"idCity"]];
    
    if(user.idCity.integerValue==0)
        user.idCity=@(IDCITY_HCM());

    [[DataManager shareInstance] save];
}

@end