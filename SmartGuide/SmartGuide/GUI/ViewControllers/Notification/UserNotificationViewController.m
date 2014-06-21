//
//  NotificationViewController.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationViewController.h"
#import "UserNotificationCell.h"
#import "UserNotification.h"
#import "UserNotificationHeaderView.h"
#import "UserNotificationDetailViewController.h"
#import "LoadingMoreCell.h"
#import "GUIManager.h"
#import "SGNavigationController.h"
#import "QRCodeViewController.h"
#import "ASIOperationUserNotificationNewest.h"
#import "NotificationManager.h"
#import "RefreshingView.h"
#import "OperationNotificationAction.h"
#import "ASIOperationUserNotificationRemove.h"
#import "EmptyDataView.h"
#import "ASIOperationNotificationCount.h"

@interface UserNotificationViewController ()<UITableViewDataSource,UITableViewDelegate,UserNotificationCellDelegate,ASIOperationPostDelegate,UIActionSheetDelegate,RefreshingViewDelegate>
{
    enum USER_NOTIFICATION_DISPLAY_TYPE _displayType;
    ASIOperationUserNotificationNewest *_operationUserNotification;
    ASIOperationNotificationCount *_operationNotificationCount;
    
    __weak RefreshingView *refreshView;
}

@end

@implementation UserNotificationViewController

- (instancetype)init
{
    self = [super initWithNibName:@"UserNotificationViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [UserNotification markDeleteAllObjects];
    [UserNotificationContent markDeleteAllObjects];
    [UserNotificationAction markDeleteAllObjects];
    
    [[DataManager shareInstance] save];
    
    _displayType=USER_NOTIFICATION_DISPLAY_ALL;
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    _userNotification=[NSMutableArray new];
    _userNotificationRead=[NSArray new];
    _userNotificationUnread=[NSArray new];
    
    _isLoadingMore=false;
    _canLoadMore=false;
    _page=-1;
    _isHasReadNotification=false;
    
    [self requestUserNotification];
    
    [self showLoading];
    
    RefreshingView *rv=[[RefreshingView alloc] initWithTableView:table];
    rv.delegate=self;
    refreshView=rv;
    
    [table l_v_addY:-[RefreshingView height]];
    [table l_v_addH:[RefreshingView height]];
    
    [self requestNotificationCount:true];
}

-(void) requestNotificationCount:(bool) force
{
    if(force)
    {
        if(_operationNotificationCount)
        {
            [_operationNotificationCount clearDelegatesAndCancel];
            _operationNotificationCount=nil;
        }
    }
    
    if(_operationNotificationCount || _operationNotificationCount)
        return;
    
    _operationNotificationCount=[[ASIOperationNotificationCount alloc] initWithCountType:NOTIFICATION_COUNT_TYPE_ALL userLat:userLat() userLng:userLng() uuid:UUID()];
    _operationNotificationCount.delegate=self;
    
    [_operationNotificationCount addToQueue];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [refreshView tableDidScroll:table];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [refreshView tableDidEndDecelerating:table];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [refreshView tableDidEndDragging:table willDecelerate:decelerate];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [refreshView tableWillBeginDragging:table];
}

-(void)refreshingViewNeedRefresh:(RefreshingView *)refreshView
{
    [self refreshData];
    [self requestNotificationCount:true];
    
    NSLog(@"refreshingViewNeedRefresh");
}

-(void)refreshingViewFinished:(RefreshingView *)refreshView
{
    [self.view removeLoading];
    
    _isLoadingMore=false;
    _canLoadMore=_userNotificationFromAPI.count>=10;
    _page++;
    
    _userNotification=[_userNotificationFromAPI mutableCopy];
    
    [self reloadData];
    
    [[NotificationManager shareInstance] requestNotificationCount];
}

-(void) requestUserNotification
{
    if(_operationUserNotification)
    {
        [_operationUserNotification clearDelegatesAndCancel];
        _operationUserNotification=nil;
    }
    
    _operationUserNotification=[[ASIOperationUserNotificationNewest alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng() type:_displayType];
    _operationUserNotification.delegate=self;
    
    [_operationUserNotification addToQueue];
}

-(void) refreshData
{
    if(_operationUserNotification)
    {
        [_operationUserNotification clearDelegatesAndCancel];
        _operationUserNotification=nil;
    }
    
    _page=-1;
    _isLoadingMore=true;
    _canLoadMore=false;
    
    [self requestUserNotification];
    [self showLoading];
}

-(void) showLoading
{
    [self.view showLoadingInsideFrame:CGRectMake(0, 54, self.l_v_w, self.l_v_h-54)];
}

-(void) resetData
{
    if(_operationUserNotification)
    {
        [_operationUserNotification clearDelegatesAndCancel];
        _operationUserNotification=nil;
    }
    
    for(UserNotificationCell *cell in [table visibleCells])
        [cell removeObserverHighlightUnread];
    
    _page=-1;
    _userNotification=[NSMutableArray new];
    _userNotificationRead=[NSMutableArray new];
    _userNotificationUnread=[NSMutableArray new];
    _canLoadMore=true;
    _isHasReadNotification=false;
    _isLoadingMore=false;
    
    [self requestUserNotification];
    [self showLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    switch (_displayType) {
        case USER_NOTIFICATION_DISPLAY_ALL:
            return _isHasReadNotification?2:1;
            
        case USER_NOTIFICATION_DISPLAY_READ:
        case USER_NOTIFICATION_DISPLAY_UNREAD:
            return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case NOTIFICATION_STATUS_UNREAD:
            return [self userNotificationUnread].count+((!_isHasReadNotification && _canLoadMore)?1:0);
            
        case NOTIFICATION_STATUS_READ:
            if([self userNotificationRead].count>0)
                return [self userNotificationRead].count+(_canLoadMore?1:0);
            else
                return 0;
            
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore)
    {
        if(_isHasReadNotification)
        {
            if(indexPath.section==NOTIFICATION_STATUS_READ && indexPath.row==[self userNotificationRead].count)
            {
                if(!_isLoadingMore)
                {
                    _isLoadingMore=true;
                    
                    [self requestUserNotification];
                }
                
                return [tableView loadingMoreCell];
            }
        }
        else
        {
            if(indexPath.row==[self userNotificationUnread].count)
            {
                if(!_isLoadingMore)
                {
                    _isLoadingMore=true;
                    
                    [self requestUserNotification];
                }
                
                return [tableView loadingMoreCell];
            }
        }
    }
    
    UserNotificationCell *cell=(UserNotificationCell*)[tableView dequeueReusableCellWithIdentifier:[UserNotificationCell reuseIdentifier]];
    cell.delegate=self;
    
    switch (indexPath.section) {
            
        case NOTIFICATION_STATUS_UNREAD:
            [cell loadWithUserNotification:[self userNotificationUnread][indexPath.row]];
            break;
            
        case NOTIFICATION_STATUS_READ:
            [cell loadWithUserNotification:[self userNotificationRead][indexPath.row]];
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)userNotificationCellTouchedAction:(UserNotificationCell *)cell action:(UserNotificationAction *)action
{
    [SGData shareInstance].fScreen=@"S006";
    [SGData shareInstance].fData=[NSMutableDictionary dictionaryWithObject:cell.userNotification.idSender forKey:@"idSender"];
    
    switch (action.enumActionType) {
        case NOTIFICATION_ACTION_TYPE_CALL_API:
            
            [OperationNotificationAction operationWithURL:action.url method:action.methodName params:action.params];
            
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

-(void)userNotificationCellTouchedDetail:(UserNotificationCell *)cell obj:(UserNotification *)obj
{
    UserNotificationDetailViewController *vc=[[UserNotificationDetailViewController alloc] initWithIDSender:obj.idSender.integerValue];
    vc.title=obj.sender;
    obj.highlightUnread=@(false);
    [[DataManager shareInstance] save];
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void) deleteUserNotification:(int) idSender
{
    ASIOperationUserNotificationRemove *operationUserNotificationRemove=[[ASIOperationUserNotificationRemove alloc] initWithIDMessage:nil idSender:@(idSender) userLat:userLat() userLng:userLng()];
    operationUserNotificationRemove.delegate=self;
    
    [operationUserNotificationRemove addToQueue];
}

-(void)userNotificationCellTouchedRemove:(UserNotificationCell *)cell obj:(UserNotification *)obj
{
    if(currentUser().enumDataMode!=USER_DATA_FULL)
        return;
    
    NSArray *notificationRemoved=[_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%@",UserNotification_IdSender,obj.idSender]];
    
    [self deleteUserNotification:obj.idSender.integerValue];
    
    //Tạo danh sách các row sẽ bị remove từ table view
    NSMutableArray *arrIdx=[NSMutableArray array];
    
    for(UserNotification *noti in notificationRemoved)
    {
        int idx=[_userNotificationUnread indexOfObject:noti];
        
        if(idx!=NSNotFound)
        {
            NSIndexPath *indexPath=makeIndexPath(idx, NOTIFICATION_STATUS_UNREAD);
            
            UserNotificationCell *notiCell=(UserNotificationCell*)[table cellForRowAtIndexPath:indexPath];
            [notiCell removeObserverHighlightUnread];
            [notiCell.superview sendSubviewToBack:notiCell];
            
            [arrIdx addObject:indexPath];
        }
        else
        {
            idx=[_userNotificationRead indexOfObject:noti];
            
            if(idx!=NSNotFound)
            {
                NSIndexPath *indexPath=makeIndexPath(idx, NOTIFICATION_STATUS_READ);
                
                UserNotificationCell *notiCell=(UserNotificationCell*)[table cellForRowAtIndexPath:indexPath];
                [notiCell removeObserverHighlightUnread];
                [notiCell.superview sendSubviewToBack:notiCell];
                
                [arrIdx addObject:indexPath];
            }
        }
    }
    
    [_userNotification removeObjectsInArray:notificationRemoved];
    [self makeData];
    
    [table beginUpdates];
    
    [table deleteRowsAtIndexPaths:arrIdx withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [table endUpdates];
    
    //Dùng để remove table section view
    [table killScroll];
    
    [table removeEmptyDataView];
    
    if(_userNotification.count==0)
    {
        [table showEmptyDataViewWithText:@"Không có dữ liệu" textColor:[UIColor grayColor]];
        [table.emptyDataView l_v_setY:table.tableHeaderView.l_v_h+30];
    }
}

+(NSString *)screenCode
{
    return @"S006";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore)
    {
        if(_isHasReadNotification)
        {
            if(indexPath.section==NOTIFICATION_STATUS_READ && indexPath.row==[self userNotificationRead].count)
                return 77;
        }
        else
        {
            if(indexPath.row==[self userNotificationUnread].count)
                return 77;
        }
    }
    
    switch (indexPath.section) {
        case NOTIFICATION_STATUS_UNREAD:
            return [UserNotificationCell heightWithUserNotification:[self userNotificationUnread][indexPath.row]];
            
        case NOTIFICATION_STATUS_READ:
            return [UserNotificationCell heightWithUserNotification:[self userNotificationRead][indexPath.row]];
            
        default:
            return 0;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case NOTIFICATION_STATUS_READ:
            if(_userNotificationRead.count>0)
                return [UserNotificationHeaderView height];
            return 0;
            
        default:
            return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case NOTIFICATION_STATUS_READ:
        {
            if(_userNotificationRead.count>0)
            {
                UserNotificationHeaderView *headerView=[UserNotificationHeaderView new];
                _headerView=headerView;
                
                return _headerView;
            }
            
            return [UIView new];
        }
            
        default:
            return [UIView new];
    }
}

-(NSArray*) userNotificationUnread
{
    return _userNotificationUnread;
}

-(NSArray*) userNotificationRead
{
    return _userNotificationRead;
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [[NotificationManager shareInstance] requestNotificationCount];
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    UIActionSheet *sheet=nil;
    
    switch (_displayType) {
        case USER_NOTIFICATION_DISPLAY_ALL:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Setting" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Chưa đọc",@"Đã đọc", nil];
            break;
            
        case USER_NOTIFICATION_DISPLAY_READ:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Setting" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Tất cả",@"Chưa đọc", nil];
            break;
            
        case USER_NOTIFICATION_DISPLAY_UNREAD:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Setting" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Tất cả",@"Đã đọc", nil];
            break;
    }
    
    [sheet showInView:[GUIManager shareInstance].rootNavigation.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:@"Tất cả"])
    {
        [self showLoading];
        
        [self resetData];
        _displayType=USER_NOTIFICATION_DISPLAY_ALL;
        [self requestUserNotification];
    }
    else if([buttonTitle isEqualToString:@"Chưa đọc"])
    {
        [self showLoading];
        
        [self resetData];
        _displayType=USER_NOTIFICATION_DISPLAY_UNREAD;
        [self requestUserNotification];
    }
    else if([buttonTitle isEqualToString:@"Đã đọc"])
    {
        [self showLoading];
        
        [self resetData];
        _displayType=USER_NOTIFICATION_DISPLAY_READ;
        [self requestUserNotification];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationNewest class]])
    {
        ASIOperationUserNotificationNewest *ope=(ASIOperationUserNotificationNewest*) operation;
        
        if(refreshView.refreshState==REFRESH_VIEW_STATE_NORMAL)
        {
            [self.view removeLoading];
            
            _isLoadingMore=false;
            _canLoadMore=ope.userNotifications.count>=10;
            _page++;
            [_userNotification addObjectsFromArray:ope.userNotifications];
            
            [self reloadData];
            
            if(_page==0)
                [[NotificationManager shareInstance] requestNotificationCount];
        }
        else if(refreshView.refreshState==REFRESH_VIEW_STATE_REFRESHING)
        {
            _userNotificationFromAPI=[[NSMutableArray alloc] initWithArray:ope.userNotifications];
            
            [refreshView markRefreshDone:table];
        }
        
        _operationUserNotification=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserNotificationRemove class]])
    {
        [[NotificationManager shareInstance] requestNotificationCount];
    }
    else if([operation isKindOfClass:[ASIOperationNotificationCount class]])
    {
        [self finishedNotificationCount:(ASIOperationNotificationCount*)operation];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationNewest class]])
    {
        [self.view removeLoading];
        _operationUserNotification=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserNotificationRemove class]])
    {
        [[NotificationManager shareInstance] requestNotificationCount];
    }
    else if([operation isKindOfClass:[ASIOperationNotificationCount class]])
    {
        [self finishedNotificationCount:(ASIOperationNotificationCount*)operation];
    }
}

-(void) finishedNotificationCount:(ASIOperationNotificationCount*) operation
{
    _numberNotificationRead=_operationNotificationCount.number.integerValue;
    _totalNotificationRead=_operationNotificationCount.string;
    
#if DEBUG
//    _numberNotificationRead=10;
//    _numberNotificationUnread=10;
//    _totalNotificationUnread=@"10";
//    _totalNotificationRead=@"10";
#endif
    
    if(_numberNotificationUnread>0 || _numberNotificationRead>0)
    {
        NSMutableAttributedString *titleAttStr=[NSMutableAttributedString new];
        
        [titleAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"Thông báo " attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]
                                                                                                                , NSForegroundColorAttributeName:[UIColor whiteColor]}]];
        
        [titleAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"( " attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]
                                                                                                         , NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                                         , NSBaselineOffsetAttributeName:@(2)}]];
        
        NSString *displayTotal=[NSString stringWithFormat:@"%@/%@",_totalNotificationUnread,_totalNotificationRead];
        [titleAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:displayTotal attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13]
                                                                                                                 , NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                                                 , NSBaselineOffsetAttributeName:@(1.4f)}]];
        
        [titleAttStr appendAttributedString:[[NSAttributedString alloc] initWithString:@" )" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]
                                                                                                         , NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                                         , NSBaselineOffsetAttributeName:@(2)}]];
        
        lblTitle.attributedText=titleAttStr;
    }
    
    _operationNotificationCount=nil;
}

-(void)dealloc
{
    if(_operationUserNotification)
    {
        [_operationUserNotification clearDelegatesAndCancel];
        _operationUserNotification=nil;
    }
    
    [_userNotification removeAllObjects];
    _userNotification=nil;
}

-(void) makeData
{
    _userNotificationRead=[NSArray new];
    _userNotificationUnread=_userNotification;
    if(_userNotification.count>0)
    {
        _userNotificationUnread=[_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,NOTIFICATION_STATUS_UNREAD]];
        _userNotificationRead=[_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,NOTIFICATION_STATUS_READ]];
    }
    
    _isHasReadNotification=_userNotificationRead.count>0;
}

-(void) reloadData
{
    [self makeData];
    
    [table removeEmptyDataView];
    [table reloadData];
    
    if(_userNotification.count==0)
    {
        [table showEmptyDataViewWithText:@"Không có dữ liệu" textColor:[UIColor grayColor]];
        [table.emptyDataView l_v_setY:table.tableHeaderView.l_v_h+30];
    }
}

-(void)receiveRemoteNotification:(UserNotification *)obj
{
    return;
    [table beginUpdates];
    
    bool willAddSectionUnread=false;
    if(_userNotification.count==0)
    {
        willAddSectionUnread=true;
        [_userNotification addObject:obj];
    }
    else
        [_userNotification insertObject:obj atIndex:0];
    
    [self makeData];
    
    if(willAddSectionUnread)
    {
        [table insertSections:[NSIndexSet indexSetWithIndex:NOTIFICATION_STATUS_UNREAD] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        [table insertRowsAtIndexPaths:@[makeIndexPath(0, 0)] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [table endUpdates];
}

-(void)processRemoteNotification:(UserNotification *)obj
{
    [self resetData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[UserNotificationCell class]])
    {
        UserNotificationCell *cellNoti=(UserNotificationCell*) cell;
        [cellNoti tableWillDisplayCell];
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[UserNotificationCell class]])
    {
        UserNotificationCell *cellNoti=(UserNotificationCell*) cell;
        
        [cellNoti tableDidEndDisplayCell];
    }
}

@end