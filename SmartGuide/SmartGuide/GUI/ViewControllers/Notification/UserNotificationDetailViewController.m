//
//  NotificationDetailViewController.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailViewController.h"
#import "UserNotificationDetailCell.h"
#import "LoadingMoreCell.h"
#import "GUIManager.h"
#import "QRCodeViewController.h"
#import "UserNotificationViewController.h"

@interface UserNotificationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate,UserNotificationDetailCellDelegate>

@end

@implementation UserNotificationDetailViewController

-(UserNotificationDetailViewController *)initWithUserNotification:(UserNotification *)obj
{
    self=[super initWithNibName:@"UserNotificationDetailViewController" bundle:nil];
    
    _idNotification=obj.idNotification.integerValue;
    
    return self;
}

-(UserNotificationDetailViewController *)initWithIDNotification:(int)idNotification
{
    self=[super initWithNibName:@"UserNotificationDetailViewController" bundle:nil];
    
    _idNotification=idNotification;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [UserNotificationContent markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    _canLoadMore=true;
    _isLoadingMore=false;
    _page=-1;
    _userNotificationContents=[NSMutableArray new];
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationDetailCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    [self requestNotification];
    [self showLoading];
}

-(void) requestNotification
{
    if(_operationNotificationContent)
    {
        [_operationNotificationContent clearDelegatesAndCancel];
        _operationNotificationContent=nil;
    }
    
    _operationNotificationContent=[[ASIOperationUserNotificationContent alloc] initWithIDNotification:_idNotification page:_page+1 userLat:userLat() userLng:userLng()];
    _operationNotificationContent.delegatePost=self;
    
    [_operationNotificationContent startAsynchronous];
}

-(void) resetData
{
    if(_operationNotificationContent)
    {
        [_operationNotificationContent clearDelegatesAndCancel];
        _operationNotificationContent=nil;
    }
    
    _page=-1;
    _isLoadingMore=false;
    _canLoadMore=true;
    _userNotificationContents=[NSMutableArray new];
    
    [self showLoading];
    [self requestNotification];
}

-(void) showLoading
{
    [self.view showLoadingInsideFrame:CGRectMake(0, 54, self.l_v_w, self.l_v_h-54)];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationContent class]])
    {
        [self.view removeLoading];
        
        ASIOperationUserNotificationContent *ope=(ASIOperationUserNotificationContent*) operation;
        
        [_userNotificationContents addObjectsFromArray:ope.notifications];
        _canLoadMore=ope.notifications.count==10;
        _isLoadingMore=false;
        _page++;
        
        if(_userNotificationContents.count>0)
        {
            for(UserNotificationContent *obj in _userNotificationContents)
            {
                if(!obj.displayType)
                {
                    obj.displayType=@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE);
                }
            }
            
            [_userNotificationContents[0] setDisplayType:@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)];
            
            [[DataManager shareInstance] save];
        }
        
        [table reloadData];
        
        _operationNotificationContent=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationContent class]])
    {
        [self.view removeLoading];
        
        _operationNotificationContent=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _userNotificationContents.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userNotificationContents.count+(_canLoadMore?1:0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==_userNotificationContents.count)
        return 80;

    UserNotificationContent *obj=_userNotificationContents[indexPath.row];
    
    return [UserNotificationDetailCell heightWithUserNotificationDetail:_userNotificationContents[indexPath.row] displayType:obj.enumDisplayType];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore)
    {
        if(indexPath.row==_userNotificationContents.count)
        {
            if(!_isLoadingMore)
            {
                _isLoadingMore=true;
                
                [self requestNotification];
            }
            
            return [table loadingMoreCell];
        }
    }
    
    UserNotificationContent *obj=_userNotificationContents[indexPath.row];
    UserNotificationDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:[UserNotificationDetailCell reuseIdentifier]];
    
    if(indexPath.row==0)
        [cell loadWithUserNotificationDetail:obj displayType:USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL];
    else
        [cell loadWithUserNotificationDetail:obj displayType:obj.enumDisplayType];
    
    cell.delegate=self;
    
    return cell;
}

+(NSString *)screenCode
{
    return @"S00601";
}

-(void)userNotificationDetailCellTouchedGo:(UserNotificationDetailCell *)cell
{
    [SGData shareInstance].fScreen=@"S00601";
    UserNotificationContent *obj=[cell userNotificationDetail];
    
    if(obj.enumStatus==USER_NOTIFICATION_CONTENT_STATUS_UNREAD)
    {
        [obj markAndSendRead];
    }
    
    [self processUserNotification:obj];
}

-(void)userNotificationDetailCellTouchedLogo:(UserNotificationDetailCell *)cell
{
    UserNotificationContent *obj=cell.userNotificationDetail;
    
    if(obj.idShopLogo)
    {
        [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:obj.idShopLogo.integerValue];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserNotificationDetailCell *cell=(UserNotificationDetailCell*)[table cellForRowAtIndexPath:indexPath];
    UserNotificationContent *obj=cell.userNotificationDetail;

    switch (obj.enumDisplayType) {
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
        {
            obj.displayType=@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL);
            [[DataManager shareInstance] save];
            
            [table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            if(obj.enumStatus==USER_NOTIFICATION_CONTENT_STATUS_UNREAD && obj.enumReadAction==USER_NOTIFICATION_CONTENT_READ_ACTION_TOUCH)
            {
                [obj markAndSendRead];
            }
        }
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
            if(obj.actionTitle.length==0)
                [self processUserNotification:obj];
            break;
    }
}

-(void)processRemoteNotification:(UserNotification *)obj
{
    _idNotification=obj.idNotification.integerValue;
    [self resetData];
}

-(void) processUserNotification:(UserNotificationContent*) userNotification
{
    NSLog(@"processUserNotification %@",userNotification);
    
    switch (userNotification.enumActionType) {
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_MARK_READ:
        {
            if(userNotification.enumStatus==USER_NOTIFICATION_CONTENT_STATUS_UNREAD)
                [userNotification markAndSendRead];
        }
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_LOGIN:
        {
            [[GUIManager shareInstance] showLoginControll:^(bool isLogin) {
                if(isLogin)
                    [self resetData];
            }];
        }
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_POPUP_URL:
            [[GUIManager shareInstance].rootViewController showWebviewWithURL:[NSURL URLWithString:userNotification.url]];
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SCAN_CODE:
            [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[UserNotificationDetailViewController screenCode]];
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_LIST:
            switch (userNotification.enumShopListDataType) {
                case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_PLACELIST:
                    [[GUIManager shareInstance].rootViewController showShopListWithIDPlace:userNotification.idPlacelist.integerValue];
                    break;
                    
                case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_KEYWORDS:
                    [[GUIManager shareInstance].rootViewController showShopListWithKeywordsShopList:userNotification.keywords];
                    break;
                    
                case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_IDSHOPS:
                    [[GUIManager shareInstance].rootViewController showShopListWithIDShops:userNotification.idShops];
                    break;
                    
                case USER_NOTIFICATION_CONTENT_SHOP_LIST_DATA_TYPE_UNKNOW:
                    NSLog(@"UserNotificationDetailViewController USER_NOTIFICATION_SHOP_LIST_DATA_TYPE_UNKNOW");
                    break;
            }
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_SHOP_USER:
            [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:userNotification.idShop.integerValue];
            break;
            
        case USER_NOTIFICATION_CONTENT_ACTION_TYPE_USER_PROMOTION:
            NSLog(@"UserNotificationDetailViewController USER_NOTIFICATION_ACTION_TYPE_USER_PROMOTION");
            //            [[GUIManager shareInstance].rootViewController showUserPromotion];
            break;
            
        case USER_NOTIFICATION_ACTION_TYPE_USER_SETTING:
            [[GUIManager shareInstance].rootViewController showUserSetting];
            break;
    }
}

@end

@implementation UserNotificationContent(DisplayType)

-(enum USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE)enumDisplayType
{
    if(self.displayType)
    {
        switch (self.displayType.integerValue) {
            case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
                return USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL;
                
            case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
                return USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
        }
    }
    
    return USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE;
}

@end