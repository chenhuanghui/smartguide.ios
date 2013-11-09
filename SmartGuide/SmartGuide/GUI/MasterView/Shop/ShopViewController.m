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
@synthesize shopDelegate,shopList;

-(id)init
{
    ShopCatalogViewController *vc=[[ShopCatalogViewController alloc] init];
    vc.delegate=self;
    
    self=[super initWithRootViewController:vc];
    self.delegate=self;
    self.isAllowDragBackPreviouseView=true;
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationBarHidden:true];
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

-(void)shopCatalogSelectedCatalog:(ShopCatalog *)group
{
    ShopListViewController *_shopList=[[ShopListViewController alloc] init];
    _shopList.delegate=self;
    
    shopList=_shopList;
    
    [_shopList loadWithCatalog:group onCompleted:^(bool isSuccessed) {
        [self.view SGRemoveLoading];
        
        [[GUIManager shareInstance] hideAdsWithDuration:DURATION_DEFAULT];
        [self pushViewController:shopList animated:true];
        shopList=nil;
    }];
    
    [self.view SGShowLoading];
}

-(void)shopListSelectedShop
{
    [[GUIManager shareInstance] presentShopUserWithIDShop:0];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc=[super popViewControllerAnimated:animated];
    if([vc isKindOfClass:[ShopListViewController class]])
        [[GUIManager shareInstance] showAdsWithDuration:DURATION_DEFAULT];
    
    return vc;
}

CALL_DEALLOC_LOG
@end
