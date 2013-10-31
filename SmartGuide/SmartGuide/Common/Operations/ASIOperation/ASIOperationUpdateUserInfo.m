//
//  ASIOperationUpdateUserInfo.m
//  SmartGuide
//
//  Created by XXX on 9/5/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ASIOperationUpdateUserInfo.h"

@implementation ASIOperationUpdateUserInfo
@synthesize isSuccess,values,messsage,data;

-(ASIOperationUpdateUserInfo *)initWithIDUser:(int)idUser name:(NSString *)name avatar:(NSString *)avatar
{
    NSURL *_url=[NSURL URLWithString:SERVER_API_MAKE(API_UPDATE_USER_INFO)];
    self=[super initWithURL:_url];
    
    values=@[@(idUser),name,avatar];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    isSuccess=false;
    
    if([self isNullData:json])
        return;
    
    NSDictionary *dict=[json objectAtIndex:0];
    isSuccess=[dict boolForKey:@"code"];
    messsage=[NSString stringWithStringDefault:dict[@"message"]];
    
    if(isSuccess)
    {
        data=[NSString stringWithStringDefault:dict[@"data"]];
    }
}

-(NSArray *)keys
{
    return @[@"user_id",@"name",@"avatar"];
}

@end
