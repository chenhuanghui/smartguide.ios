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
    
    btnNextPageCenter=btnNextPage.center;
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"t"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor grayColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [promotionInfo addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"k"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor redColor];
    style.font=[UIFont systemFontOfSize:10];
    
    [promotionInfo addStyle:style];
    
    [promotionInfo setText:@"<t>Với mỗi <k>100K</k> trên hoá đơn bạn sẽ được 1 lượt quét thẻ</t>"];
    
    style=[FTCoreTextStyle styleWithName:@"t"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor grayColor];
    style.font=[UIFont systemFontOfSize:8];
    
    [promotionSP addStyle:style];
    [promotionP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"sp"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor blackColor];
    style.font=[UIFont boldSystemFontOfSize:10];
    
    [promotionSP addStyle:style];
    [promotionP addStyle:style];
    
    [promotionSP setText:@"<sp>300 SP</sp><t> tích luỹ</t>"];
    [promotionP setText:@"<sp>10 P</sp><t> cho </t><sp>1 SGP</sp>"];
    
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
    
    promotionPageControl.dotColorCurrentPage=[UIColor whiteColor];
    promotionPageControl.dotColorOtherPage=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    promotionPageControl.delegate=self;
    
    [promotionTableShopGallery registerNib:[UINib nibWithNibName:[ShopGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopGalleryCell reuseIdentifier]];
    
    [promotionTableListPromotion registerNib:[UINib nibWithNibName:[ShopKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM1Cell reuseIdentifier]];
    
    rect=promotionTableShopGallery.frame;
    
    promotionTableShopGallery.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    
    promotionTableShopGallery.frame=rect;
    
    tableShopGalleryCenter=promotionTableShopGallery.center;
    
    [self setShop:nil];
    [self alignKM1View];
    [self alignPageScroll];
}

-(void) alignKM1View
{
    [promotionTableListPromotion reloadData];
    
    CGRect rect=promotionTableListPromotion.frame;
    rect.size.height=promotionTableListPromotion.contentSize.height;
    promotionTableListPromotion.frame=rect;
    
    rect=promotionBottomView.frame;
    rect.origin.y=promotionTableListPromotion.frame.size.height;
    promotionBottomView.frame=rect;
    
    rect=promotionContainListPromotionView.frame;
    rect.size.height=promotionBottomView.l_v_y+promotionBottomView.l_v_h;
    promotionContainListPromotionView.frame=rect;
    
    rect=promotionDetailKM1.frame;
    rect.size.height=promotionContainListPromotionView.l_v_y+promotionContainListPromotionView.l_v_h;
    promotionDetailKM1.frame=rect;
    
    rect=promotionDetailScrollContent.frame;
    rect.size.height=promotionDetailKM1.l_v_h;
    promotionDetailScrollContent.frame=rect;
    
    rect=promotionDetailScroll.frame;
    rect.size.height=promotionDetailScrollContent.l_v_h;
    promotionDetailScroll.frame=rect;
    
    rect=promotionDetail.frame;
    rect.size.height=promotionDetailScroll.l_v_h;
    promotionDetail.frame=rect;
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
    _templateShopGallery.datasource=[NSMutableArray arrayWithCapacity:20];
    
    for(int i=0;i<6;i++)
    {
        [_templateShopGallery.datasource addObject:@""];
    }
    
    promotionPageControl.numberOfPages=_templateShopGallery.datasource.count;
    
    _templateShopGallery.isAllowLoadMore=_templateShopGallery.datasource.count==10;
}

-(void) alignPageScroll
{
    CGRect rect=CGRectZero;
    rect.size.width=contentScroll.l_v_w;
    
    //promotion
    [promotionView l_v_setH:promotionDetail.l_v_y+promotionDetail.l_v_h];
    
    //info
    [infoView l_v_setY:promotionView.l_v_h+btnNextPage.l_v_h];
    
    //gallery
    [galleryView l_v_setY:infoView.l_v_h+infoView.l_v_y];
    
    //comment
    [commentView l_v_setY:galleryView.l_v_h+galleryView.l_v_y];
    
    rect.size.height=commentView.l_v_y+commentView.l_v_h;
    
    contentScroll.frame=rect;
    
    [bottomView l_v_setY:commentView.l_v_y+commentView.l_v_h];
    
    scrollShopUser.contentSize=contentScroll.l_v_s;
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, promotionView.l_v_w, promotionView.l_v_h)];
    v.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.3f];
    
//    [scrollShopUser insertSubview:v belowSubview:btnNextPage];
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
    if(scrollView==promotionTableShopGallery)
    {
        [promotionPageControl scrollViewDidScroll:scrollView isHorizontal:true];
    }
    else if(scrollView==scrollShopUser)
    {
        CGPoint offset=promotionTableShopGallery.contentOffset;
        offset.x=scrollView.contentOffset.y/3;
        promotionTableShopGallery.contentOffset=offset;
        
        float y=btnNextPageCenter.y+scrollView.contentOffset.y;
        
        if(y-btnNextPage.l_v_h/2>promotionView.l_v_h)
            y=y-(y-promotionView.l_v_h)+btnNextPage.l_v_h/2+1;
        else
            btnNextPage.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
        
        if(y<scrollView.contentOffset.y+btnNextPage.l_v_h/2)
        {
            y=scrollView.contentOffset.y+btnNextPage.l_v_h/2-2.5f;
            btnNextPage.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
        }
        
        [btnNextPage l_c_setY:y];
    }
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
    [scrollShopUser setContentOffset:[promotionView convertPoint:promotionDetail.l_v_o toView:contentScroll] animated:true];
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
    else if(tableView==promotionTableListPromotion)
        return 1;
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==promotionTableShopGallery)
    {
        return _templateShopGallery.datasource.count;
    }
    else if(tableView==promotionTableListPromotion)
        return 10;
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==promotionTableShopGallery)
    {
        ShopGalleryCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopGalleryCell reuseIdentifier]];
        
        [cell setLbl:[NSString stringWithFormat:@"%02i",indexPath.row+1]];
        
        return cell;
    }
    else if(tableView==promotionTableListPromotion)
    {
        ShopKM1Cell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM1Cell reuseIdentifier]];
        
        [cell setLL:[NSString stringWithFormat:@"%02i",indexPath.row+1]];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==promotionTableShopGallery)
        return tableView.l_v_w;
    else if(tableView==promotionTableListPromotion)
        return [ShopKM1Cell height];
    
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