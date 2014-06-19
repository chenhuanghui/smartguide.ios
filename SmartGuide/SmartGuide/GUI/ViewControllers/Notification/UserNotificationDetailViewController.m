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
#import "NotificationManager.h"
#import "ASIOperationUserNotificationFromSender.h"
#import "ASIOperationUserNotificationMarkRead.h"
#import "OperationNotificationAction.h"
#import "ASIOperationUserNotificationRemove.h"
#import "AppDelegate.h"
#import "EmptyDataView.h"

@interface UserNotificationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate,UserNotificationDetailCellDelegate>
{
    ASIOperationUserNotificationFromSender *_operationNotificationContent;
}

@end

@implementation UserNotificationDetailViewController

-(UserNotificationDetailViewController *)initWithIDSender:(int)idSender
{
    self=[super initWithNibName:@"UserNotificationDetailViewController" bundle:nil];
    
    _idSender=idSender;
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    lblTitle.text=title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    lblTitle.text=self.title;
    
    [UserNotificationContent markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    _canLoadMore=false;
    _isLoadingMore=false;
    _page=-1;
    _userNotificationContents=[NSMutableArray new];
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationDetailCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    [self requestNotification];
    [self showLoading];
}

-(NSArray *)registerNotifications
{
    return @[MPMoviePlayerWillEnterFullscreenNotification,MPMoviePlayerWillExitFullscreenNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:MPMoviePlayerWillExitFullscreenNotification])
    {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        
        app.allowRotation=false;
    }
    else if([notification.name isEqualToString:MPMoviePlayerWillEnterFullscreenNotification])
    {
        AppDelegate *app=[UIApplication sharedApplication].delegate;
        
        app.allowRotation=true;
    }}

-(void) requestNotification
{
    if(_operationNotificationContent)
    {
        [_operationNotificationContent clearDelegatesAndCancel];
        _operationNotificationContent=nil;
    }
    
    _operationNotificationContent=[[ASIOperationUserNotificationFromSender alloc] initWithIDSender:_idSender page:_page+1 userLat:userLat() userLng:userLng()];
    _operationNotificationContent.delegate=self;
    
    [_operationNotificationContent addToQueue];
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
    if([operation isKindOfClass:[ASIOperationUserNotificationFromSender class]])
    {
        [self.view removeLoading];
        
        ASIOperationUserNotificationFromSender *ope=(ASIOperationUserNotificationFromSender*) operation;
        
        self.title=ope.sender;
        [_userNotificationContents addObjectsFromArray:ope.notifications];
        _canLoadMore=ope.notifications.count>=10;
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
            
            if(_page==0)
            {
                UserNotificationContent *obj=_userNotificationContents[0];
                
                if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD)
                {
                    [self markReadNotification:obj];
                }
                
                [obj setDisplayType:@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)];
            }
            
            [[DataManager shareInstance] save];
        }
        
        [table reloadData];
        
        [self showEmptyView];
        
        _operationNotificationContent=nil;
    }
}

-(void) showEmptyView
{
    [table removeEmptyDataView];
    
    if(_userNotificationContents.count==0)
    {
        [table showEmptyDataViewWithText:@"Không có dữ liệu" textColor:[UIColor grayColor]];
        [table.emptyDataView l_v_setY:30];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationFromSender class]])
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
    [[NotificationManager shareInstance] requestNotificationCount];
    [self.navigationController popViewControllerAnimated:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    
    [cell loadWithUserNotificationDetail:obj displayType:obj.enumDisplayType];
    
    cell.delegate=self;
    
    return cell;
}

+(NSString *)screenCode
{
    return @"S00601";
}

-(void) markReadNotification:(UserNotificationContent*) obj
{
    if(obj.enumStatus==NOTIFICATION_STATUS_READ)
        return;
    
    obj.status=@(NOTIFICATION_STATUS_READ);
    [[DataManager shareInstance] save];
    
    ASIOperationUserNotificationMarkRead *ope=[[ASIOperationUserNotificationMarkRead alloc] initWithIDNotification:obj.idNotification.integerValue userLat:userLat() userLng:userLng()];
    [ope addToQueue];
}

-(MPMoviePlayerController *)userNotificationDetailCellRequestPlayer:(UserNotificationDetailCell *)cell
{
    if(!_player)
    {
        _player=[MPMoviePlayerController new];
        _player.shouldAutoplay=false;
    }
    
    return _player;
}

-(void)userNotificationDetailCellTouchedAction:(UserNotificationDetailCell *)cell action:(UserNotificationAction *)action
{
    [SGData shareInstance].fScreen=@"S00601";
    
    if(cell.userNotificationDetail.idSender)
        [[SGData shareInstance].fData setObject:cell.userNotificationDetail.idSender forKey:@"idSender"];
    [[SGData shareInstance].fData setObject:cell.userNotificationDetail.idNotification forKey:@"idNotification"];
    
    switch (action.enumActionType) {
        case NOTIFICATION_ACTION_TYPE_CALL_API:
        {
            [[OperationNotificationAction operationWithURL:action.url method:action.methodName params:action.params] addToQueue];
        }
            break;
            
        case NOTIFICATION_ACTION_TYPE_POPUP_URL:
            
            [[GUIManager shareInstance].rootViewController showWebviewWithURL:URL(action.url)];
            
            break;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_LIST:
            
            switch (action.enumShopListDataType) {
                case NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDPLACELIST:
                    [[GUIManager shareInstance].rootViewController showShopListWithIDPlace:action.idPlacelist.integerValue];
                    break;
                    
                case NOTIFICATION_ACTION_SHOP_LIST_TYPE_KEYWORDS:
                    [[GUIManager shareInstance].rootViewController showShopListWithKeywordsShopList:action.keywords];
                    break;
                    
                case NOTIFICATION_ACTION_SHOP_LIST_TYPE_IDSHOPS:
                    [[GUIManager shareInstance].rootViewController showShopListWithIDShops:action.idShops];
                    break;
            }
            
            break;
            
        case NOTIFICATION_ACTION_TYPE_SHOP_USER:
            [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:action.idShop.integerValue];
            break;
            
        case NOTIFICATION_ACTION_TYPE_USER_PROMOTION:
            [[GUIManager shareInstance].rootViewController showUserPromotion];
            break;
            
        case NOTIFICATION_ACTION_TYPE_USER_SETTING:
            [[GUIManager shareInstance].rootViewController showUserSetting];
            break;
            
        case NOTIFICATION_ACTION_TYPE_UNKNOW:
            break;
    }
}

-(void)userNotificationDetailCellTouchedLogo:(UserNotificationDetailCell *)cell
{
    UserNotificationContent *obj=cell.userNotificationDetail;
    
    if(obj.idShopLogo)
    {
        [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:obj.idShopLogo.integerValue];
    }
}

-(void)userNotificationDetailCellTouchedRemove:(UserNotificationDetailCell *)cell
{
    if(currentUser().enumDataMode!=USER_DATA_FULL)
        return;
    
    ASIOperationUserNotificationRemove *ope=[[ASIOperationUserNotificationRemove alloc] initWithIDNotification:cell.userNotificationDetail.idNotification idSender:nil userLat:userLat() userLng:userLng()];
    [ope addToQueue];
    
    [_userNotificationContents removeObject:cell.userNotificationDetail];
    
    NSIndexPath *idx=[table indexPathForCell:cell];
    
    [cell.superview sendSubviewToBack:cell];
    
    [table beginUpdates];
    
    [table deleteRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [table endUpdates];
    
    [self showEmptyView];
}

-(void)userNotificationDetailCellTouchedDetail:(UserNotificationDetailCell *)cell
{
    NSIndexPath *indexPath=[table indexPathForCell:cell];
    UserNotificationContent *obj=cell.userNotificationDetail;
    
    switch (obj.enumDisplayType) {
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE:
        {
            if(_player)
            {
                [_player stop];
                [_player setContentURL:nil];
                [_player.view removeFromSuperview];
            }
            
            NSArray *array=[_userNotificationContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%@",UserNotificationContent_DisplayType,@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)]];
            
            NSMutableArray *arrIdx=[NSMutableArray array];
            
            if(array>0)
            {
                UserNotificationContent *objFull=array[0];
                objFull.displayType=@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_TITLE);
                objFull.highlightUnread=@(false);
                
                if(objFull.enumStatus==NOTIFICATION_STATUS_UNREAD)
                {
                    [self markReadNotification:objFull];
                }
                
                [arrIdx addObject:makeIndexPath([_userNotificationContents indexOfObject:objFull], 0)];
            }
            
            [arrIdx addObject:indexPath];
            
            obj.displayType=@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL);
            [self markReadNotification:obj];
            
            [[DataManager shareInstance] save];
            
            [table reloadRowsAtIndexPaths:arrIdx withRowAnimation:UITableViewRowAnimationAutomatic];
        }
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
            break;
    }
    
    if(![table isCellCompletionVisibility:indexPath])
    {
        [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:true];
    }
}


/*
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[UserNotificationDetailCell class]])
    {
        UserNotificationDetailCell *dCell=(UserNotificationDetailCell*)cell;
        
        if(dCell.userNotificationDetail.enumStatus==NOTIFICATION_STATUS_UNREAD
           && dCell.userNotificationDetail.enumDisplayType==USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)
        {
            [self markReadNotification:dCell.userNotificationDetail];
        }
    }
}
 */

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)processRemoteNotification:(RemoteNotification *)obj
{
    if(obj.idSender)
    {
        _idSender=obj.idSender.integerValue;
        [self resetData];
    }
}

-(void)dealloc
{
    if(_player)
    {
        [_player stop];
        [_player.view removeFromSuperview];
        _player=nil;
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