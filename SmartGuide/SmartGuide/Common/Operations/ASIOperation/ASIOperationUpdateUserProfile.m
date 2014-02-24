//
//  ASIOperationUpdateUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUpdateUserProfile.h"

@implementation ASIOperationUpdateUserProfile
@synthesize status,message,avatar,cover;

-(ASIOperationUpdateUserProfile *)initWithName:(NSString *)name cover:(NSData *)_cover avatar:(NSString *)_avatar avatarImage:(NSData *)_avatarImage gender:(enum GENDER_TYPE)gender socialType:(enum SOCIAL_TYPE)socialType birthday:(NSString *)birthday
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPDATE_PROFILE)]];
    
    [self.keyValue setObject:name forKey:@"name"];
    [self.keyValue setObject:@(gender) forKey:@"gender"];
    [self.keyValue setObject:@(socialType) forKey:@"socialType"];
    [self.keyValue setObject:birthday forKey:@"dob"];
    
    if(_cover && _cover.length>0)
        [self addData:_cover withFileName:@"cover" andContentType:@"image/jpeg" forKey:@"cover"];
    
    if(_avatarImage.length>0)
        [self addData:_avatarImage withFileName:@"image" andContentType:@"image/jpeg" forKey:@"image"];
    else if(_avatar.length>0)
        [self.keyValue setObject:_avatar forKey:@"avatar"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    status=0;
    message=@"";
    avatar=@"";
    cover=@"";
    
    if([self isNullData:json])
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
        
        avatar=[NSString stringWithStringDefault:dict[@"avatar"]];
        cover=[NSString stringWithStringDefault:dict[@"cover"]];
        
        if(avatar.length>0)
            user.avatar=avatar;
        
        if(cover.length>0)
            user.cover=cover;
        
        [[DataManager shareInstance] save];
    }
}

@end
