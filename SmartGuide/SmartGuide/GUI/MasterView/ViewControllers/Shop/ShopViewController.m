//
//  MainViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopViewController.h"
#import "GUIManager.h"

@interface ShopViewController ()

@end

@implementation ShopViewController
@synthesize shopList,shopCatalog;

-(id)init
{
    self=[super initWithNibName:@"ShopViewController" bundle:nil];

    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.childNavigationController];
    [contentView addSubview:self.childNavigationController.view];
    
    CGRect rect=contentView.frame;
    rect.origin=CGPointZero;
    self.childNavigationController.view.frame=rect;
    
    self.childNavigationController.isAllowDragBackPreviouseView=true;
    
    ShopCatalogViewController *vc=[[ShopCatalogViewController alloc] init];
    vc.delegate=self;
    
    shopCatalog=vc;
    
    [self.childNavigationController pushViewController:vc animated:false];
}

-(void)showShopListWithGroup:(ShopCatalog*) group
{
    ShopListViewController *vc=[[ShopListViewController alloc] init];
    vc.delegate=self;
    
    shopList=vc;
    
    [self.childNavigationController pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shopCatalogSelectedCatalog:(ShopCatalog *)group
{
    [self showShopListWithGroup:group];
}

-(void)shopListSelectedShop
{
    [[GUIManager shareInstance] presentShopUserWithIDShop:0];
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate shopControllerTouchedSetting:self];
}

- (IBAction)btnNotificationTouchUpInside:(id)sender {
}

- (IBAction)btnCancelTouchUpInside:(id)sender {
    [[GUIManager shareInstance] closeViewController:searchShopController];
    
    searchShopController=nil;
}

- (IBAction)btnConfigTouchUpInside:(id)sender {
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showSearch];
    
    return true;
}

-(void) showSearch
{
    if(searchShopController)
        return;
    
    SearchShopViewController *vc=[[SearchShopViewController alloc] init];
    vc.delegate=self;
    
    searchShopController=vc;
    
    [[GUIManager shareInstance] displayViewController:vc];
}

@end
