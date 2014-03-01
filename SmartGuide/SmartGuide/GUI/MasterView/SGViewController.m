//
//  SGViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import <objc/runtime.h>

static char presentSGViewControlelrKey;

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
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
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

@end

@implementation UIViewController(PresentViewController)

-(SGViewController *)presentSGViewControlelr
{
    return objc_getAssociatedObject(self, &presentSGViewControlelrKey);
}

-(void)setPresentSGViewControlelr:(SGViewController *)presentSGViewControlelr
{
    objc_setAssociatedObject(self, &presentSGViewControlelrKey, presentSGViewControlelr, OBJC_ASSOCIATION_ASSIGN);
}

-(void)presentSGViewController:(SGViewController *)viewControllerToPresent completion:(void (^)(void))completion
{
    self.view.userInteractionEnabled=false;
    self.presentSGViewControlelr=viewControllerToPresent;
    
    [self addChildViewController:viewControllerToPresent];
    
    [viewControllerToPresent view];
    [viewControllerToPresent l_v_setS:self.l_v_s];
    
    [viewControllerToPresent l_v_setY:-viewControllerToPresent.l_v_h];
    [self.view alphaViewWithColor:[UIColor blackColor]];
    self.view.alphaView.alpha=0;
    [self.view addSubview:viewControllerToPresent.view];
    [viewControllerToPresent viewWillAppear:true];
    
    [UIView animateWithDuration:DURATION_PRESENT_VIEW_CONTROLLER animations:^{
        [viewControllerToPresent l_v_setY:0];
        self.view.alphaView.alpha=0.7f;
    } completion:^(BOOL finished) {
        [viewControllerToPresent viewDidAppear:true];
        self.view.userInteractionEnabled=true;
    }];
}

-(void)dismissSGViewControllerCompletion:(void (^)(void))completion
{
    if(!self.presentSGViewControlelr)
        return;
    
    __block void(^_completion)()=nil;
    
    if(completion)
        _completion=[completion copy];
    
    [self.presentSGViewControlelr viewWillDisappear:true];
    [UIView animateWithDuration:DURATION_PRESENT_VIEW_CONTROLLER animations:^{
        [self.presentSGViewControlelr l_v_setY:-self.presentSGViewControlelr.l_v_h];
        self.view.alphaView.alpha=0;
    } completion:^(BOOL finished) {
        
        [self.view removeAlphaView];
        [self.presentSGViewControlelr viewDidDisappear:true];
        [self.presentSGViewControlelr.view removeFromSuperview];
        [self.presentSGViewControlelr removeFromParentViewController];
        self.presentSGViewControlelr=nil;
        
        if(_completion)
        {
            _completion();
            _completion=nil;
        }
    }];
}

@end