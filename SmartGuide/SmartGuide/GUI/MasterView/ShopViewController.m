//
//  MainViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

-(id)init
{
    ShopCategoriesViewController *vc=[[ShopCategoriesViewController alloc] init];
    vc.delegate=self;
    
    self=[super initWithRootViewController:vc];
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
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

-(void)shopCategoriesSelectedGroup
{
    ShopListViewController *shopList=[[ShopListViewController alloc] init];
    shopList.delegate=self;
    
    [self pushViewController:shopList animated:true];
}

-(void)shopListSelectedShop
{
    ShopUserViewController *shopUser=[[ShopUserViewController alloc] init];
    shopUser.delegate=self;
    
    [self pushViewController:shopUser animated:true];
}

-(void)shopUserFinished
{
    [self popViewControllerAnimated:true];
}

@end
