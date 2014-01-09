//
//  ShopCategoriesViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "HomeViewController.h"
#import "GUIManager.h"
#import "StoreShopInfoViewController.h"

#define NEW_FEED_DELTA_SPEED 2.1f

@interface HomeViewController ()<homeListDelegate,homeInfoCellDelegate>

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [UserHome markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    [tableFeed l_v_addH:QRCODE_SMALL_HEIGHT*NEW_FEED_DELTA_SPEED];
    
    [self storeRect];
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txt.l_v_h)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    [tableFeed registerNib:[UINib nibWithNibName:[HomePromotionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomePromotionCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeImagesCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeImagesCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeListCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[HomeInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[HomeInfoCell reuseIdentifier]];
    
    _page=1;
//    _page=1;
    _homes=[NSMutableArray array];
    _isLoadingMore=false;
    _canLoadMore=true;
    
    [self requestNewFeed];
    displayLoadingView.userInteractionEnabled=true;
    [displayLoadingView showLoading];
}

-(void) requestNewFeed
{
    if(_operationUserHome)
    {
        [_operationUserHome cancel];
        _operationUserHome=nil;
    }
    
    _operationUserHome=[[ASIOperationUserHome alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng()];
    _operationUserHome.delegatePost=self;
    
    [_operationUserHome startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        if(displayLoadingView)
        {
            [displayLoadingView removeLoading];
            [displayLoadingView removeFromSuperview];
        }
        
        ASIOperationUserHome *ope=(ASIOperationUserHome*) operation;
        
        [_homes addObjectsFromArray:ope.homes];
        _canLoadMore=ope.homes.count==10;
        _isLoadingMore=false;
        _page++;
        
        [tableFeed reloadData];
        
        _operationUserHome=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        [self.view removeLoading];
        
        ASIOperationShopUser *ope=(ASIOperationShopUser*) operation;
        
        [[GUIManager shareInstance] presentShopUserWithShopUser:ope.shop];
        
        _operationShopUser=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserHome class]])
    {
        if(displayLoadingView)
        {
            [displayLoadingView removeLoading];
            [displayLoadingView removeFromSuperview];
        }
        
        _operationUserHome=nil;
    }
    else if([operation isKindOfClass:[ASIOperationShopUser class]])
    {
        [self.view removeLoading];
        
        _operationShopUser=nil;
    }
}

-(NSArray *)registerNotifications
{
    return @[UIApplicationDidBecomeActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.delegate homeControllerTouchedTextField:self];
    
    return false;
}

-(IBAction) btnNavigationTouchedUpInside:(id)sender
{
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
        return _homes.count;
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFeed)
    {
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
        UserHome *home=_homes[indexPath.row];
        
        if(_canLoadMore)
        {
            if(!_isLoadingMore)
            {
                if(indexPath.row==_homes.count-1)
                {
                    _isLoadingMore=true;
                    
                    [self requestNewFeed];
                }
            }
        }
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
                    [self requestShopUserWithIDShop:home.home1.idShop.integerValue];
                    
                    [self.view showLoading];
                    return;
                }
                
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
            {
                [[GUIManager shareInstance] presentShopUserWithHome8:home.home8];
            }
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
            [self.delegate homeControllerTouchedPlacelist:self home3:cell.currentHome];
        }
        else if([cell.currentHome isKindOfClass:[UserHome4 class]])
        {
            UserHome4 *home=cell.currentHome;
            [self requestShopUserWithIDShop:home.idShop.integerValue];
            
            [self.view showLoading];
        }
        else if([cell.currentHome isKindOfClass:[UserHome5 class]])
        {
            UserHome5 *home=cell.currentHome;
            
            [[GUIManager shareInstance] showStoreWithStore:home.store];
        }
    }
}

-(void)homeInfoCellTouchedGoTo:(id)home
{
    if([home isKindOfClass:[UserHome6 class]])
    {
        UserHome6 *home6=home;
        
        [self requestShopUserWithIDShop:home6.idShop.integerValue];
        
        [self.view showLoading];
    }
    else if([home isKindOfClass:[UserHome7 class]])
    {
        UserHome7 *home7=home;
        [[GUIManager shareInstance] showStoreWithStore:home7.store];
    }
}

-(void) requestShopUserWithIDShop:(int) idShop
{
    _operationShopUser=[[ASIOperationShopUser alloc] initWithIDShop:idShop userLat:userLat() userLng:userLng()];
    _operationShopUser.delegatePost=self;
    
    [_operationShopUser startAsynchronous];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    return;
    [Flags setIsUserReadTutorialPlace:rand()%2==0];
    [Flags setIsUserReadTutorialShopList:rand()%2==0];
    [Flags setIsUserReadTutorialStoreList:rand()%2==0];
    
    NSMutableArray *array=[NSMutableArray array];
    for(int i=0;i<[tableFeed numberOfRowsInSection:0];i++)
    {
        NSIndexPath *ip=[NSIndexPath indexPathForRow:i inSection:0];
        
        UITableViewCell *cell=[tableFeed cellForRowAtIndexPath:ip];
        
        if([cell isKindOfClass:[HomeListCell class]])
        {
            [array addObject:ip];
        }
    }
    
    if(array.count>0)
        [tableFeed reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
}

@end
