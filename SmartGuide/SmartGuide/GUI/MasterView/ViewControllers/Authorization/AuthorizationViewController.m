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

- (id)init
{
    self = [super initWithNibName:@"AuthorizationViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    SGNavigationController *navi=nil;
    
    if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        RegisterViewController *vc=[RegisterViewController new];
        vc.delegate=self;
        
        navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    }
    else if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        UserLoginViewController *vc=[UserLoginViewController new];
        vc.delegate=self;
        
        navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    }
    
    [self addChildViewController:navi];
    [containView addSubview:navi.view];
    
    [navi.view l_v_setS:containView.l_v_s];
    
    authorNavi=navi;
}

-(void)userLoginSuccessed
{
    if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        RegisterViewController *vc=[RegisterViewController new];
        vc.delegate=self;
        
        [authorNavi pushViewController:vc animated:true];
    }
    else if(currentUser().enumDataMode==USER_DATA_FULL)
    {
        [self.delegate authorizationSuccessed];
        [self.navigationController popViewControllerAnimated:true];
    }
    
//    if(!user.isConnectedFacebook.boolValue && [user.name stringByRemoveString:@" ",nil].length==0)
//    {
//        UserFacebookViewController *vc=[[UserFacebookViewController alloc] init];
//        vc.delegate=self;
//        
//        [self pushViewController:vc animated:true];
//    }
//    else
//        [self.delegate authorizationSuccessed];
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

-(IBAction) btnBackTouchUpInside:(id)sender
{
    if(authorNavi.viewControllers.count==1)
        [self.navigationController popViewControllerAnimated:true];
    else
        [authorNavi popViewControllerAnimated:true];
}

@end
