//
//  SGViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "GUIManager.h"
#import "SGNavigationController.h"

@interface SGViewController ()

@end

@implementation SGViewController
@synthesize delegate;

-(id)initWithDelegate:(id<SGViewControllerDelegate>)_delegate
{
    self=[super init];
    
    delegate=_delegate;
    
    return self;
}

-(bool)allowDragToNavigation
{
    return true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for(NSString *notification in [self registerNotifications])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:notification object:nil];
    }
    
    for(NSString *notification in [self defaultRegisterNotification])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDefaultNotification:) name:notification object:nil];
    }
}

-(void)loadView
{
    [super loadView];
    
    if([self respondDelegateSEL:@selector(SGControllerLoadView:)])
        [self.delegate SGControllerLoadView:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*) defaultRegisterNotification
{
    return @[NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION, NOTIFICATION_TOUCHED_REMOTE_NOTIFICATION];
}

-(void) receiveDefaultNotification:(NSNotification*) notification
{
    if([notification.name isEqualToString:NOTIFICATION_RECEIVED_REMOTE_NOTIFICATION])
    {
        [self receiveRemoteNotification:notification.object];
    }
    else if([notification.name isEqualToString:NOTIFICATION_TOUCHED_REMOTE_NOTIFICATION])
    {
        [self processRemoteNotification:notification.object];
    }
}

-(NSArray *)registerNotifications
{
    return @[];
}

-(void)receiveNotification:(NSNotification *)notification
{
    
}

-(void)dealloc
{
    for (NSString *notification in [self registerNotifications]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notification object:nil];
    }
    
    for (NSString *notification in [self defaultRegisterNotification]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notification object:nil];
    }

    DLOG_DEBUG(@"dealloc %@", CLASS_NAME);
}

-(bool) respondDelegateSEL:(SEL) sel
{
    return self.delegate && [self.delegate respondsToSelector:sel];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if(!_viewWillAppear)
    {
        _viewWillAppear=true;
        
        [self viewWillAppearOnce];
        [self storeRect];
        
        if([self respondDelegateSEL:@selector(SGControllerViewWillAppear:)])
            [self.delegate SGControllerViewWillAppear:self];
    }
}

-(void)viewWillAppearOnce
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if(!_viewWillDisappear)
    {
        _viewWillDisappear=true;
        
        [self viewWillDisappearOnce];
    }
}

-(void)viewWillDisappearOnce
{
    
}

-(void)navigationController:(SGNavigationController *)navigationController willPopController:(SGViewController *)controller
{
    
}

-(SGNavigationController *)sgNavigationController
{
    return (SGNavigationController*)self.navigationController;
}

-(bool)navigationWillBack
{
    return true;
}

+(NSString *)screenCode
{
    return SCREEN_CODE_UNKNOW;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

-(void)storeRect
{
}

-(void)showActionSheet:(UIActionSheet *)actionSheet
{
    [actionSheet showInView:[GUIManager shareInstance].rootNavigation.view];
}

-(void)receiveRemoteNotification:(RemoteNotification *)obj
{
    
}

-(void)processRemoteNotification:(RemoteNotification *)obj
{
    
}

-(BOOL)prefersStatusBarHidden
{
    return false;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end