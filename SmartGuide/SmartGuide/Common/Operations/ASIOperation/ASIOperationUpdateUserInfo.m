//
//  ASIOperationUpdateUserInfo.m
//  SmartGuide
//
//  Created by XXX on 9/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUpdateUserInfo.h"

@implementation ASIOperationUpdateUserInfo
@synthesize isSuccess,values;

-(ASIOperationUpdateUserInfo *)initWithIDUser:(int)idUser name:(NSString *)name avatar:(NSData *)avatar
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_UPDATE_USER_INFO)];
    self=[super initWithURL:_url];
    
    values=@[@(idUser),name,@" "];
    
    if(avatar)
        [self addData:avatar withFileName:@"photo" andContentType:@"image/jpeg" forKey:@"photo"];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dict=[json objectAtIndex:0];
    isSuccess=[dict boolForKey:@"code"];
    
    if(isSuccess)
    {
    User *user=[DataManager shareInstance].currentUser;
        user.name=[values objectAtIndex:1];
        user.avatar=[NSString stringWithStringDefault:[dict objectForKey:@"data"]];
    
        [[DataManager shareInstance] save];
    }
}

-(NSArray *)keys
{
    return @[@"user_id",@"first_name",@"last_name"];
}

@end
