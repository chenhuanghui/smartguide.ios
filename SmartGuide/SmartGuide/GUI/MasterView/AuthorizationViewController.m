//
//  AuthorizationViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "AuthorizationViewController.h"

@interface AuthorizationViewController ()

@end

@implementation AuthorizationViewController
@synthesize delegate;

-(AuthorizationViewController *)initAuthorazion
{
    if([TokenManager shareInstance].accessToken.length==0 || ![DataManager shareInstance].currentUser)
    {
        UserLoginViewController *vc=[[UserLoginViewController alloc] init];
        self=[super initWithRootViewController:vc];
        
        vc.delegate=self;
    }
    else
    {
        UserFacebookViewController *vc=[[UserFacebookViewController alloc] init];
        vc.delegate=self;
        
        self=[super initWithRootViewController:vc];
    }
    
    return self;
}

+(bool)isNeedAuthoration
{
    if([TokenManager shareInstance].accessToken.length==0)
        return true;
    
    User *currentUser=[DataManager shareInstance].currentUser;
    if(!currentUser)
    {
        currentUser=[User userWithIDUser:[Flags lastIDUser]];
        [DataManager shareInstance].currentUser=currentUser;
    }
    
    if(!currentUser)
        return true;
    
    if(!currentUser.isConnectedFacebook.boolValue && currentUser.name.length==0)
        return true;
    
    return false;
}

-(void)userLoginSuccessed
{
    UserFacebookViewController *vc=[[UserFacebookViewController alloc] init];
    vc.delegate=self;
    
    [self pushViewController:vc animated:true];
}

-(NSString *)title
{
    return CLASS_NAME;
}

-(void) userFacebookSuccessed
{
    [self.delegate authorizationSuccess];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
