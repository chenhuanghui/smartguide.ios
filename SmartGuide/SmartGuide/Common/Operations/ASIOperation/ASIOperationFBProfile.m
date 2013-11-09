//
//  ASIOperationFBProfile.m
//  SmartGuide
//
//  Created by XXX on 7/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationFBProfile.h"
#import "OperationFBGetProfile.h"

@implementation ASIOperationFBProfile
@synthesize isSuccessed;

-(ASIOperationFBProfile *)initWithFBProfile:(FBProfile *)profile
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_UPLOAD_PROFILE_FACEBOOK]];
    
    NSString *job=@"";
    if(profile.job)
    {
        job=[NSString stringWithFormat:@"%@",profile.job];
    }
    
    _profile=profile;
    
    NSNumber *idUser=[DataManager shareInstance].currentUser.idUser;
    self.values=@[profile.fbID,
                  profile.token,
             idUser,
             profile.email,
             profile.name,
             @(profile.sex),
             profile.birthday,
             profile.avatar,
             job,
             profile.gender];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"fb_id",@"fb_access_token",@"user_id",@"email",@"name",@"gender",@"dob",@"avatar",@"job",@"genderstr"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccessed=false;
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    
    isSuccessed=[[NSNumber numberWithObject:[dict objectForKey:@"code"]] boolValue];
    
    User *user=[User userWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
    user.isConnectedFacebook=@(true);
    user.name=[self.values objectAtIndex:4];
    user.avatar=[self.values objectAtIndex:7];
    
    [[DataManager shareInstance] save];
    
    [DataManager shareInstance].currentUser=[User userWithIDUser:user.idUser.integerValue];
}

-(void)onFailed:(NSError *)error
{
    isSuccessed=false;
}

@end
