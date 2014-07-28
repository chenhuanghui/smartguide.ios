//
//  RevealViewController.m
//  Infory
//
//  Created by XXX on 7/24/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RevealViewController.h"

@interface RevealView : UIScrollView<UIGestureRecognizerDelegate>

-(void) makeContentSize;

-(void) showRearView:(bool) animate;
-(void) showFrontView:(bool) animate;

@property (nonatomic, weak) UIView *rearView;
@property (nonatomic, weak) UIView *frontView;

@end

@interface RevealViewController ()<UIScrollViewDelegate>
{
}

@end

@implementation RevealViewController

-(RevealViewController *)initWithFrontController:(UIViewController *)frontControlelr rearController:(UIViewController *)rearController
{
    self=[super init];
    
    self.frontController=frontControlelr;
    self.rearController=rearController;
    
    return self;
}

-(RevealView*) revealView
{
    return (RevealView*)self.view;
}

-(void)loadView
{
    self.view=[RevealView new];
}

-(void)showFrontController:(bool)animate
{
    [[self revealView] showFrontView:animate];
}

-(void)showRearController:(bool)animate
{
    [[self revealView] showRearView:animate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor clearColor];
    self.view.autoresizesSubviews=true;
    
    [self addChildViewController:self.frontController];
    [self addChildViewController:self.rearController];
    
    CGRect rect=self.rearController.view.frame;
    UIView *rearView=[[UIView alloc] initWithFrame:rect];
    rearView.backgroundColor=[UIColor clearColor];
    
    [rearView addSubview:self.rearController.view];
    
    [self.view addSubview:rearView];
    
    rect=self.frontController.view.frame;
    UIView *frontView=[[UIView alloc] initWithFrame:rect];
    frontView.backgroundColor=[UIColor clearColor];
    
    CALayer *frontViewLayer = frontView.layer;
    frontViewLayer.masksToBounds = NO;
    frontViewLayer.shadowColor = [UIColor blackColor].CGColor;
    frontViewLayer.shadowOpacity = 1.0f;
    frontViewLayer.shadowOffset = CGSizeMake(0, 2.5f);
    frontViewLayer.shadowRadius = 2.5f;
    
    [frontView addSubview:self.frontController.view];
    
    [self.view addSubview:frontView];
    
    [self revealView].frontView=frontView;
    [self revealView].rearView=rearView;
    
    [[self revealView] makeContentSize];
    
    [self revealView].delegate=self;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    tap.cancelsTouchesInView=false;
    
    [self.view addGestureRecognizer:tap];
    [[self revealView].panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    [[self revealView].panGestureRecognizer addTarget:self action:@selector(panGes:)];
}

-(void) panGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            if((int)[self revealView].contentOffset.x>=(int)[self revealView].rearView.l_v_w)
            {
                [self.delegate revealControllerWillDisplayRearView:self];
            }
            break;
            
        default:
            break;
    }
}

-(void) tapGes:(UITapGestureRecognizer*) tap
{
    CGPoint offset=[self revealView].contentOffset;
    CGPoint pnt=[tap locationInView:[self revealView]];
    
    if((int)offset.x==0)
    {
        if(pnt.x>[self revealView].rearView.l_v_w)
        {
            [self showFrontController:true];
        }
    }
}

-(void)viewWillAppearOnce
{
    [[self revealView].frontView l_v_setH:[self revealView].l_v_h];
    [[self revealView].rearView l_v_setH:[self revealView].l_v_h];
    [[self revealView] layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation RevealView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pagingEnabled=true;
        self.bounces=false;
        self.panGestureRecognizer.delegate=self;
    }
    return self;
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==self.panGestureRecognizer)
    {
        if(self.contentOffset.x>0)
        {
            float allowDragX=80;
            CGPoint pnt=[gestureRecognizer locationInView:self.frontView];
            if(pnt.x>allowDragX)
                return false;
        }
        else
        {
            CGPoint pnt=[gestureRecognizer locationInView:self.rearView];
            if(pnt.x<self.rearView.l_v_w)
                return false;
        }
        
        CGPoint velocity=[self.panGestureRecognizer velocityInView:self];
        
        return fabsf(velocity.x)>fabsf(velocity.y);
    }
    
    return true;
}

-(void)makeContentSize
{
    self.contentSize=CGSizeMake(self.rearView.l_v_w+self.frontView.l_v_w, 0);
}

-(void)layoutSubviews
{
    //    [super layoutSubviews];
    
    [self.rearView l_v_setX:self.contentOffset.x];
    [self.frontView l_v_setX:self.rearView.l_v_w];
    
    self.rearView.userInteractionEnabled=self.contentOffset.x<self.rearView.l_v_w/2;
    self.frontView.userInteractionEnabled=!self.rearView.userInteractionEnabled;
}

-(void)showFrontView:(bool)animate
{
    [self setContentOffset:CGPointMake(self.rearView.l_v_w, 0) animated:animate];
}

-(void)showRearView:(bool)animate
{
    [self setContentOffset:CGPointZero animated:animate];
}

@end