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
    
    if(currentUser().enumDataMode==USER_DATA_CREATING
       || currentUser().enumDataMode==USER_DATA_FULL)
    {
        RegisterViewController *vc=[RegisterViewController new];
        vc.delegate=self;
        vc.authorizationController=self;
        
        navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    }
    else if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        UserLoginViewController *vc=[UserLoginViewController new];
        vc.delegate=self;
        vc.authorizationController=self;
        
        navi=[[SGNavigationController alloc] initWithRootViewController:vc];
    }
    
    [navi.view l_v_setS:containView.l_v_s];
    [containView addSubview:navi.view];
    
    authorNavi=navi;
}

-(void)registerControllerFinished:(RegisterViewController *)controller
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RegisterWillOpen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.delegate authorizationSuccessed];
}

-(void)userLoginSuccessed
{
    if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        RegisterViewController *vc=[RegisterViewController new];
        vc.delegate=self;
        vc.authorizationController=self;
        
        [authorNavi setRootViewController:vc animate:true];
    }
    else if(currentUser().enumDataMode==USER_DATA_FULL)
    {
        RegisterViewController *vc=[RegisterViewController new];
        vc.delegate=self;
        vc.authorizationController=self;
        
        [authorNavi setRootViewController:vc animate:true];
    }
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

-(SGViewController *)visibleController
{
    return (SGViewController*)authorNavi.visibleViewController;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([authorNavi.visibleViewController isKindOfClass:[UserLoginViewController class]])
        return;
    
    [self.view endEditing:true];
}

-(void)dealloc
{
    authorNavi=nil;
}

@end
