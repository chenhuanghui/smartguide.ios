//
//  SGViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import <objc/runtime.h>
#import "GUIManager.h"
#import "SGNavigationController.h"

static char presentSGViewControlelrKey;
static char presentingSGViewControlelrKey;

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

@implementation UIViewController(PresentViewController)

-(SGViewController *)presentSGViewControlelr
{
    return objc_getAssociatedObject(self, &presentSGViewControlelrKey);
}

-(void)setPresentSGViewControlelr:(SGViewController *)presentSGViewControlelr
{
    objc_setAssociatedObject(self, &presentSGViewControlelrKey, presentSGViewControlelr, OBJC_ASSOCIATION_ASSIGN);
}

-(UIViewController *)presentingSGViewController
{
    return objc_getAssociatedObject(self, &presentingSGViewControlelrKey);
}

-(void)setPresentingSGViewController:(UIViewController *)presentingSGViewController_
{
    objc_setAssociatedObject(self, &presentingSGViewControlelrKey, presentingSGViewController_, OBJC_ASSOCIATION_ASSIGN);
}

-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animate:(bool)animated completion:(void (^)(void))completion
{
    if(animated)
    {
        [self presentSGViewController:viewControllerToPresent animation:^BasicAnimation *{
            BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"position"];
            
            CGPoint pnt=viewControllerToPresent.view.layer.position;
            animation.fromValue=[NSValue valueWithCGPoint:CGPointMake(viewControllerToPresent.view.layer.position.x, viewControllerToPresent.view.layer.position.y-viewControllerToPresent.view.l_v_h)];
            animation.toValue=[NSValue valueWithCGPoint:pnt];
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=true;
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            return animation;
        } completion:completion];
    }
    else
        [self presentSGViewController:viewControllerToPresent animation:nil completion:completion];
}

-(void)presentSGViewController:(SGViewController *)viewControllerToPresent completion:(void (^)(void))completion
{
    [self presentSGViewController:viewControllerToPresent animate:true completion:completion];
}

-(float)alphaForPresentView
{
    return 0.7f;
}

-(void)presentSGViewController:(UIViewController *)viewControllerToPresent animation:(BasicAnimation* (^)())animation completion:(void (^)())completion
{
    self.presentSGViewControlelr=viewControllerToPresent;
    viewControllerToPresent.presentingSGViewController=self;
    
    [self addChildViewController:viewControllerToPresent];
    
    [viewControllerToPresent view];
    [viewControllerToPresent l_v_setS:self.l_v_s];
    
    if(animation)
    {
        self.view.userInteractionEnabled=false;
        [self.view alphaViewWithColor:[UIColor blackColor]];
        self.view.alphaView.alpha=0;
        [self.view addSubview:viewControllerToPresent.view];
        [viewControllerToPresent viewWillAppear:true];
        
        BasicAnimation *animate=animation();
        animate.duration=DURATION_PRESENT_VIEW_CONTROLLER;
        
        [animate addToLayer:viewControllerToPresent.view.layer onStart:^(BasicAnimation * bsAnimation) {
            
            [UIView animateWithDuration:DURATION_PRESENT_VIEW_CONTROLLER animations:^{
                self.view.alphaView.alpha=self.alphaForPresentView;
            }];
        } onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            [viewControllerToPresent viewDidAppear:true];
            self.view.userInteractionEnabled=true;
            if(completion)
                completion();
        }];
    }
    else
    {
        [self.view alphaViewWithColor:[UIColor blackColor]];
        self.view.alphaView.alpha=1;
        
        [viewControllerToPresent viewWillAppear:false];
        [self.view addSubview:viewControllerToPresent.view];
        [viewControllerToPresent viewDidAppear:false];
        
        if(completion)
            completion();
    }
}

-(void)dismissSGViewControllerAnimation:(BasicAnimation *(^)())animation completion:(void (^)())completion
{
    if(!self.presentSGViewControlelr)
        return;
    
    __block void(^_completion)()=nil;
    
    if(completion)
        _completion=[completion copy];
    
    [self.presentSGViewControlelr viewWillDisappear:true];
    
    if(animation)
    {
        self.view.userInteractionEnabled=false;
        BasicAnimation *animate=animation();
        
        [animate addToLayer:self.presentSGViewControlelr.view.layer onStart:^(BasicAnimation *bsAnimation) {
            [UIView animateWithDuration:DURATION_PRESENT_VIEW_CONTROLLER animations:^{
                self.view.alphaView.alpha=0;
            }];
            
            [self.presentSGViewControlelr.view.layer setValue:bsAnimation.toValue forKeyPath:bsAnimation.keyPath];
            
        } onStop:^(BasicAnimation *bsAnimation, bool isFinished) {
            
            [self.view removeAlphaView];
            
            self.presentSGViewControlelr.presentingSGViewController=nil;
            [self.presentSGViewControlelr viewDidDisappear:true];
            [self.presentSGViewControlelr.view removeFromSuperview];
            [self.presentSGViewControlelr removeFromParentViewController];
            self.presentSGViewControlelr=nil;
            self.view.userInteractionEnabled=true;
            
            if(_completion)
            {
                _completion();
                _completion=nil;
            }
            
            [self presentSGViewControllerFinished];
        }];
    }
    else
    {
        [self.view removeAlphaView];
        self.presentSGViewControlelr.presentingSGViewController=nil;
        [self.presentSGViewControlelr viewDidDisappear:true];
        [self.presentSGViewControlelr.view removeFromSuperview];
        [self.presentSGViewControlelr removeFromParentViewController];
        self.presentSGViewControlelr=nil;
        
        if(_completion)
        {
            _completion();
            _completion=nil;
        }
        
        [self presentSGViewControllerFinished];
    }
    
}

-(void)dismissSGViewControllerAnimated:(bool)animate completion:(void (^)(void))completion
{
    if(animate)
    {
        [self dismissSGViewControllerAnimation:^BasicAnimation *{
            BasicAnimation *animation=[BasicAnimation animationWithKeyPath:@"position"];
            animation.fromValue=[NSValue valueWithCGPoint:self.presentSGViewControlelr.view.layer.position];
            animation.toValue=[NSValue valueWithCGPoint:CGPointMake(self.presentSGViewControlelr.view.layer.position.x, self.presentSGViewControlelr.view.layer.position.y-self.presentSGViewControlelr.view.l_v_h)];
            animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.fillMode=kCAFillModeForwards;
            animation.removedOnCompletion=true;
            
            return animation;
        } completion:completion];
    }
}

-(void)dismissSGViewControllerCompletion:(void (^)(void))completion
{
    [self dismissSGViewControllerAnimated:true completion:completion];
}

-(void)presentSGViewControllerFinished
{
    
}

@end