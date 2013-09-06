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
             idUser,
             profile.email,
             profile.name,
             @(profile.sex),
             profile.birthday,
             profile.avatar,
             job];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"fb_id",@"user_id",@"email",@"name",@"gender",@"dob",@"avatar",@"job"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccessed=[[json objectAtIndex:0] boolValue];
    
    User *user=[User userWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
    user.isConnectedFacebook=@(true);
    
    [[DataManager shareInstance] save];
    
    [DataManager shareInstance].currentUser=[User userWithIDUser:user.idUser.integerValue];
}

-(void)onFailed:(NSError *)error
{
    isSuccessed=false;
}

@end
