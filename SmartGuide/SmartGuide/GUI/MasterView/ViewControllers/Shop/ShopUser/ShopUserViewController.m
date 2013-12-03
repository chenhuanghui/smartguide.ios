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
    
    //UIColor *patternColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern_promotion.png"]];
    
    //promotionDetail.backgroundColor=patternColor;
    
    _buttonDirectionGoDown=true;
    
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
    
    [self settingUserGallery];
    [self settingUserComment];
    
    [self setShop:nil];
    [self alignKM1View];
    [self alignPageScroll];
    
//    [map removeFromSuperview];
//    [infoView removeFromSuperview];
//    [promotionView removeFromSuperview];
}

-(void) settingUserComment
{
    [tableUserComment registerNib:[UINib nibWithNibName:[ShopUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserCommentCell reuseIdentifier]];
    
    _templateUserComment=[[SGTableTemplate alloc] initWithTableView:tableUserComment withDelegate:self];
    _templateUserComment.isAllowLoadMore=false;
    
    for(int i=0;i<10;i++)
    {
        
        [_templateUserComment.datasource addObject:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];
    }
    
    [_templateUserGallery reload];
}

-(void) settingUserGallery
{
    tableShopGalleryCenter=promotionTableShopGallery.center;
    
    CGRect rect=tableUserGallery.frame;
    tableUserGallery.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45)*6);
    tableUserGallery.frame=rect;
    
    [tableUserGallery registerNib:[UINib nibWithNibName:[ShopUserGalleryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserGalleryCell reuseIdentifier]];
    
    _templateUserGallery=[[SGTableTemplate alloc] initWithTableView:tableUserGallery withDelegate:self];
    _templateUserGallery.datasource=[NSMutableArray array];
    _templateUserGallery.isAllowLoadMore=false;
    
    for(int i=0;i<7;i++)
    {
        [_templateUserGallery.datasource addObject:@""];
    }
    
    imgvFirsttime.hidden=_templateUserGallery.datasource>0;
    
    [_templateUserGallery reload];
    
    _tableUserGalleryContentSize=tableUserGallery.contentSize;
    tableUserGallery.contentSize=CGSizeMake(tableUserGallery.l_v_h, tableUserGallery.l_v_w+1);
    
    _pntCenterUserGallery=CGPointZero;
    
    [tableUserGallery.panGestureRecognizer addTarget:self action:@selector(panShopUserGallery:)];
}

-(void) panShopUserGallery:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _pntPanShopUserGallery=tableUserGallery.contentOffset;
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            [self moveUserGallery];
        }
            break;
            
        default:
            break;
    }
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

    rect=promotionDetail.frame;
    rect.size.height=promotionDetailScrollContent.l_v_h;
    promotionDetail.frame=rect;
    
//    UIColor *patternColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern_promotion.png"]];
    
//    promotionDetail.backgroundColor=patternColor;
//    bottomView.backgroundColor=patternColor;
    
    //statusView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
    
    [promotionTableListPromotion l_v_setS:CGSizeZero];
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
    rect.size.width=scrollShopUser.l_v_w;
    
    //promotion
    [promotionView l_v_setH:promotionDetail.l_v_y+promotionDetail.l_v_h];
    
    //info
    [infoView l_v_setY:promotionView.l_v_h+btnNextPage.l_v_h];
    
    //gallery
    [galleryView l_v_setY:infoView.l_v_h+infoView.l_v_y];
    
    //comment
    [commentView l_v_setY:galleryView.l_v_h+galleryView.l_v_y];
    
    rect.size.height=commentView.l_v_y+commentView.l_v_h;
    
    [bottomView l_v_setY:commentView.l_v_y+commentView.l_v_h];
    
    scrollShopUser.contentSize=rect.size;
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
        return;
        CGPoint offset=promotionTableShopGallery.contentOffset;
        offset.x=scrollView.contentOffset.y/3;
        promotionTableShopGallery.contentOffset=offset;
        
        float y=btnNextPageCenter.y+scrollView.contentOffset.y;
        
        if(y-btnNextPage.l_v_h/2>promotionView.l_v_h)
            y=y-(y-promotionView.l_v_h)+btnNextPage.l_v_h/2+1;
        else
        {
            btnNextPage.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
            _buttonDirectionGoDown=true;
        }
        
        if(y<scrollView.contentOffset.y+btnNextPage.l_v_h/2)
        {
            y=scrollView.contentOffset.y+btnNextPage.l_v_h/2-2.5f;
            btnNextPage.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(180));
            _buttonDirectionGoDown=false;
        }
        
        [btnNextPage l_c_setY:y];
    }
}
-(void) moveUserGallery
{
    CGPoint pnt=tableUserGallery.contentOffset;
    
    float deltaX=_pntPanShopUserGallery.y-pnt.y;
    
    //kéo xem item tiếp theo
    if(deltaX<0)
    {
        deltaX=fabsf(deltaX);
        
        if(deltaX>[ShopUserGalleryCell height]/2)
            [self tableUserGalleryNextItem];
        else
            [self tableUserGalleryRestoreItem];
    }
    else
    {
        deltaX=fabsf(deltaX);
        
        if(deltaX>[ShopUserGalleryCell height]/2)
            [self tableUserGalleryPreviousItem:deltaX/[ShopUserGalleryCell height]];
        else
            [self tableUserGalleryRestoreItem];
    }
    
    
    _pntPanShopUserGallery=CGPointZero;
}

-(void) tableUserGalleryRestoreItem
{
    NSLog(@"tableUserGalleryRestoreItem");
    
    [tableUserGallery setContentOffset:_pntCenterUserGallery animated:true];
}

-(void) tableUserGalleryNextItem
{
    NSLog(@"tableUserGalleryNextItem");
    
    CGSize size=tableUserGallery.contentSize;
    size.height+=[ShopUserGalleryCell height];
    
    size.height=MIN(size.height, _tableUserGalleryContentSize.height+1);
    
    tableUserGallery.contentSize=size;
    
    _pntCenterUserGallery.y+=[ShopUserGalleryCell height];
    _pntCenterUserGallery.y=MIN(_pntCenterUserGallery.y, _tableUserGalleryContentSize.height-[ShopUserGalleryCell height]*3);
    
    [tableUserGallery setContentOffset:_pntCenterUserGallery animated:true];
}

-(void) tableUserGalleryPreviousItem:(NSUInteger) numOfPage
{
    NSLog(@"tableUserGalleryPreviousItem %i",numOfPage);
    
    numOfPage++;
    
    CGSize size=tableUserGallery.contentSize;
    size.height-=[ShopUserGalleryCell height]*numOfPage;
    
    size.height=MAX(size.height, tableUserGallery.l_v_w+1);
    
    tableUserGallery.contentSize=size;
    
    _pntCenterUserGallery.y-=[ShopUserGalleryCell height]*numOfPage;
    _pntCenterUserGallery.y=MAX(_pntCenterUserGallery.y, 0);
    
    [tableUserGallery setContentOffset:_pntCenterUserGallery animated:true];
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
    if(_buttonDirectionGoDown)
    {
        CGPoint pnt=infoView.l_v_o;
        pnt.y-=btnNextPage.l_v_h-5;
        [scrollShopUser setContentOffset:pnt animated:true];
    }
    else
    {
        CGPoint pnt=[promotionView convertPoint:promotionDetail.l_v_o toView:scrollShopUser];

        [scrollShopUser setContentOffset:pnt animated:true];
    }
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
        return _templateShopGallery.datasource.count==0?0:1;
    else if(tableView==promotionTableListPromotion)
        return 1;
    else if(tableView==tableUserGallery)
        return _templateUserGallery.datasource.count==0?0:1;
    else if(tableView==tableUserComment)
        return _templateUserComment.datasource.count==0?0:1;
    
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
    else if(tableView==tableUserGallery)
        return 20;
    else if(tableView==tableUserComment)
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
        
        NSString *content=@"Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet";
        
        [cell setVoucher:@"A" content:content sgp:@"5" isHighlighted:rand()%2==0];
        
        return cell;
    }
    else if(tableView==tableUserGallery)
    {
        ShopUserGalleryCell *cell=[tableUserGallery dequeueReusableCellWithIdentifier:[ShopUserGalleryCell reuseIdentifier]];
        
        [cell setLLB:[NSString stringWithFormat:@"%02i",indexPath.row]];
        
        return cell;
    }
    else if(tableView==tableUserComment)
    {
        ShopUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopUserCommentCell reuseIdentifier]];
        [cell loadWithComment:_templateUserComment.datasource[indexPath.row]];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==promotionTableShopGallery)
        return tableView.l_v_w;
    else if(tableView==promotionTableListPromotion)
        return [ShopKM1Cell heightWithContent:@"Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet"];
    else if(tableView==tableUserGallery)
        return [ShopUserGalleryCell height];
    else if(tableView==tableUserComment)
        return [ShopUserCommentCell heightWithComment:_templateUserComment.datasource[indexPath.row]];
    
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

@implementation PromotionDetailView

-(void)drawRect:(CGRect)rect
{
    if(!img)
        img=[UIImage imageNamed:@"pattern_promotion.png"];
    
    rect.origin=CGPointZero;
    
    [img drawAsPatternInRect:rect];
}

@end