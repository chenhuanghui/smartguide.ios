//
//  SGRootViewController.m
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGRootViewController.h"
#import "SGSettingViewController.h"
#import "KeyboardUtility.h"
#import "GUIManager.h"

@interface SGRootViewController ()<SGSettingDelegate,UIScrollViewDelegate>

@end

@implementation SGRootViewController
@synthesize containFrame,contentFrame;

- (id)initWithDelegate:(id<SGViewControllerDelegate>)_delegate
{
    self = [super initWithNibName:@"SGRootViewController" bundle:nil];
    if (self) {
        self.delegate=_delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.containView.layer.masksToBounds=true;
    self.contentView.layer.masksToBounds=true;
    
    self.settingController=[SGSettingViewController new];
    self.settingController.delegate=self;
    
    [leftView addSubview:self.settingController.view];
    
    scrollContent.contentSize=CGSizeMake(640, UIScreenSize().height);
    [scrollContent l_co_setX:320];
    
    [scrollContent.panGestureRecognizer addTarget:self action:@selector(panGes:)];
}

-(void) panGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [self.settingController loadData];
            break;
            
        default:
            break;
    }
}

-(void)settingTouchedHome:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedHome:controller];
}

-(void)settingTouchedOtherView:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedOtherView:controller];
}

-(void)settingTouchedPromotion:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedPromotion:controller];
}

-(void)settingTouchedStore:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedStore:controller];
}

-(void)settingTouchedTutorial:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedTutorial:controller];
}

-(void)settingTouchedUser:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedUser:controller];
}

-(void)settingTouchedUserSetting:(SGSettingViewController *)controller
{
    [[GUIManager shareInstance] settingTouchedUserSetting:controller];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([KeyboardUtility shareInstance].isKeyboardVisible)
        [self.view endEditing:true];
    
    float settingWidth=274.f;
    float x=320.f-scrollView.l_co_x;
//    float perX=x/settingWidth;
//    perX=0.8f+(perX/5);
//    perX=MAX(0.1f,perX);

//    leftView.transform=CGAffineTransformMakeScale(perX, perX);
    [leftView l_v_setX:scrollView.l_co_x-settingWidth/2+(320-scrollView.l_co_x)/2];
//    [leftView l_v_setY:leftView.l_v_h*perX-leftView.l_v_h];
    
    if(x<settingWidth/3)
        leftView.alpha=0.3f;
    else
        leftView.alpha=MAX(0.3f,(x-settingWidth/3)/(settingWidth-settingWidth/3));
    
    [self endScroll];
}

-(void)showSettingController
{
    [self.settingController loadData];
    [scrollContent setContentOffset:CGPointZero animated:true];
}

-(void) hideSettingController
{
    [scrollContent setContentOffset:CGPointMake(320, 0) animated:true];
}

-(void) endScroll
{
//    if(scrollContent.l_co_x<320)
//    {
//        self.contentView.userInteractionEnabled=false;
//        leftView.userInteractionEnabled=true;
//    }
//    else
//    {
//        self.contentView.userInteractionEnabled=true;
//        leftView.userInteractionEnabled=false;
//    }
}

-(void)storeRect
{
    containFrame=self.containView.frame;
    contentFrame=self.contentView.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveToTopView:(SGViewController *)displayView
{
    self.topView.alpha=0;
    self.topView.hidden=false;
    
    [self.topView l_v_setO:displayView.l_v_o];
    
    [displayView l_v_setO:CGPointZero];
    [self.topView l_v_setS:displayView.l_v_s];
    
    [self addChildViewController:displayView];
    [self.topView addSubview:displayView.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.topView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)removeTopView:(SGViewController *)displayView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        self.topView.alpha=0;
    } completion:^(BOOL finished) {
        
        [displayView.view removeFromSuperview];
        [displayView removeFromParentViewController];
        
        self.topView.hidden=true;
    }];
}

@end

@interface ScrollViewRoot()<UIGestureRecognizerDelegate>

@end

@implementation ScrollViewRoot

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.panGestureRecognizer.delegate=self;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    tap.cancelsTouchesInView=false;
    tap.delaysTouchesBegan=false;
    tap.delaysTouchesEnded=false;
    
    tap.delegate=self;
    
    [self.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [self addGestureRecognizer:tap];
    
    tapGes=tap;
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self killScroll];
        [self setContentOffset:CGPointMake(320, 0) animated:true];
    });
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.x<320.f-274)
        contentOffset.x=320.f-274;
    
    [super setContentOffset:contentOffset];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panGestureRecognizer)
    {
        if(self.currentPage==1)
        {
            CGPoint pnt=[self.panGestureRecognizer locationInView:self];
            pnt.x-=320;
            
            return pnt.x<80;
        }
    }
    else if(gestureRecognizer==tapGes)
    {
        if(self.currentPage==0)
        {
            CGPoint pnt=[tapGes locationInView:self];
            pnt.x-=49;
            
            return pnt.x>274.f;
        }
        
        return false;
    }
    
    return true;
}

@end