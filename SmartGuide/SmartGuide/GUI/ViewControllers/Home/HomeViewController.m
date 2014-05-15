//
//  ShopCategoriesViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeViewController.h"
#import "GUIManager.h"
#import "LoadingMoreCell.h"
#import "LocationManager.h"
#import "UserNotificationViewController.h"
#import "UserNoticeObject.h"
#import "UserNoticeView.h"
#import "NotificationManager.h"

#define NEW_FEED_DELTA_SPEED 2.1f
#define HOME_TEXT_FIELD_SEARCH_MIN_Y 8.f

@interface HomeViewController ()<homeListDelegate,homeInfoCellDelegate,UserNoticeDelegate>

@end

@implementation HomeViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"HomeViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _qrFrame=qrView.frame;
    _blurBottomFrame=blurBottom.frame;
    _buttonScanBigFrame=btnScanBig.frame;
    _buttonScanSmallFrame=btnScanSmall.frame;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SGData shareInstance].fScreen=[HomeViewController screenCode];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _isUserReleaseTouched=true;
    _isCanRefresh=TRUE;
    _isAPIFinished=false;
    _startYAngle=-999;
    
    txt.hiddenClearButton=true;
    txt.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    
    [tableFeed l_v_addH:QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
    
    [UserHome markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    [tableFeed registerNib:[UINib nibWithNibName:[HomePromotionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomePromotionCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeImagesCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeImagesCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeListCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeInfoCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeImagesType9Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeImagesType9Cell reuseIdentifier]];
    [tableFeed registerLoadingMoreCell];
    
    _page=-1;
    _homes=[NSMutableArray array];
    _isLoadingMore=false;
    _canLoadMore=true;
    
    [self requestNewFeed];
    
    [self showLoading];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocationChanged:) name:NOTIFICATION_USER_LOCATION_CHANGED object:nil];
    [[LocationManager shareInstance] startTrackingLocation];
    
    tableFeed.delegate=nil;
    float y=48;
    //    y+=4;//align
    
    [txt l_v_setY:y];
    _txtPerWidth=TEXT_FIELD_SEARCH_DEFAULT_WIDTH/txt.l_v_w;
    
    y+=txt.l_v_h;
    y+=4;//align

    tableFeed.contentInset=UIEdgeInsetsMake(y, 0, 30, 0);
    tableFeed.delegate=self;
    
    _scrollDistanceHeight=txt.l_v_y-HOME_TEXT_FIELD_SEARCH_MIN_Y;
    [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
    
    [self displayNotification];
    
    if([NotificationManager shareInstance].launchNotification)
    {
        NotificationInfo *obj=[[NotificationManager shareInstance].launchNotification copy];
        [NotificationManager shareInstance].launchNotification=nil;
        
        [[GUIManager shareInstance].rootViewController processNotificationInfo:obj];
    }
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_TOTAL_NOTIFICATION_CHANGED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED])
        [self displayNotification];
}

-(void) displayNotification
{
    NSString *numNoti=[NotificationManager shareInstance].numOfNotification;
    [btnNumOfNotification setTitle:numNoti forState:UIControlStateNormal];
    btnNumOfNotification.hidden=numNoti.length==0 || [NotificationManager shareInstance].totalNotification.integerValue==0;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_isTrackingTouch)
    {
        _isUserReleaseTouched=true;
        [self callReloadTable];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate && _isTrackingTouch)
    {
        _isUserReleaseTouched=true;
        [self callReloadTable];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isUserReleaseTouched=false;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==tableFeed)
    {        
        if(tableFeed.l_co_y+tableFeed.contentInset.top>100)
        {
            [UIView animateWithDuration:0.3f animations:^{
                [qrView l_v_setY:_qrFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
                [blurBottom l_v_setY:_blurBottomFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
                
                btnScanSmall.alpha=1;
                btnScanBig.alpha=0;
                btnScanBig.frame= _buttonScanSmallFrame;
                btnScanSmall.frame=_buttonScanBigFrame;
            } completion:^(BOOL finished) {
                btnScanBig.userInteractionEnabled=false;
                btnScanSmall.userInteractionEnabled=true;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3f animations:^{
                [qrView l_v_setY:_qrFrame.origin.y];
                [blurBottom l_v_setY:_blurBottomFrame.origin.y];
                
                btnScanBig.alpha=1;
                btnScanSmall.alpha=0;
                btnScanBig.frame=_buttonScanBigFrame;
                btnScanSmall.frame=_buttonScanSmallFrame;
            } completion:^(BOOL finished) {
                btnScanBig.userInteractionEnabled=true;
                btnScanSmall.userInteractionEnabled=false;
            }];
        }
        
        if(CGRectIsEmpty(_textFieldFrame))
            _textFieldFrame=txt.frame;
        if(CGRectIsEmpty(_logoFrame))
            _logoFrame=imgvLogo.frame;
        
        float y=tableFeed.offsetYWithInsetTop;
        float perY=y/_scrollDistanceHeight;
        
        float txtY=_textFieldFrame.origin.y-y;
        txtY=MAX(8,txtY);
        
        if(txtY>_textFieldFrame.origin.y)
            txtY=_textFieldFrame.origin.y;
        
        [txt l_v_setY:txtY];
        
        if(txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING || txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_DONE)
        {
            CGRect rect=txt.frame;
            rect.size.width=TEXT_FIELD_SEARCH_MIN_WIDTH;
            rect.origin.x=(self.l_v_w-rect.size.width)/2;
            txt.frame=rect;
        }
        else
        {
            if(y>0)
            {
                if(y<_scrollDistanceHeight)
                {
                    float w=_textFieldFrame.size.width+perY*(TEXT_FIELD_SEARCH_DEFAULT_WIDTH-_textFieldFrame.size.width);
                    [txt l_v_setW:w];
                    [txt l_v_setX:_textFieldFrame.origin.x-(perY*(TEXT_FIELD_SEARCH_DEFAULT_WIDTH-_textFieldFrame.size.width))/2+4.f*perY];
                }
                else
                {
                    txt.frame=CGRectMake((self.l_v_w-TEXT_FIELD_SEARCH_DEFAULT_WIDTH)/2+MIN(4.f*perY,4), HOME_TEXT_FIELD_SEARCH_MIN_Y, TEXT_FIELD_SEARCH_DEFAULT_WIDTH, _textFieldFrame.size.height);
                }
            }
            else
            {
                CGRect rect=_textFieldFrame;
                
                float yy=rect.size.width*perY;
                yy*=1.5f;
                
                rect.size.width+=yy;
                
                if(rect.size.width<TEXT_FIELD_SEARCH_MIN_WIDTH)
                {
                    rect.size.width=TEXT_FIELD_SEARCH_MIN_WIDTH;
                    rect.origin.x=(self.l_v_w-rect.size.width)/2;
                    
                    if(_startYAngle==-999)
                        _startYAngle=y;
                    
                    switch (txt.refreshState) {
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING:
                            break;
                            
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH:
                        {
                            float angle=180-((perY+0.5f)*180.f)*3.5f;
                            angle=DEGREES_TO_RADIANS(angle);
                            
                            [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_ROTATE animated:false completed:nil];
                            
                            [txt setAngle:angle];
                        }
                            break;
                            
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_ROTATE:
                        {
                            float angle=180-((perY+0.5f)*180.f)*3.5f;
                            angle=DEGREES_TO_RADIANS(angle);
                            
                            [txt setAngle:angle];
                            
                            if(angle>M_PI*3)
                            {
                                angle=M_PI*3;
                                
                                if(_isCanRefresh)
                                {
                                    _isTrackingTouch=true;
                                    _isCanRefresh=FALSE;
                                    tableFeed.maxY=-tableFeed.contentInset.top;
                                    [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING animated:true completed:nil];
                                    [[LocationManager shareInstance] startTrackingLocation];
                                    tableFeed.userInteractionEnabled=false;
                                    
                                    [UIView animateWithDuration:0.3f animations:^{
                                        tableFeed.alpha=0.1f;
                                    }];
                                }
                            }
                        }
                            break;
                            
                        case TEXT_FIELD_SEARCH_REFRESH_STATE_DONE:
                            
                            break;
                    }
                }
                else
                {
                    rect.origin.x-=yy/2;
                    rect.size.width=MAX(TEXT_FIELD_SEARCH_MIN_WIDTH,rect.size.width);
                    
                    [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
                }
                
                txt.frame=rect;
            }
        }
        
        if(txt.l_v_w<95.f)
            txt.text=@"";
        else
            txt.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
        
        float logoY=_logoFrame.origin.y-y/4;
        logoY=MIN(_logoFrame.origin.y,logoY);
        
        [imgvLogo l_v_setY:logoY];
        imgvLogo.alpha=1-perY*2.f;
        float scaleLogo=MAX(0.1f,1-perY);
        scaleLogo=MIN(1.2f,scaleLogo);
        imgvLogo.transform=CGAffineTransformMakeScale(scaleLogo, scaleLogo);
    }
}

-(void) receiveUserNotice:(NSNotification*) notification
{
    if([SGData shareInstance].userNotice.length>0)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
        _isRegisterNotificationUserNotice=false;

        [AlertView showWithTitle:@"Thông báo" withMessage:[SGData shareInstance].userNotice withLeftTitle:@"Thoát" withRightTitle:nil onOK:^{
            [SGData shareInstance].isShowedNotice=@(true);
        } onCancel:nil];
        
        return;
        UserNoticeView *notice=[[UserNoticeView alloc] initWithNotice:[SGData shareInstance].userNotice];
        
        [notice showUserNoticeWithView:self.view delegate:self];
    }
}

-(void)userNoticeDidShowed:(UserNoticeView *)userNoticeView
{
    [SGData shareInstance].isShowedNotice=@(true);
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    //    [self requestShopUserWithIDShop:8 idPost:1730514665];
    if(![[SGData shareInstance].isShowedNotice boolValue])
    {
        _isRegisterNotificationUserNotice=true;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserNotice:) name:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
        
        [UserNoticeObject requestUserNotice];
    }
}

-(void) showLoading
{
    displayLoadingView.userInteractionEnabled=true;
    [displayLoadingView showLoading];
    displayLoadingView.loadingView.backgroundView.backgroundColor=self.view.backgroundColor;
}

-(void) removeLoading
{
    [displayLoadingView removeLoading];
    displayLoadingView.userInteractionEnabled=false;
}

-(void) resetData
{
    [self showLoading];
    
    _page=-1;
    _homes=[NSMutableArray array];
    _isLoadingMore=false;
    _canLoadMore=true;
    
    [self requestNewFeed];
}

-(void) userLocationChanged:(NSNotification*) notification
{
    [[LocationManager shareInstance] stopTrackingLcoation];
    
    if(!tableFeed.userInteractionEnabled && txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
    {
        [self reloadData];
    }
}

-(void) requestNewFeed
{
    if(_operationUserHome)
    {
        [_operationUserHome clearDelegatesAndCancel];
        _operationUserHome=nil;
    }
    
    _operationUserHome=[[ASIOperationUserHome alloc] initWithPage:_page+1 userLat:HOME_LOCATION().latitude userLng:HOME_LOCATION().longitude];
    _operationUserHome.delegatePost=self;
    
    [_operationUserHome startAsynchronous];
}

-(void) reloadData
{
    _page=-1;
    tableFeed.userInteractionEnabled=false;
    _isLoadingMore=false;
    _canLoadMore=true;
    _isAPIFinished=false;
    
    [self requestNewFeed];
}

-(void) finishLoadData
{
    if(!_isFinishedLoadData)
    {
        _isFinishedLoadData=true;
        
        [self.delegate homeControllerFinishedLoad:self];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        [self removeLoading];
        
        [self finishLoadData];
        
        ASIOperationUserHome *ope=(ASIOperationUserHome*) operation;
        
        if(txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
        {
            _homes=[NSMutableArray new];
            
            __weak HomeViewController *wSelf=self;
            [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_DONE animated:true completed:^(enum TEXT_FIELD_SEARCH_REFRESH_STATE state) {
                if(wSelf)
                    [wSelf callReloadTable];
            }];
        }
        
        [_homes addObjectsFromArray:ope.homes];
        _canLoadMore=ope.homes.count==10;
        _isLoadingMore=false;
        _page++;
        _isAPIFinished=true;
        
        [self callReloadTable];
        
        _operationUserHome=nil;
    }
}

-(void) callReloadTable
{
    if(_isUserReleaseTouched && _isAPIFinished && txt.refreshState!=TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
    {
        _isTrackingTouch=false;
        _isCanRefresh=true;
        tableFeed.maxY=-1;
        tableFeed.userInteractionEnabled=true;
        
        [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
        [UIView animateWithDuration:0.3f animations:^{
            [self scrollViewDidScroll:tableFeed];
        }];
        
        [UIView animateWithDuration:0.3f animations:^{
            tableFeed.alpha=1;
        }];
        
        [tableFeed reloadData];
        
        return;
        
        UIImage *img=[tableFeed captureView];
        
        UIImageView *imgv=[[UIImageView alloc] initWithImage:img];
        imgv.frame=tableFeed.frame;
        [imgv l_v_addY:tableFeed.contentInset.top];
        
        [self.view insertSubview:imgv aboveSubview:tableFeed];
        tableFeed.alpha=0;
        [tableFeed reloadData];
        
        [UIView animateWithDuration:0.3f animations:^{
            imgv.alpha=0;
            tableFeed.alpha=1;
        } completion:^(BOOL finished) {
            
            [imgv removeFromSuperview];
        }];
        
        [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_SEARCH animated:false completed:nil];
        [UIView animateWithDuration:0.3f animations:^{
            [self scrollViewDidScroll:tableFeed];
        }];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        if(displayLoadingView)
        {
            [displayLoadingView removeFromSuperview];
            displayLoadingView=nil;
        }
        
        if(txt.refreshState==TEXT_FIELD_SEARCH_REFRESH_STATE_REFRESHING)
        {
            _homes=[NSMutableArray new];
            
            __weak HomeViewController *wSelf=self;
            [txt setRefreshState:TEXT_FIELD_SEARCH_REFRESH_STATE_DONE animated:true completed:^(enum TEXT_FIELD_SEARCH_REFRESH_STATE state) {
                if(wSelf)
                    [wSelf callReloadTable];
            }];
        }
        
        _isAPIFinished=true;
        
        [self callReloadTable];
        
        _operationUserHome=nil;
        
        [self finishLoadData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.view.userInteractionEnabled=true;
    [SGData shareInstance].fScreen=[HomeViewController screenCode];
    
    if(tableFeed.l_co_y<-54)
    {
        tableFeed.userInteractionEnabled=false;
        _isTouchedTextField=true;
        [tableFeed l_co_setY:-54 animate:true];
    }
    else
        [self.delegate homeControllerTouchedTextField:self];
    
    return false;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if(_isTouchedTextField)
    {
        _isTouchedTextField=false;
        tableFeed.userInteractionEnabled=true;
        [self.delegate homeControllerTouchedTextField:self];
    }
}

-(IBAction) btnNavigationTouchedUpInside:(id)sender
{
    [SGData shareInstance].fScreen=[HomeViewController screenCode];
    [self.delegate homeControllerTouchedNavigation:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==tableFeed)
        return _homes.count==0?0:1;
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableFeed)
        return _homes.count+(_canLoadMore?1:0);
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFeed)
    {
        if(_canLoadMore && indexPath.row==_homes.count)
        {
            return 80;
        }
        
        UserHome *home=_homes[indexPath.row];
        switch (home.enumType) {
            case USER_HOME_TYPE_1:
                return [HomePromotionCell heightWithHome1:home.home1];
                
            case USER_HOME_TYPE_2:
                return [HomeImagesCell height];
                
            case USER_HOME_TYPE_3:
            case USER_HOME_TYPE_4:
            case USER_HOME_TYPE_5:
                return [HomeListCell heightWithHome:home];
                
            case USER_HOME_TYPE_6:
                return [HomeInfoCell heightWithHome6:home.home6];
                
            case USER_HOME_TYPE_7:
                return [HomeInfoCell heightWithHome7:home.home7];
                
            case USER_HOME_TYPE_8:
                return [HomePromotionCell heightWithHome8:home.home8];
                
            case USER_HOME_TYPE_9:
                return home.home9Size.height+15;
                
            case USER_HOME_TYPE_UNKNOW:
                NSLog(@"USER_HOME_TYPE_UNKNOW heightForRowAtIndexPath");
                return 0;
        }
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFeed)
    {
        if(_canLoadMore && indexPath.row==_homes.count)
        {
            if(!_isLoadingMore)
            {
                _isLoadingMore=true;
                [self requestNewFeed];
            }
            
            return [tableView loadingMoreCell];
        }
        
        UserHome *home=_homes[indexPath.row];
        
        switch (home.enumType) {
            case USER_HOME_TYPE_1:
            {
                HomePromotionCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomePromotionCell reuseIdentifier]];
                
                [cell loadWithHome1:home.home1];
                
                return cell;
            }
                
            case USER_HOME_TYPE_2:
            {
                HomeImagesCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeImagesCell reuseIdentifier]];
                
                [cell loadWithImages:[home.home2Objects valueForKeyPath:UserHome2_Image]];
                
                return cell;
            }
                
            case USER_HOME_TYPE_3:
            {
                HomeListCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeListCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome3:home];
                
                return cell;
            }
            case USER_HOME_TYPE_4:
            {
                HomeListCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeListCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome4:home];
                
                return cell;
            }
            case USER_HOME_TYPE_5:
            {
                HomeListCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeListCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome5:home];
                
                return cell;
            }
                
            case USER_HOME_TYPE_6:
            {
                HomeInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeInfoCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome6:home.home6];
                
                return cell;
            }
                
            case USER_HOME_TYPE_7:
            {
                HomeInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeInfoCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome7:home.home7];
                
                return cell;
            }
                
            case USER_HOME_TYPE_8:
            {
                HomePromotionCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomePromotionCell reuseIdentifier]];
                
                [cell loadWithHome8:home.home8];
                
                return cell;
            }
                
            case USER_HOME_TYPE_9:
            {
                HomeImagesType9Cell *cell=[tableFeed dequeueReusableCellWithIdentifier:[HomeImagesType9Cell reuseIdentifier]];
                
                [cell loadWithHome9:home];
                
                return cell;
            }
                break;
                
            case USER_HOME_TYPE_UNKNOW:
                NSLog(@"USER_HOME_TYPE_UNKNOW cellForRowAtIndexPath");
                break;
        }
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFeed)
    {
        UserHome *home=_homes[indexPath.row];
        switch (home.enumType) {
            case USER_HOME_TYPE_1:
            {
                // Nếu shop list chỉ có 1 idShop
                if(home.home1.shopList.length>0 && ![home.home1.shopList isContainString:@","])
                {
                    [self requestShopUserWithIDShop:home.home1.idShop.integerValue idPost:home.idPost.integerValue];
                    return;
                }
                
                [SGData shareInstance].fScreen=[HomeViewController screenCode];
                [[SGData shareInstance].fData setObject:home.idPost forKey:@"idPost"];
                [self.delegate homeControllerTouchedHome1:self home1:home.home1];
            }
                break;
                
            case USER_HOME_TYPE_2:
            {
                //Nothing do
            }
                break;
                
            case USER_HOME_TYPE_3:
            {
                // using  homeListTouched
            }
                break;
                
            case USER_HOME_TYPE_4:
            {
                // using homeListTouched
            }
                break;
                
            case USER_HOME_TYPE_5:
            {
                // using homeListTouched
            }
                break;
                
            case USER_HOME_TYPE_6:
            {
                // using homeInfoCellTouchedGoTo
            }
                break;
                
            case USER_HOME_TYPE_7:
            {
                // using homeInfoCellTouchedGoTo
            }
                break;
                
            case USER_HOME_TYPE_8:
                [self.delegate homeControllerTouchedHome8:self home8:home.home8];
                break;
                
            case USER_HOME_TYPE_9:
                break;
                
            case USER_HOME_TYPE_UNKNOW:
                break;
        }
    }
}

-(void)homeListTouched:(HomeListCell *)cell
{
    if(cell.currentHome)
    {
        if([cell.currentHome isKindOfClass:[UserHome3 class]])
        {
            UserHome3 *home3=cell.currentHome;
            [SGData shareInstance].fScreen=[HomeViewController screenCode];
            [[SGData shareInstance].fData setObject:home3.home.idPost forKey:@"idPost"];
            
            [self.delegate homeControllerTouchedPlacelist:self home3:cell.currentHome];
        }
        else if([cell.currentHome isKindOfClass:[UserHome4 class]])
        {
            UserHome4 *home=cell.currentHome;
            [self requestShopUserWithIDShop:home.idShop.integerValue idPost:home.home.idPost.integerValue];
        }
        else if([cell.currentHome isKindOfClass:[UserHome5 class]])
        {
            UserHome5 *home=cell.currentHome;
            [self.delegate homeControllerTouchedStore:self store:home.store];
        }
    }
}

-(void)homeInfoCellTouchedGoTo:(id)home
{
    if([home isKindOfClass:[UserHome6 class]])
    {
        UserHome6 *home6=home;
        
        [self requestShopUserWithIDShop:home6.idShop.integerValue idPost:home6.home.idPost.integerValue];
    }
    else if([home isKindOfClass:[UserHome7 class]])
    {
        UserHome7 *home7=home;
        [self.delegate homeControllerTouchedStore:self store:home7.store];
    }
}

-(void) requestShopUserWithIDShop:(int) idShop idPost:(int) idPost
{
    [SGData shareInstance].fScreen=[HomeViewController screenCode];
    [[SGData shareInstance].fData setObject:@(idPost) forKey:@"idPost"];
    
    [self.delegate homeControllerTouchedIDShop:self idShop:idShop];
}

- (IBAction)btnShowQRCodeTouchUpInside:(id)sender {
    if(sender==btnScanBig)
        [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP screenCode:[HomeViewController screenCode]];
    else
        [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[HomeViewController screenCode]];
}

-(void)qrcodeControllerRequestClose:(QRCodeViewController *)controller
{
    
}

+(NSString *)screenCode
{
    return SCREEN_CODE_HOME;
}

-(void)dealloc
{
    if(_operationUserHome)
    {
        [_operationUserHome clearDelegatesAndCancel];
        _operationUserHome=nil;
    }
    
    if(_isRegisterNotificationUserNotice)
    {
        _isRegisterNotificationUserNotice=false;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_USER_LOCATION_CHANGED object:nil];
}

- (IBAction)btnNotificationTouchUpInside:(id)sender {
    [self.navigationController pushViewController:[UserNotificationViewController new] animated:true];
}

@end

@implementation HomeBGView

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"pattern_home.png"] drawAsPatternInRect:rect];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
}

@end

@implementation TableHome

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.maxY=-1;
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(self.maxY!=-1)
    {
        if(contentOffset.y>self.maxY)
            contentOffset.y=self.maxY;
    }
    
    [super setContentOffset:contentOffset];
}

@end