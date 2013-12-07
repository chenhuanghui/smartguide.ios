//
//  MainViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopViewController.h"
#import "GUIManager.h"
#import "ShopCatalogViewController.h"
#import "ShopListViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController
@synthesize shopList,shopCatalog;

-(id)init
{
    self=[super initWithNibName:@"ShopViewController" bundle:nil];

    return self;
}

-(void) showShopCatalog:(bool) animated
{
    ShopCatalogViewController *vc=[[ShopCatalogViewController alloc] init];
    vc.delegate=self;
    
    [self settingShopHandle:vc];
    
    shopCatalog=vc;
    
    [self.childNavigationController pushViewController:vc animated:animated];
}

-(void) settingShopHandle:(id<ShopControllerHandle>) handle
{
    [handle setShopController:self];
    [handle setQrCodeView:qrView];
    [handle setQrViewFrame:_qrViewFrame];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _qrViewFrame=qrView.frame;
    
    self.view.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    
    [self addChildViewController:self.childNavigationController];
    [contentView addSubview:self.childNavigationController.view];
    
    CGRect rect=contentView.frame;
    rect.origin=CGPointZero;
    self.childNavigationController.view.frame=rect;
    
    [contentView l_v_addH:QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
    
    self.childNavigationController.isAllowDragBackPreviouseView=true;
    
    [self showShopCatalog:false];
    
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search.png"]];
    imgv.contentMode=UIViewContentModeCenter;
    imgv.frame=CGRectMake(0, 0, 30, 18);
    txtSearch.leftView=imgv;
    txtSearch.leftViewMode=UITextFieldViewModeAlways;
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnSortTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame=CGRectMake(0, 0, 18, 14);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    
    txtSearch.rightView=btn;
    txtSearch.rightViewMode=UITextFieldViewModeAlways;
}

-(void) btnSortTouchUpInside:(id) sender
{
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    lblLocation.text=[NSString stringWithFormat:@"“%@”", [actionSheet buttonTitleAtIndex:buttonIndex]];
}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}


-(void)showShopListWithGroup:(ShopCatalog*) group
{
    ShopListViewController *vc=[[ShopListViewController alloc] init];
    vc.delegate=self;
    
    [self settingShopHandle:vc];
    
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
    [self.delegate shopControllerTouchedNotification:self];
}

- (IBAction)btnCancelTouchUpInside:(id)sender {
    [self hideSearch];
}

- (IBAction)btnConfigTouchUpInside:(id)sender {
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showSearch];
    
    return true;
}

-(void) hideSearch
{
    [[GUIManager shareInstance] closeViewController:searchShopController];
    searchShopController=nil;
    
    titleView.alpha=0;
    titleView.hidden=false;
    
    [self.view endEditing:true];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        searchView.alpha=0;
        titleView.alpha=1;
    } completion:^(BOOL finished) {
        
        searchView.hidden=true;
    }];
}

-(void) showSearch
{
    if(searchShopController)
        return;
    
    SearchShopViewController *vc=[[SearchShopViewController alloc] init];
    vc.delegate=self;
    
    [vc view];
    [vc.view l_v_setY:topView.l_v_h];
    
    searchShopController=vc;
    
    [[GUIManager shareInstance] displayViewController:vc];
    
    searchView.alpha=0;
    searchView.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        searchView.alpha=1;
        titleView.alpha=0;
    } completion:^(BOOL finished) {
        
        titleView.hidden=true;
    }];
}

- (IBAction)btnQRCodeTouchUpInside:(id)sender {
    id<ShopControllerHandle> handle=(id<ShopControllerHandle>)self.childNavigationController.visibleViewController;
    
    if([handle isShowedQRView])
        [handle hideQRView];
    else
        [handle showQRView];
    
    [handle setIsShowedQRView:![handle isShowedQRView]];
}

-(CGRect)qrViewFrame
{
    return _qrViewFrame;
}

-(float)searchFieldHeight
{
    return 42;
}

@end
