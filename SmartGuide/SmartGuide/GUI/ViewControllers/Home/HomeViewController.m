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

#define NEW_FEED_DELTA_SPEED 2.1f

@interface HomeViewController ()<homeListDelegate,homeInfoCellDelegate>

@end

@implementation HomeViewController
@synthesize delegate,homeLocation;

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

    homeLocation=currentUser().coordinate;
    
    txt.placeholder=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, txt.frame.size.height)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
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
    
    if(!isVailCLLocationCoordinate2D(homeLocation))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocationChanged:) name:NOTIFICATION_USER_LOCATION_CHANGED object:nil];
        [[LocationManager shareInstance] startTrackingLocation];
    }
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
//    [self requestShopUserWithIDShop:1 idPost:1730514665];
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
    if(!isVailCLLocationCoordinate2D(homeLocation))
    {
        homeLocation=[notification.object MKCoordinateValue];
        [self resetData];
    }
    
    [[LocationManager shareInstance] stopTrackingLcoation];
}

-(void) requestNewFeed
{
    if(_operationUserHome)
    {
        [_operationUserHome clearDelegatesAndCancel];
        _operationUserHome=nil;
    }
    
    _operationUserHome=[[ASIOperationUserHome alloc] initWithPage:_page+1 userLat:homeLocation.latitude userLng:homeLocation.longitude];
    _operationUserHome.delegatePost=self;
    
    [_operationUserHome startAsynchronous];
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
        
        [_homes addObjectsFromArray:ope.homes];
        _canLoadMore=ope.homes.count==10;
        _isLoadingMore=false;
        _page++;
        
        [tableFeed reloadData];
        
        _operationUserHome=nil;
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
        
        _operationUserHome=nil;
        
        [self finishLoadData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [blackView l_v_setH:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.view.userInteractionEnabled=false;
    
    [UIView animateWithDuration:0.15f animations:^{
        [blackView l_v_setH:54];
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
        [SGData shareInstance].fScreen=[HomeViewController screenCode];
        
        [self.delegate homeControllerTouchedTextField:self];
    }];
    
    return false;
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
                return home.home9Size.height;
//                return home.imageHeight.floatValue;
                
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
    }
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

-(void)setContentOffset:(CGPoint)contentOffset
{
    _offset.x=contentOffset.x-self.contentOffset.x;
    _offset.y=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
}

-(CGPoint)offset
{
    return _offset;
}

@end