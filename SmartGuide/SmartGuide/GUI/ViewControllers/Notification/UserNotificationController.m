//
//  UserNotificationController.m
//  Infory
//
//  Created by XXX on 6/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationController.h"
#import "SGNavigationController.h"
#import "UserNotificationViewController.h"
#import "UserNotificationDetailViewController.h"
#import "NotificationManager.h"

@interface UserNotificationController ()<UserNotificationViewControllerDelegate, UserNotificationDetailViewControllerDelegate>

@end

@implementation UserNotificationController

- (instancetype)init
{
    self = [super initWithNibName:@"UserNotificationController" bundle:nil];
    if (self) {
        
    }
    return self;
}

-(UserNotificationController *)initWithIDSender:(NSNumber *)idSender
{
    self=[super initWithNibName:@"UserNotificationController" bundle:nil];
    
    _idSender=idSender;
    
    return self;
}

-(void)loadView
{
    [super loadView];
    
    _navi=[[SGNavigationController alloc] initWithRootViewController:[self userNotificationController]];
    if(_idSender)
    {
        [_navi pushViewController:[self userNotificationDetailControllerWithIDSender:_idSender] animated:false];
    }
}



-(UserNotificationViewController*) userNotificationController
{
    UserNotificationViewController *vc=[UserNotificationViewController new];
    vc.delegate=self;
    
    return vc;
}

-(UserNotificationDetailViewController*) userNotificationDetailControllerWithIDSender:(NSNumber*) idSender
{
    UserNotificationDetailViewController *vc=nil;
    if(idSender)
        vc=[[UserNotificationDetailViewController alloc] initWithIDSender:idSender];
    else
        vc=[UserNotificationDetailViewController new];
    
    vc.delegate=self;
    
    return vc;
}

-(UserNotificationDetailViewController*) userNotificationDetailControllerWithUserNotification:(UserNotification*) obj
{
    UserNotificationDetailViewController *vc=nil;
    if(obj)
        vc=[[UserNotificationDetailViewController alloc] initWithUserNotification:obj];
    else
        vc=[UserNotificationDetailViewController new];
    
    vc.delegate=self;
    
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_navi l_v_setS:contentView.l_v_s];
    [contentView addSubview:_navi.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _navi=nil;
}

-(void)processRemoteNotification:(RemoteNotification *)obj
{
    bool animated=self.navigationController.visibleViewController==self;
    
    if(obj.idSender)
    {
        if(![_navi.visibleViewController isKindOfClass:[UserNotificationDetailViewController class]])
        {
            [_navi pushViewController:[self userNotificationDetailControllerWithIDSender:obj.idSender] animated:animated];
        }
    }
    else
    {
        [_navi popToRootViewControllerAnimated:animated];
    }
}

-(void)userNotificationDetailControllerTouchedBack:(UserNotificationDetailViewController *)controller
{
    [[NotificationManager shareInstance] requestNotificationCount];
    [_navi popToRootViewControllerAnimated:true];
}

-(void)userNotificationViewControllerTouchedBack:(UserNotificationViewController *)controller
{
    [[NotificationManager shareInstance] requestNotificationCount];
    [self.navigationController popViewControllerAnimated:true];
}

-(void)userNotificationViewControllerTouchedNotification:(UserNotificationViewController *)controlelr userNotification:(UserNotification *)obj
{
    [_navi pushViewController:[self userNotificationDetailControllerWithUserNotification:obj] animated:true];
}

@end
