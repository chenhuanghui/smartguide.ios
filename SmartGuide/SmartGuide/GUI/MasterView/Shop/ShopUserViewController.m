//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "GUIManager.h"

@interface ShopUserViewController ()

@end

@implementation ShopUserViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //retain shopNavi
    [detailView addSubview:shopNavi.view];
    detailView.receiveView=scrollShopUser;
    
    CGRect rect=CGRectZero;
    rect.origin=CGPointMake(27, 0);
    rect.size=CGSizeMake(266, 393);
    shopNavi.view.frame=rect;
    
    shopNavi.view.layer.masksToBounds=true;
    shopNavi.view.layer.cornerRadius=8;
    shopNavi.isAllowDragBackPreviouseView=true;
    
    scrollShopUser.contentSize=contentScroll.frame.size;
}

-(void)setShop:(Shop *)shop
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showRightView:(SGViewController*) controller
{
    detailView.receiveView=nil;
    
    [shopNavi pushViewController:controller animated:true];
}

- (IBAction)detail:(id)sender {
    ShopDetailInfoViewController *vc=[ShopDetailInfoViewController new];
    
    [self showRightView:vc];
}

- (IBAction)map:(id)sender {
    ShopMapViewController *vc=[ShopMapViewController new];
    
    [self showRightView:vc];
}

- (IBAction)phone:(id)sender {
    makePhoneCall(@"01225372227");
}

- (IBAction)camera:(id)sender {
    ShopCameraViewController *vc=[ShopCameraViewController new];
    
    [self showRightView:vc];
}

- (IBAction)comment:(id)sender {
    ShopCommentViewController *vc=[ShopCommentViewController new];
    
    [self showRightView:vc];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"XXX");
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    detailView.receiveView=viewController==detailController?scrollShopUser:nil;
}

@end

@implementation ScrollShopUser



@end