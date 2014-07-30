//
//  ASIOperationUploadSocialProfile.m
//  SmartGuide
//
//  Created by MacMini on 08/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUploadSocialProfile.h"

@implementation ASIOperationUploadSocialProfile

-(ASIOperationUploadSocialProfile *)initWithProfile:(NSString *)profile socialType:(enum SOCIAL_TYPE)socialType accessToken:(NSString *)accessToken
{
    self=[super initPOSTWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPLOAD_SOCIAL_PROFILE)]];
    
    [self.keyValue setObject:profile forKey:@"profile"];
    [self.keyValue setObject:accessToken forKey:@"accessToken"];
    [self.keyValue setObject:@(socialType) forKey:@"socialType"];
    
    return self;
}

-(void)onFinishLoading
{
    self.status=@(0);
    self.message=@"";
    self.errorCode=@(0);
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    if([json isNullData])
        return;
    
    NSDictionary *dict=json[0];
    
    self.status=[NSNumber makeNumber:dict[@"status"]];
    self.message=[NSString makeString:dict[@"message"]];
    
    if(self.status.integerValue==1)
    {
        User *user=[User makeWithDictionary:dict[@"profile"]];
        
        [[DataManager shareInstance] save];
        [DataManager shareInstance].currentUser=user;
    }
    else
        self.errorCode=[NSNumber makeNumber:dict[@"errorCode"]];
}

@end
