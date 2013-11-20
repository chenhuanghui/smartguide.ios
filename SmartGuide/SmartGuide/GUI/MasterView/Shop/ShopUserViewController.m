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
@synthesize delegate,shopMode;

- (id)init
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        shopMode=SHOP_USER_FULL;
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
    
    promotionPageControl.delegate=self;
    promotionPageControl.numberOfPages=5;
    
    [self alignPageScroll];
}

-(void)pageControlTouchedNext:(PageControlNext *)pageControl
{
    [self showShopGallery];
}

-(void) showShopGallery
{
    ShopGalleryViewController *vc=[ShopGalleryViewController new];
    
    [self showRightView:vc];
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
    
    _templateShopGallery=[[SGTableTemplate alloc] initWithTableView:promotionTableShopGallery withDelegate:self];
    _templateShopGallery.datasource=[shop.shopGalleryObjects mutableCopy];
    _templateShopGallery.isAllowLoadMore=_templateShopGallery.datasource.count==10;
    
    [self alignPageScroll];
}

-(void) alignPageScroll
{
    CGRect rect=CGRectZero;
    rect.size.width=contentScroll.l_v_w;
    
    //promotion
    [promotionView l_v_setH:promotionShop.l_v_h+promotionDetail.l_v_h];
    
    //info
    [infoView l_v_setY:promotionView.l_v_h];
    
    //gallery
    [galleryView l_v_setY:infoView.l_v_h+infoView.l_v_y];
    
    //comment
    [commentView l_v_setY:galleryView.l_v_h+galleryView.l_v_y];
    
    rect.size.height=promotionView.l_v_h;
    rect.size.height+=infoView.l_v_h;
    rect.size.height+=galleryView.l_v_h;
    rect.size.height+=commentView.l_v_h;
    
    contentScroll.frame=rect;
    
    [bottomView l_v_setY:commentView.l_v_y+commentView.l_v_h];
    
    scrollShopUser.contentSize=contentScroll.l_v_s;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showRightView:(SGViewController*) controller
{
    if([controller isKindOfClass:[ShopGalleryViewController class]])
        shopMode=SHOP_USER_SHOP_GALLERY;
    else if([controller isKindOfClass:[ShopDetailInfoViewController class]])
        shopMode=SHOP_USER_INFO;
    else if([controller isKindOfClass:[ShopScanQRCodeViewController class]])
        shopMode=SHOP_USER_SCAN;
    else if([controller isKindOfClass:[ShopMapViewController class]])
        shopMode=SHOP_USER_MAP;
    else if([controller isKindOfClass:[ShopCameraViewController class]])
        shopMode=SHOP_USER_CAMERA;
    else if([controller isKindOfClass:[ShopCommentViewController class]])
        shopMode=SHOP_USER_COMMENT;
    
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
    if(viewController==detailController)
    {
        shopMode=SHOP_USER_FULL;
        detailView.receiveView=scrollShopUser;
    }
    else
    {
        detailView.receiveView=nil;
    }
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
    [scrollShopUser setContentOffset:CGPointZero animated:true];
}

-(IBAction) btnSendCommentTouchUpInside:(id)sender
{
    if(shopMode==SHOP_USER_FULL)
    {
        [self showCommentController];
    }
}

-(NSArray*) pages
{
    return @[promotionView,infoView,galleryView,commentView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==promotionTableShopGallery)
    {
        return _templateShopGallery.datasource.count==0?0:1;
    }
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==promotionTableShopGallery)
    {
        return _templateShopGallery.datasource.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==promotionTableShopGallery)
    {
        
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==promotionTableShopGallery)
    {
        return tableView.l_v_w;
    }
    
    return 0;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(textView==txtComment)
    {
        if(shopMode==SHOP_USER_FULL)
        {
            [self showCommentController];
            
            return false;
        }
    }
    
    return true;
}

-(void) showCommentController
{
    ShopCommentViewController *vc=[ShopCommentViewController new];
    [self showRightView:vc];
}

@end

@implementation ScrollShopUser



@end