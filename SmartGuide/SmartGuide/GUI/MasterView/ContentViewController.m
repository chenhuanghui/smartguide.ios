//
//  MasterViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ContentViewController.h"
#import "LoadingScreenViewController.h"
#import "DataManager.h"
#import "Flags.h"
#import "TokenManager.h"
#import "TransportViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize shopController,contentDelegate;

- (id)init
{
    self=[super init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)showShopController
{
    shopController=[[ShopViewController alloc] init];
    shopController.shopDelegate=self;
    
    CGRect rect=self.view.frame;
    rect.origin=CGPointZero;

    shopController.view.frame=rect;
    
    TransportViewController *transport=[[TransportViewController alloc] initWithNavigation:shopController];
    
    transport.view.frame=rect;
    
    [self pushViewController:transport animated:true];
}

-(void)shopViewSelectedShop
{
    [self.contentDelegate contentViewSelectedShop];
}

-(void)shopViewBackToShopListAnimated:(bool)animated
{
    [self.contentDelegate contentViewBackToShopListAnimated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)title
{
    return CLASS_NAME;
}

@end