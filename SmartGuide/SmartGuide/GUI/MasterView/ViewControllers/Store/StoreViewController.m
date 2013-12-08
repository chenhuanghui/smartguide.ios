//
//  StoreViewController.m
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"StoreViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addChildViewController:storeNavigation];
    
    [contentView addSubview:storeNavigation.view];
    [storeNavigation.view l_v_setS:contentView.l_v_s];
    
    [storeNavigation setRootViewController:[StoreShopViewController new] animate:true];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStoreNavi:)];
    
    [storeNavigation.view addGestureRecognizer:tap];
    
    tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQR:)];
    
    [qrView addGestureRecognizer:tap];
}

-(void) tapQR:(UITapGestureRecognizer*) tap
{
    [self showQRCodeWithContorller:self inView:qrView];
}

-(void)qrcodeControllerRequestClose:(SGQRCodeViewController *)controller
{
    [self hideQRCode];
}

-(void) tapStoreNavi:(UITapGestureRecognizer*) tap
{
    if(storeNavigation.viewControllers.count>1)
        [storeNavigation popToRootViewControllerAnimated:true];
    else
        [storeNavigation pushViewController:[StoreShopItemsViewController new] animated:true];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    storeNavigation=nil;
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate storeControllerTouchedSetting:self];
}

@end
