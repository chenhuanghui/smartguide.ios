//
//  ASIOperationUpdateUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUpdateUserProfile.h"

@implementation ASIOperationUpdateUserProfile
@synthesize status,message;

-(ASIOperationUpdateUserProfile *) initWithName:(NSString *)name avatar:(NSString *)avatar gender:(enum GENDER_TYPE)gender socialType:(enum SOCIAL_TYPE)socialType birthday:(NSString *)birthday idCity:(int)idCity
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPDATE_PROFILE)]];
    
    [self.keyValue setObject:name forKey:@"name"];
    [self.keyValue setObject:@(gender) forKey:@"gender"];
    [self.keyValue setObject:@(socialType) forKey:@"socialType"];
    [self.keyValue setObject:birthday forKey:@"dob"];
    [self.keyValue setObject:@(idCity) forKey:@"idCity"];
    
    if(avatar.length>0)
        [self.keyValue setObject:avatar forKey:@"avatar"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        User *user=[DataManager shareInstance].currentUser;
        
        user.name=self.keyValue[@"name"];
        user.gender=self.keyValue[@"gender"];
        user.birthday=self.keyValue[@"dob"];
        user.idCity=self.keyValue[@"idCity"];
        
        if([self.keyValue[@"avatar"] length]>0)
            user.avatar=self.keyValue[@"avatar"];
        
        [[DataManager shareInstance] save];
    }
}

@end
