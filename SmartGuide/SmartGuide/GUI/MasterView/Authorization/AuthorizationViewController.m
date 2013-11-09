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

-(void)showLogin
{
    UserLoginViewController *vc=[[UserLoginViewController alloc] init];
    vc.delegate=self;
    
    [self pushViewController:vc animated:false];
}

-(void)showCreateUser
{
    UserFacebookViewController *vc=[[UserFacebookViewController alloc] init];
    vc.delegate=self;
    
    [self pushViewController:vc animated:false];
}

+(bool)isNeedFillInfo
{
    User *currentUser=[DataManager shareInstance].currentUser;
    if(!currentUser)
    {
        currentUser=[User userWithIDUser:[Flags lastIDUser]];
        [DataManager shareInstance].currentUser=currentUser;
    }
    
    if(!currentUser)
        return true;
    
    // Nếu currentUser tồn tại mà chưa có thông tin=>user đã vào nhập số điện thoại, kích hoạt active code nhưng kill app khi đang kết nối facebook hoặc tạo user
    if(currentUser && !currentUser.isConnectedFacebook.boolValue && [currentUser.name stringByRemoveString:@" ",nil].length==0)
    {
        return true;
    }
    
    return false;
}

-(void)userLoginSuccessed
{
    User *user=[DataManager shareInstance].currentUser;
    
    if(!user.isConnectedFacebook.boolValue && [user.name stringByRemoveString:@" ",nil].length==0)
    {
        UserFacebookViewController *vc=[[UserFacebookViewController alloc] init];
        vc.delegate=self;
        
        [self pushViewController:vc animated:true];
    }
    else
        [self.delegate authorizationSuccessed];
}

-(void)userLoginCancelled
{
    [self.delegate authorizationCancelled];
}

-(NSString *)title
{
    return CLASS_NAME;
}

-(void) userFacebookSuccessed
{
    [self.delegate authorizationSuccessed];
}

-(void)dealloc
{
    [self.viewControllers[0] removeFromParentViewController];
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
