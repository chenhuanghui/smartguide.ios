//
//  SGViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if([self respondDelegateSEL:@selector(SGControllerDidLoadView:)])
        [self.delegate SGControllerDidLoadView:self];
    
    for(NSString *notification in [self registerNotifications])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:notification object:nil];
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
    
    DEALLOC_LOG
}

-(BOOL)prefersStatusBarHidden
{
    return true;
}

-(bool) respondDelegateSEL:(SEL) sel
{
    return self.delegate && [self.delegate respondsToSelector:sel];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
}

-(void)navigationController:(SGNavigationController *)navigationController willPopController:(SGViewController *)controller
{
    
}

@end