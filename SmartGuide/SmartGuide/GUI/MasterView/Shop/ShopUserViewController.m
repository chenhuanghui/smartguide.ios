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
    rect.origin=CGPointMake(15, 0);
    rect.size=CGSizeMake(290, 431);
    shopNavi.view.frame=rect;
    
    shopNavi.view.layer.masksToBounds=true;
    shopNavi.view.layer.cornerRadius=8;
    shopNavi.isAllowDragBackPreviouseView=true;
    
    [self alignPageScroll];
}

-(void)setShop:(Shop *)shop
{
    
}

-(void) alignPageScroll
{
    scrollShopUser.pagingEnabled=true;
    [scrollShopUser l_v_setH:0];
    scrollShopUser.contentSize=promotionView.l_v_s;
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

- (IBAction)btnCloseTouchUpInside:(id)sender {
    [self.delegate shopUserFinished];
}

-(IBAction) btnInfoTouchUpInside:(id)sender
{
    ShopDetailInfoViewController *vc=[ShopDetailInfoViewController new];
    
    [self showRightView:vc];
}

-(IBAction) btnNextPageTouchUpInside:(id)sender
{
    
}

-(NSArray*) pages
{
    return @[promotionView,infoView,galleryView,commentView];
}

@end

@implementation ScrollShopUser



@end