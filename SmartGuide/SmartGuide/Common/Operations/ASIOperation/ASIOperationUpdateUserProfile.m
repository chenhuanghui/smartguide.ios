//
//  ASIOperationUpdateUserProfile.m
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ASIOperationUpdateUserProfile.h"

@implementation ASIOperationUpdateUserProfile
@synthesize values,status,message,avatar,cover;

-(ASIOperationUpdateUserProfile *)initWithName:(NSString *)name cover:(NSData *)_cover avatar:(NSString *)_avatar avatarImage:(NSData *)_avatarImage gender:(enum GENDER_TYPE)gender socialType:(enum SOCIAL_TYPE)socialType
{
    self=[super initWithURL:[NSURL URLWithString:SERVER_API_MAKE(API_USER_UPDATE_PROFILE)]];
    
    NSMutableArray *array=[NSMutableArray array];
    
    [array addObject:name];
    [array addObject:@(gender)];
    [array addObject:@(socialType)];
    
    if(_cover && _cover.length>0)
        [self addData:_cover withFileName:@"cover" andContentType:@"image/jpeg" forKey:@"cover"];
    
    if(_avatarImage.length>0)
        [self addData:_avatarImage withFileName:@"image" andContentType:@"image/jpeg" forKey:@"image"];
    else if(_avatar.length>0)
        [array addObject:_avatar];
    
    values=array;
    
    return self;
}

-(NSArray *)keys
{
    if(self.values.count==4)
        return @[@"name",@"gender",@"socialType",@"avatar"];
    
    return @[@"name",@"gender",@"socialType"];
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
