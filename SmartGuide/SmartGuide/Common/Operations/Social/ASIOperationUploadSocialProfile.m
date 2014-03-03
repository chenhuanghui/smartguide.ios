//
//  ASIOperationUploadSocialProfile.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUploadSocialProfile.h"

@implementation ASIOperationUploadSocialProfile
@synthesize status,message,errorCode;

-(ASIOperationUploadSocialProfile *)initWithProfile:(NSString *)profile socialType:(enum SOCIAL_TYPE)socialType accessToken:(NSString *)accessToken
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPLOAD_SOCIAL_PROFILE)]];
    
    [self.keyValue setObject:profile forKey:@"profile"];
    [self.keyValue setObject:accessToken forKey:@"accessToken"];
    [self.keyValue setObject:@(socialType) forKey:@"socialType"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=json[0];
    
    status=[[NSNumber numberWithObject:dict[@"status"]] integerValue];
    message=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(status==1)
    {
        User *user=[User makeWithDictionary:dict[@"profile"]];
        
        [[DataManager shareInstance] save];
        [DataManager shareInstance].currentUser=user;
    }
    else
        errorCode=[[NSNumber numberWithObject:dict[@"errorCode"]] integerValue];
}

@end
