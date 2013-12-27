//
//  ShopCategoriesViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedViewController.h"
#import "GUIManager.h"
#import "StoreShopInfoViewController.h"

#define NEW_FEED_DELTA_SPEED 2.1f

@interface NewFeedViewController ()<NewFeedListDelegate,NewFeedInfoCellDelegate>

@end

@implementation NewFeedViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"NewFeedViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) storeRect
{
    _adsFrame=adsView.frame;
    _qrFrame=qrView.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [tableFeed l_v_addH:QRCODE_SMALL_HEIGHT*NEW_FEED_DELTA_SPEED];
    
    [self storeRect];
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txt.l_v_h)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    [tableFeed registerNib:[UINib nibWithNibName:[NewFeedPromotionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedPromotionCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[NewFeedImagesCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedImagesCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[NewFeedListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedListCell reuseIdentifier]];
    [tableFeed registerNib:[UINib nibWithNibName:[NewFeedInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedInfoCell reuseIdentifier]];
    
    _page=-1;
    _homes=[NSMutableArray array];
    _isLoadingMore=false;
    _canLoadMore=true;
    
    [UserHome markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    [self requestNewFeed];
    displayLoadingView.userInteractionEnabled=true;
    [displayLoadingView showLoading];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==tableFeed)
    {
        float destY=_qrFrame.origin.y+QRCODE_SMALL_HEIGHT;
        float speed=6;
        float v=tableFeed.l_co_y/speed;

        if(tableFeed.l_co_y>0)
        {
            if(_qrFrame.origin.y+v<destY)
            {
                [qrView l_v_setY:_qrFrame.origin.y+v];
                [adsView l_v_setY:_adsFrame.origin.y+v*NEW_FEED_DELTA_SPEED];
            }
            else
            {
                [qrView l_v_setY:destY];
                [adsView l_v_setY:_adsFrame.origin.y+QRCODE_SMALL_HEIGHT*NEW_FEED_DELTA_SPEED];
            }
        }
        else
        {
            [qrView l_v_setY:_qrFrame.origin.y];
            [adsView l_v_setY:_adsFrame.origin.y];
        }
    }
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
    [self.delegate newFeedControllerTouchedTextField:self];
    
    return false;
}

-(IBAction) btnNavigationTouchedUpInside:(id)sender
{
    [self.delegate newFeedControllerTouchedNavigation:self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==tableFeed)
        return _homes.count==0?0:1;
    else if(tableView==tableAds)
        return _ads.count==0?0:1;
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableFeed)
        return _homes.count;
    else if(tableView==tableAds)
        return _ads.count;
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFeed)
    {
        UserHome *home=_homes[indexPath.row];
        switch (home.enumType) {
            case USER_HOME_TYPE_1:
                return [NewFeedPromotionCell heightWithHome1:home.home1];
                
            case USER_HOME_TYPE_2:
                return [NewFeedImagesCell height];
                
            case USER_HOME_TYPE_3:
            case USER_HOME_TYPE_4:
            case USER_HOME_TYPE_5:
                return [NewFeedListCell heightWithHome:home];
                
            case USER_HOME_TYPE_6:
                return [NewFeedInfoCell heightWithHome6:home.home6];
                
            case USER_HOME_TYPE_7:
                return [NewFeedInfoCell heightWithHome7:home.home7];
                
            case USER_HOME_TYPE_8:
                return [NewFeedPromotionCell heightWithHome8:home.home8];
                
            case USER_HOME_TYPE_UNKNOW:
                return 0;
        }
    }
    else if(tableView==tableAds)
    {
        return tableView.l_v_w;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFeed)
    {
        if([cell isKindOfClass:[NewFeedPromotionCell class]])
        {
            [((NewFeedPromotionCell*)cell) alignContent];
        }
    }
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
                NewFeedPromotionCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedPromotionCell reuseIdentifier]];
                
                [cell loadWithHome1:home.home1];
                
                return cell;
            }
                
            case USER_HOME_TYPE_2:
            {
                NewFeedImagesCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedImagesCell reuseIdentifier]];
                
                [cell loadWithImages:[home.home2Objects valueForKeyPath:UserHome2_Image]];
                
                return cell;
            }
                
            case USER_HOME_TYPE_3:
            {
                NewFeedListCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome3:home];
                
                return cell;
            }
            case USER_HOME_TYPE_4:
            {
                NewFeedListCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome4:home];
                
                return cell;
            }
            case USER_HOME_TYPE_5:
            {
                NewFeedListCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome5:home];
                
                return cell;
            }
                
            case USER_HOME_TYPE_6:
            {
                NewFeedInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedInfoCell reuseIdentifier]];
                cell.delegate=self;
                
                [cell loadWithHome6:home.home6];
                
                return cell;
            }
                
            case USER_HOME_TYPE_7:
            {
                NewFeedInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedInfoCell reuseIdentifier]];
                
                [cell loadWithHome7:home.home7];
                
                return cell;
            }
                
            case USER_HOME_TYPE_8:
            {
                NewFeedPromotionCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedPromotionCell reuseIdentifier]];
                
                [cell loadWithHome8:home.home8];
                
                return cell;
            }
                
            case USER_HOME_TYPE_UNKNOW:
                return 0;
        }
    }
    else if(tableView==tableAds)
    {
        return [UITableViewCell new];
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
                if(home.home1.shopList.length>0 && ![home.home1.shopList isContainString:@","])
                {
                    [self requestShopUserWithIDShop:home.home1.idShop.integerValue];
                    
                    [self.view showLoading];
                    return;
                }
                
                [self.delegate newFeedControllerTouchedHome1:self home1:home.home1];
            }
                break;
                
            case USER_HOME_TYPE_2:
            {
                //Nothing do
            }
                break;
                
            case USER_HOME_TYPE_3:
            {
                /*
                 using delegate newFeedListTouched
                 */
            }
                break;
                
            case USER_HOME_TYPE_4:
            {
                
            }
                break;
                
            case USER_HOME_TYPE_5:
            {
                
            }
                break;
                
            case USER_HOME_TYPE_6:
            {
                
            }
                break;
                
            case USER_HOME_TYPE_7:
            {
                
            }
                break;
                
            case USER_HOME_TYPE_8:
            {
                [[GUIManager shareInstance] presentShopUserWithShopUser:nil];
            }
                break;
                
            case USER_HOME_TYPE_UNKNOW:
                break;
        }
    }
    else if(tableView==tableAds)
    {
        
    }
}

-(void)newFeedListTouched:(NewFeedListCell *)cell
{
    if(cell.currentHome)
    {
        if([cell.currentHome isKindOfClass:[UserHome3 class]])
        {
            [self.delegate newFeedControllerTouchedPlacelist:self home3:cell.currentHome];
        }
        else if([cell.currentHome isKindOfClass:[UserHome4 class]])
        {
            UserHome4 *home=cell.currentHome;
            [self requestShopUserWithIDShop:home.idShop.integerValue];
            
            [self.view showLoading];
        }
        else if([cell.currentHome isKindOfClass:[UserHome5 class]])
        {
            //            UserHome5 *home=cell.currentHome;
            
            //StoreShopInfoViewController *vc=[StoreShopInfoViewController alloc] initWithStore:<#(StoreShop *)#>
            
            //            [self.view showLoading];
        }
    }
}

-(void)newFeedInfoCellTouchedGoTo:(id)home
{
    if([home isKindOfClass:[UserHome6 class]])
    {
        UserHome6 *home6=home;
        
        [self requestShopUserWithIDShop:home6.idShop.integerValue];
        
        [self.view showLoading];
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
        
        if([cell isKindOfClass:[NewFeedListCell class]])
        {
            [array addObject:ip];
        }
    }
    
    if(array.count>0)
        [tableFeed reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
}

@end
