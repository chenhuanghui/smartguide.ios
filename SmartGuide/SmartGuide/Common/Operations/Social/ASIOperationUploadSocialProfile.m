//
//  ASIOperationUploadSocialProfile.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUploadSocialProfile.h"

@implementation ASIOperationUploadSocialProfile
@synthesize values,status;

-(ASIOperationUploadSocialProfile *)initWithProfile:(NSString *)profile socialType:(enum SOCIAL_TYPE)socialType accessToken:(NSString *)accessToken
{
    self=[super initWithRouter:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPLOAD_SOCIAL_PROFILE)]];
    
    values=@[profile,accessToken,@(socialType)];
    
    return self;
}

-(NSArray *)keys
{
    return @[@"profile",@"accessToken",@"socialType"];
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    if([self isNullData:json])
        return;
    
    status=1;
    
    NSDictionary *dict=json[0];
    
    User *user=[User makeWithDictionary:dict];
    
    [[DataManager shareInstance] save];
    [DataManager shareInstance].currentUser=user;
}

@end
