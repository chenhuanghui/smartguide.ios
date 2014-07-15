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
#import "UserNotificationController.h"
#import "UserNoticeObject.h"
#import "NotificationManager.h"
#import "ASIOperationUserHome.h"
#import "HomePromotionCell.h"
#import "HomeImagesCell.h"
#import "HomeListCell.h"
#import "HomeInfoCell.h"
#import "HomeImagesType9Cell.h"
#import "TextField.h"
#import "ScanCodeController.h"

#define HOME_TEXT_FIELD_SEARCH_MIN_Y 8.f

@interface HomeViewController ()<homeListDelegate,homeInfoCellDelegate,TextFieldRefreshDelegate,UITextFieldDelegate,ASIOperationPostDelegate,UITableViewDataSource,UITableViewDelegate,ScanCodeControllerDelegate, HomeImagesType9CellDelegate>
{
    ASIOperationUserHome *_operationUserHome;
}

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

#if DEBUG
-(void) tapTest:(UITapGestureRecognizer*) tap
{
    NSArray *ids=@[@(12),@(23),@(360)];
    
    [[[GUIManager shareInstance] rootViewController] presentShopUserWithIDShop:[ids[random_int(0, 2)] integerValue]];
}
#endif

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#if DEBUG
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTest:)];
//    [self.view makeAlphaView];
//    [self.view.alphaView addGestureRecognizer:tap];
#endif
    
    tableFeed.scrollsToTop=true;
    
    txtRefresh.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    txtRefresh.maximumWidth=232;
    txtRefresh.minimumWidth=38;
    txtRefresh.minimumY=8;
    
    [tableFeed l_v_addH:QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
    
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
    
    [[LocationManager shareInstance] startTrackingLocation];
    
    tableFeed.delegate=nil;
    float y=48;
    y+=4;//align
    
    [txtRefresh l_v_setY:y];
    
    y+=txtRefresh.l_v_h;
    y+=4;//align
    
    UIEdgeInsets contentInset=tableFeed.contentInset;
    contentInset.top=y;
    tableFeed.contentInset=contentInset;
    tableFeed.scrollIndicatorInsets=contentInset;
    tableFeed.delegate=self;
    
    _scrollDistanceHeight=txtRefresh.l_v_y-HOME_TEXT_FIELD_SEARCH_MIN_Y;
    
    [self displayNotification];
}

-(void)textFieldRefreshFinished:(TextField *)txt
{
    _homes=[[NSMutableArray alloc] initWithArray:_homesAPI];
    _homesAPI=nil;
    _isLoadingMore=false;
    _canLoadMore=_homes.count>=10;
    _page++;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        tableFeed.alpha=1;
    }];
    
    [tableFeed reloadData];
    
    [tableFeed setContentOffset:CGPointMake(0, -48) animated:true];
}

-(void)textFieldNeedRefresh:(TextField *)txt
{
    if(_isLoadingMore)
    {
        [_operationUserHome clearDelegatesAndCancel];
        _operationUserHome=nil;
    }
    
    _page=-1;
    
    [self requestNewFeed];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        tableFeed.alpha=0.1f;
    }];
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_TOTAL_NOTIFICATION_CHANGED,NOTIFICATION_USER_LOCATION_CHANGED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_TOTAL_NOTIFICATION_CHANGED])
        [self displayNotification];
}

-(void) displayNotification
{
#if BUILD_MODE==1
    
    NSString *numNoti=[NotificationManager shareInstance].numOfNotification;
    
    if(currentUser().enumDataMode!=USER_DATA_FULL)
        numNoti=@"";
    
    [btnNumOfNotification setTitle:numNoti forState:UIControlStateNormal];
    btnNumOfNotification.hidden=numNoti.length==0 || [NotificationManager shareInstance].totalNotification.integerValue==0;
    
#else
    
    NSString *numNoti=[NotificationManager shareInstance].numOfNotification;
    
    [btnNumOfNotification setTitle:numNoti forState:UIControlStateNormal];
    btnNumOfNotification.hidden=numNoti.length==0 || [NotificationManager shareInstance].totalNotification.integerValue==0;
    
#endif
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
        
        [txtRefresh tableDidScroll:tableFeed];
        
        if(CGRectIsEmpty(_logoFrame))
            _logoFrame=imgvLogo.frame;
        
        float y=tableFeed.offsetYWithInsetTop;
        float perY=y/_scrollDistanceHeight;
        
        float logoY=_logoFrame.origin.y-y/4;
        logoY=MIN(_logoFrame.origin.y,logoY);
        
        [imgvLogo l_v_setY:logoY];
        imgvLogo.alpha=1-perY*2.f;
        float scaleLogo=MAX(0.1f,1-perY);
        scaleLogo=MIN(1.2f,scaleLogo);
        imgvLogo.transform=CGAffineTransformMakeScale(scaleLogo, scaleLogo);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [txtRefresh tableDidEndDecelerating:tableFeed];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [txtRefresh tableDidEndDragging:tableFeed willDecelerate:decelerate];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [txtRefresh tableWillBeginDragging:tableFeed];
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
    }
    else
    {
        [SGData shareInstance].isShowedNotice=@(true);
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_USER_NOTICE_FINISHED object:nil];
        _isRegisterNotificationUserNotice=false;
    }
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
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
    
    [self reloadData];
}

-(void) requestNewFeed
{
    if(_operationUserHome)
    {
        [_operationUserHome clearDelegatesAndCancel];
        _operationUserHome=nil;
    }
    
    _operationUserHome=[[ASIOperationUserHome alloc] initWithPage:_page+1 userLat:HOME_LOCATION().latitude userLng:HOME_LOCATION().longitude];
    _operationUserHome.delegate=self;
    
    [_operationUserHome addToQueue];
}

-(void) reloadData
{
    _page=-1;
    _isLoadingMore=false;
    _canLoadMore=true;
    
    [self requestNewFeed];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        [self removeLoading];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HOME_FINISHED_LOAD object:nil];
        
        ASIOperationUserHome *ope=(ASIOperationUserHome*) operation;
        
        if(txtRefresh.refreshState==TEXTFIELD_REFRESH_STATE_REFRESHING)
        {
            _homesAPI=[[NSMutableArray alloc] initWithArray:ope.homes];
            [txtRefresh markRefreshDone:tableFeed];
        }
        else if(txtRefresh.refreshState==TEXTFIELD_REFRESH_STATE_NORMAL)
        {
            [_homes addObjectsFromArray:ope.homes];
            _canLoadMore=ope.homes.count>=10;
            _isLoadingMore=false;
            _page++;
            
            [tableFeed reloadData];
        }
        
        _operationUserHome=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        [self removeLoading];
        _operationUserHome=nil;
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
    
    if(tableFeed.l_co_y<-48)
    {
        tableFeed.userInteractionEnabled=false;
        _isTouchedTextField=true;
        [tableFeed l_co_setY:-48 animate:true];
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
                return [HomeListCell heightWithHome:home];
                
            case USER_HOME_TYPE_6:
                return [HomeInfoCell heightWithHome6:home.home6];
                
            case USER_HOME_TYPE_8:
                return [HomePromotionCell heightWithHome8:home.home8];
                
            case USER_HOME_TYPE_9:
                return home.home9Size.height+15;
                
            case USER_HOME_TYPE_UNKNOW:
                DLOG_DEBUG(@"USER_HOME_TYPE_UNKNOW heightForRowAtIndexPath");
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
                
            case USER_HOME_TYPE_6:
            {
                HomeInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[HomeInfoCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome6:home.home6];
                
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
                
                cell.delegate=self;
                [cell loadWithHome9:home];
                
                return cell;
            }
                break;
                
            case USER_HOME_TYPE_UNKNOW:
                DLOG_DEBUG(@"USER_HOME_TYPE_UNKNOW cellForRowAtIndexPath");
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
                
            case USER_HOME_TYPE_6:
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
    }
}

-(void)homeInfoCellTouchedGoTo:(id)home
{
    if([home isKindOfClass:[UserHome6 class]])
    {
        UserHome6 *home6=home;
        
        [self requestShopUserWithIDShop:home6.idShop.integerValue idPost:home6.home.idPost.integerValue];
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
        [self showScanCodeWithDelegate:self animationType:SCANCODE_ANIMATION_TOP];
    else
        [self showScanCodeWithDelegate:self animationType:SCANCODE_ANIMATION_TOP_BOT];
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
    
    if(currentUser().enumDataMode!=USER_DATA_FULL)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^{
            [SGData shareInstance].fScreen=[HomeViewController screenCode];
        } onCancelled:nil onLogined:^(bool isLogined)
        {
            if(isLogined)
                [self.navigationController pushViewController:[UserNotificationController new] animated:true];
        }];
    }
    else
    {
        [txtRefresh markTableDidEndScroll:tableFeed];
        [self.navigationController pushViewController:[UserNotificationController new] animated:true];
    }
}

-(void)homeImagesType9Cell:(HomeImagesType9Cell *)cell touchedHome:(UserHome *)home
{
    if(home.enumType==USER_HOME_TYPE_9)
    {
        if([home.idShops hasData])
            [self.delegate homeControllerTouched:self idShops:home.idShops];
        else if([home.idPlacelist hasData])
            [self.delegate homeControllerTouched:self idPlacelist:home.idPlacelist.integerValue];
    }
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

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    [super setUserInteractionEnabled:userInteractionEnabled];
}

@end