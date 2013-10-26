//
//  SGSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGSettingViewController.h"

@interface SGSettingViewController ()

@end

@implementation SGSettingViewController
@synthesize delegate,slideView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tap.delegate=self;
    
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    
    [self.view addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    pan.delegate=self;
    
    [pan requireGestureRecognizerToFail:tap];
    
    [self.view addGestureRecognizer:pan];
}

-(void)showSettingWithContaintView:(UIView *)containtView slideView:(UIView *)_slideView
{
    self.slideView=_slideView;
    self.slideView.userInteractionEnabled=false;
    
    __block CGRect rect=self.view.frame;
    rect.origin.x=-rect.size.width;
    self.view.frame=rect;
    
    [containtView addSubview:self.view];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        rect.origin.x=0;
        self.view.frame=rect;
        
        self.slideView.center=CGPointMake(self.slideView.center.x+245, self.slideView.center.y);
    } completion:^(BOOL finished) {
        
    }];
}

-(void) tapGes:(UITapGestureRecognizer*) ges
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=self.view.frame;
        rect.origin.x=-rect.size.width;
        self.view.frame=rect;
        
        self.slideView.center=CGPointMake(self.slideView.center.x-245, self.slideView.center.y);
    } completion:^(BOOL finished) {
        
        self.slideView.userInteractionEnabled=true;
        self.slideView=nil;
        
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
        
        [self.delegate SGSettingHided];
    }];
}

-(void) panGes:(UIPanGestureRecognizer*) ges
{
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            _startPoint=[ges locationInView:self.view.superview];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint pnt=[ges locationInView:self.view.superview];
            float deltaX=pnt.x-_startPoint.x;
            _startPoint=pnt;
            
            if(self.view.center.x+deltaX>160)
            {
                self.view.center=CGPointMake(160, self.view.center.y);
                
                CGRect rect=self.slideView.frame;
                rect.origin.x=245;
                self.slideView.frame=rect;
                return;
            }
            
            self.view.center=CGPointMake(self.view.center.x+deltaX, self.view.center.y);
            self.slideView.center=CGPointMake(self.slideView.center.x+deltaX, self.slideView.center.y);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            float velocity=[ges velocityInView:self.view.superview].x;
            
            if(velocity>0 && velocity>VELOCITY_SLIDE)
                [self moveToMyView];
            else
                [self moveToSlideView];
        }
            break;
            
        default:
            break;
    }
}

-(void) moveToMyView
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=self.view.frame;
        rect.origin.x=0;
        self.view.frame=rect;
        
        rect=self.slideView.frame;
        rect.origin.x=245;
        self.slideView.frame=rect;
    }];
}

-(void) moveToSlideView
{
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=self.view.frame;
        rect.origin.x=-rect.size.width;
        self.view.frame=rect;
        
        rect=self.slideView.frame;
        rect.origin.x=0;
        self.slideView.frame=rect;
    } completion:^(BOOL finished) {
        self.slideView.userInteractionEnabled=true;
        self.slideView=nil;
        
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
        
        [self.delegate SGSettingHided];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
