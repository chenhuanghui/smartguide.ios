//
//  SGUserColllectionController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserCollectionController.h"

@interface SGUserCollectionController ()

@end

@implementation SGUserCollectionController
@synthesize userCollection;

-(id)init
{
    SGUserCollectionViewController *vc=[[SGUserCollectionViewController alloc] init];
    self=[super initWithRootViewController:vc];
    
    userCollection=vc;
    userCollection.delegate=self;
    
    self.delegate=self;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    userCollection=nil;
    NSLog(@"dealloc %@", CLASS_NAME);
}

-(void)shopUserFinished
{
    [self popViewControllerAnimated:true];
}

-(void)SGUserCollectionSelectedShop
{
    ShopUserViewController *shop=[[ShopUserViewController alloc] init];
    shop.delegate=self;
    
    _panHandle=[[PanGestureView alloc] initWithDirection:PanGestureDirectionToLeft withCurrentView:self.visibleViewController.view withOtherView:shop.view];
    _panHandle.delegate=self;
    
    panGes=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
    panGes.delegate=self;
    
    [self.view addGestureRecognizer:panGes];
    
    [self pushViewController:shop animated:true];
}

-(void)panGestureMovedToView:(UIView *)view
{
    if(view==self.userCollection.view)
    {
        [self popViewControllerAnimated:false];
        
        _panHandle.delegate=nil;
        _panHandle=nil;
        
        [panGes removeTarget:self action:@selector(panGes:)];
        [self.view removeGestureRecognizer:panGes];
        panGes=nil;
    }
}

-(void) panGes:(UIPanGestureRecognizer*) ges
{
    [_panHandle handlePanGesture:ges];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController!=userCollection)
    {
        userCollection.view.center=CGPointMake(-self.view.frame.size.width/2, userCollection.view.center.y);
        [self.view addSubview:userCollection.view];
    }
}

@end
