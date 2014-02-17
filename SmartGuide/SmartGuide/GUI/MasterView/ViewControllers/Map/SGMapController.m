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

-(void)shopUserFinished:(ShopUserViewController *)controller
{
    [self popViewControllerAnimated:true];
}

-(void)shopUserRequestScanCode:(ShopUserViewController *)controller
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
