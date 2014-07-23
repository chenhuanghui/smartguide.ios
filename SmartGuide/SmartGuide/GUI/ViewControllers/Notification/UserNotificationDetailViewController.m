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
#import "UserNotificationViewController.h"
#import "NotificationManager.h"
#import "ASIOperationUserNotificationFromSender.h"
#import "ASIOperationUserNotificationMarkRead.h"
#import "OperationNotificationAction.h"
#import "ASIOperationUserNotificationRemove.h"
#import "OperationNotificationCountBySender.h"
#import "AppDelegate.h"
#import "EmptyDataView.h"
#import "WebViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface UserNotificationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate,UserNotificationDetailCellDelegate>
{
    ASIOperationUserNotificationFromSender *_operationNotificationContent;
    OperationNotificationCountBySender *_opeCountBySender;
}

@end

@implementation UserNotificationDetailViewController

-(UserNotificationDetailViewController *)initWithIDSender:(NSNumber *)idSender
{
    self=[super initWithNibName:@"UserNotificationDetailViewController" bundle:nil];
    
    _idSender=idSender;
    
    return self;
}

-(UserNotificationDetailViewController *)initWithUserNotification:(UserNotification *)obj
{
    self=[super initWithNibName:@"UserNotificationDetailViewController" bundle:nil];
    
    _idSender=obj.idSender;
    _userNotification=obj;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    lblTitle.text=_userNotification.sender?:@"";
    
    _canLoadMore=false;
    _isLoadingMore=false;
    _page=-1;
    
    if(_userNotification && _userNotification.notificationContentsObjects.count>0)
    {
        _userNotificationContents=[[NSMutableArray alloc] initWithObjects:_userNotification.notificationContentsObjects[0],nil];
        [_userNotificationContents[0] setDisplayType:@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)];
        [[DataManager shareInstance] save];
    }
    else
        _userNotificationContents=[NSMutableArray new];
    
    [table registerUserNotificationDetailCell];
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
    }
}

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
    _canLoadMore=false;
    _userNotification=nil;
    _userNotificationContents=[NSMutableArray new];
    
    [table reloadData];
    [self showLoading];
    [self requestNotification];
}

-(void) showLoading
{
    if([table numberOfRowsInSection:0]==0)
        [table showLoading];
    else
    {
        [table showLoadingBelowIndexPath:makeIndexPath(0, 0)];
    }
}

-(void) removeLoading
{
    [table removeLoading];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationFromSender class]])
    {
        [self removeLoading];
        
        ASIOperationUserNotificationFromSender *ope=(ASIOperationUserNotificationFromSender*) operation;
        
        lblTitle.text=ope.sender;
        
        _page++;
        
        if(_page==0)
            _userNotificationContents=ope.notifications;
        else
            [_userNotificationContents addObjectsFromArray:ope.notifications];
        
        _canLoadMore=ope.notifications.count>=10;
        _isLoadingMore=false;
        
        
        if(_userNotificationContents.count>0)
        {
            if(_page==0)
            {
                UserNotificationContent *obj=_userNotificationContents[0];
                
                if(obj.enumStatus==NOTIFICATION_STATUS_UNREAD)
                {
                    [self markReadNotification:obj];
                }
                
                [obj setDisplayType:@(USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL)];
                
                [[DataManager shareInstance] save];
            }
        }
        
        [table reloadData];
        
        [self showEmptyView];
        
        _operationNotificationContent=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserNotificationMarkRead class]])
    {
        ASIOperationUserNotificationMarkRead *ope=(ASIOperationUserNotificationMarkRead*) operation;
        [self requestCountBySender:ope.idSender];
    }
    else if([operation isKindOfClass:[OperationNotificationCountBySender class]])
    {
        _opeCountBySender=nil;
    }
}

-(void) requestCountBySender:(int) idSender
{
    if(_opeCountBySender)
    {
        [_opeCountBySender clearDelegatesAndCancel];
        _opeCountBySender=nil;
    }
    
    _opeCountBySender=[[OperationNotificationCountBySender alloc] initWithIDSender:idSender type:NOTIFICATION_COUNT_TYPE_ALL userLat:userLat() userLng:userLng()];
    _opeCountBySender.delegate=self;
    
    [_opeCountBySender addToQueue];
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
        [self removeLoading];
        
        _operationNotificationContent=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserNotificationMarkRead class]])
    {
        [self requestCountBySender:((ASIOperationUserNotificationMarkRead*)operation).idSender];
    }
    else if([operation isKindOfClass:[OperationNotificationCountBySender class]])
    {
        _opeCountBySender=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.delegate userNotificationDetailControllerTouchedBack:self];
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
    if(_canLoadMore && indexPath.row==_userNotificationContents.count)
    {
        return 80;
    }
    
    UserNotificationContent *obj=_userNotificationContents[indexPath.row];
    UserNotificationDetailCell *cell=[tableView userNotificationDetailCell];
    [cell loadWithUserNotificationDetail:obj];
    [cell layoutSubviews];
    
    return cell.suggestHeight;
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
    UserNotificationDetailCell *cell=[tableView userNotificationDetailCell];
    
    [cell loadWithUserNotificationDetail:obj];
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
    
    ASIOperationUserNotificationMarkRead *ope=[[ASIOperationUserNotificationMarkRead alloc] initWithIDMessage:obj.idMessage.integerValue userLat:userLat() userLng:userLng() idSender:obj.idSender.integerValue];
    ope.delegate=self;
    
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
    [[SGData shareInstance].fData setObject:cell.userNotificationDetail.idMessage forKey:@"idMessage"];
    
    switch (action.enumActionType) {
        case NOTIFICATION_ACTION_TYPE_CALL_API:
        {
            [[OperationNotificationAction operationWithURL:action.url method:action.methodName params:action.params] addToQueue];
        }
            break;
            
        case NOTIFICATION_ACTION_TYPE_POPUP_URL:
            
            [self showWebViewWithURL:URL(action.url) onCompleted:nil];
            
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
    
    ASIOperationUserNotificationRemove *ope=[[ASIOperationUserNotificationRemove alloc] initWithIDMessage:cell.userNotificationDetail.idMessage idSender:nil userLat:userLat() userLng:userLng()];
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
            
            [table beginUpdates];
            [table endUpdates];
            
            [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
        }
            break;
            
        case USER_NOTIFICATION_DETAIL_CELL_DISPLAY_TYPE_FULL:
            break;
    }
}

-(void)processRemoteNotification:(RemoteNotification *)obj
{
    if(obj.idSender)
    {
        _userNotification=nil;
        _idSender=obj.idSender;
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