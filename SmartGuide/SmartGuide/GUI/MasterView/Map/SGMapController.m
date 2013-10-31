//
//  SGMapController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGMapController.h"

@interface SGMapController ()

@end

@implementation SGMapController
@synthesize mapViewController;

- (id)init
{
    SGMapViewController *map=[[SGMapViewController alloc] init];
    
    self = [super initWithRootViewController:map];
    
    mapViewController=map;
    mapViewController.delegate=self;

    return self;
}

-(void)SGMapViewSelectedShop
{
    ShopUserViewController *shop=[[ShopUserViewController alloc] init];
    shop.delegate=self;
    
    [self pushViewController:shop animated:true];
}

-(void)shopUserFinished
{
    [self popViewControllerAnimated:true];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.delegate=self;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==panGes)
    {
        return [self.visibleViewController isKindOfClass:[ShopUserViewController class]];
    }
    
    return true;
}

-(void) panGes:(UIPanGestureRecognizer*) ges
{
    [panHandle handlePanGesture:ges];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController!=self.mapViewController)
    {
        self.mapViewController.view.center=CGPointMake(-self.view.frame.size.width/2, self.view.frame.size.height/2);
        [self.view addSubview:self.mapViewController.view];
        
        
        if(panGes)
        {
            [panGes removeTarget:self action:@selector(panGes:)];
            panGes.delegate=nil;
            [self.view removeGestureRecognizer:panGes];
            panGes=nil;
        }
        
        if(panHandle)
        {
            panHandle.delegate=nil;
            panHandle=nil;
        }
        
        panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        panGes.delegate=self;
        
        [self.view addGestureRecognizer:panGes];
        
        panHandle=[[PanDragViewHandle alloc] initWithDirection:PanGestureDirectionToLeft withCurrentView:self.mapViewController.view withOtherView:viewController.view];
        panHandle.delegate=self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    mapViewController=nil;
    NSLog(@"dealloc %@", CLASS_NAME);
}

-(void)panGestureMovedToView:(UIView *)view
{
    if(view==self.mapViewController.view)
    {
        [self popViewControllerAnimated:false];
        
        if(panGes)
        {
            [panGes removeTarget:self action:@selector(panGes:)];
            panGes.delegate=nil;
            [self.view removeGestureRecognizer:panGes];
            panGes=nil;
        }
        
        if(panHandle)
        {
            panHandle.delegate=nil;
            panHandle=nil;
        }
    }
}

@end
