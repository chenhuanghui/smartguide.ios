//
//  OperationFBGetProfile.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "OperationFBGetProfile.h"

@implementation OperationFBGetProfile
@synthesize profile;

-(OperationFBGetProfile *)initWithAccessToken:(NSString *)accessToken
{
    NSString *fieldParams=@"picture.width(100).height(100),birthday,email,gender,id,name,name_format,first_name,last_name,work";
    NSURL *url=[NSURL URLWithString:FACEBOOK_GET_PROFILE(accessToken,fieldParams)];
    
    self=[super initWithURL:url];
    
    return self;
}

-(void)onCompletedWithJSON:(NSArray *)json
{
    NSDictionary *dictJSON=[json objectAtIndex:0];
    
    profile=[[FBProfile alloc] init];
    
    profile.fbID=[dictJSON objectForKey:@"id"];
    profile.birthday=[NSString stringWithStringDefault:[dictJSON objectForKey:@"birthday"]];
    profile.email=[NSString stringWithStringDefault:[dictJSON objectForKey:@"email"]];
    
    if([dictJSON objectForKey:@"name"])
        profile.name=[NSString stringWithStringDefault:[dictJSON objectForKey:@"name"]];
    else
    {
        NSString *fname=[NSString stringWithStringDefault:[dictJSON objectForKey:@"first_name"]];
        NSString *lname=[NSString stringWithStringDefault:[dictJSON objectForKey:@"last_name"]];
        if(lname.length>0)
            lname=[NSString stringWithFormat:@" %@",lname];
        
        profile.name=[NSString stringWithFormat:@"%@%@",fname,lname];
    }
    
    NSDictionary *dict=[dictJSON objectForKey:@"picture"];
    
    if([dict isKindOfClass:[NSDictionary class]])
    {
        dict=[dict objectForKey:@"data"];
        
        if([dict isKindOfClass:[NSDictionary class]])
        {
            profile.avatar=[NSString stringWithStringDefault:[dict objectForKey:@"url"]];
        }
    }
    
    profile.gender=[NSString stringWithStringDefault:[dictJSON objectForKey:@"gender"]];
    
    dict=nil;
    
    [DataManager shareInstance].currentUser.name=profile.name;
    [DataManager shareInstance].currentUser.avatar=profile.avatar;
    [[DataManager shareInstance] save];
    
    NSArray *array=[dictJSON objectForKey:@"work"];
    
    if(array && [array isKindOfClass:[NSArray class]] && array.count>0)
    {
        profile.job=[NSString stringWithStringDefault:[NSString stringWithFormat:@"%@",array]];
    }
}

@end

@implementation FBProfile
@synthesize avatar,birthday,email,gender,job;

- (id)init
{
    self = [super init];
    if (self) {
        self.avatar=@"";
        self.birthday=@"";
        self.email=@"";
        self.gender=@"";
        self.job=@"";
    }
    return self;
}

-(bool)sex
{
    return [gender isContainStrings:@"male","nam",nil]?1:0;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"FBProfile %@ %@ %@ %@ %@",avatar,birthday,email,gender,job];
}

@end