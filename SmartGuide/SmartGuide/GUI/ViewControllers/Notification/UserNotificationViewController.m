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

@interface UserNotificationViewController ()<UITableViewDataSource,UITableViewDelegate,UserNotificationCellDelegate,ASIOperationPostDelegate>

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
    [[DataManager shareInstance] save];
    
    _displayType=USER_NOTIFICATION_DISPLAY_ALL;
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    _userNotification=[NSMutableArray new];
    _userNotificationRead=[NSArray new];
    _userNotificationUnread=[NSArray new];
    
    _isLoadingMore=false;
    _canLoadMore=true;
    _page=-1;
    _isHasReadNotification=false;
    
    [self requestUserNotification];
    
    [table showLoading];
}

-(void) requestUserNotification
{
    if(_operationUserNotification)
    {
        [_operationUserNotification clearDelegatesAndCancel];
        _operationUserNotification=nil;
    }
    
    _operationUserNotification=[[ASIOperationUserNotification alloc] initWithPage:_page+1 userLat:userLat() userLng:userLng() type:_displayType];
    _operationUserNotification.delegatePost=self;
    
    [_operationUserNotification startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
        case USER_NOTIFICATION_STATUS_UNREAD:
            return [self userNotificationUnread].count+((!_isHasReadNotification && _canLoadMore)?1:0);
            
        case USER_NOTIFICATION_STATUS_READ:
            return [self userNotificationRead].count+(_canLoadMore?1:0);
            
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
            if(indexPath.section==USER_NOTIFICATION_STATUS_READ && indexPath.row==[self userNotificationRead].count)
            {
                if(!_isLoadingMore)
                {
                    _isLoadingMore=true;
                    
                    [self requestUserNotification];
                    
                    return [tableView loadingMoreCell];
                }
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
                    
                    return [tableView loadingMoreCell];
                }
            }
        }
    }
    
    UserNotificationCell *cell=(UserNotificationCell*)[tableView dequeueReusableCellWithIdentifier:[UserNotificationCell reuseIdentifier]];
    cell.delegate=self;
    
    switch (indexPath.section) {
            
        case USER_NOTIFICATION_STATUS_UNREAD:
            [cell loadWithUserNotification:[self userNotificationUnread][indexPath.row]];
            break;
            
        case USER_NOTIFICATION_STATUS_READ:
            [cell loadWithUserNotification:[self userNotificationRead][indexPath.row]];
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserNotificationCell *cell=(UserNotificationCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [self showUserNotificationDetail:cell.userNotification];
}

-(void)userNotificationCellTouchedDetail:(UserNotificationCell *)cell obj:(UserNotification *)obj
{
    [self showUserNotificationDetail:obj];
}

-(void) showUserNotificationDetail:(UserNotification*) obj
{
    UserNotificationDetailViewController *vc=[[UserNotificationDetailViewController alloc] initWithUserNotification:obj];
    
    [self.navigationController pushViewController:vc animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore)
    {
        if(_isHasReadNotification)
        {
            if(indexPath.section==USER_NOTIFICATION_STATUS_READ && indexPath.row==[self userNotificationRead].count)
                return 77;
        }
        else
        {
            if(indexPath.row==[self userNotificationUnread].count)
                return 77;
        }
    }
    
    switch (indexPath.section) {
        case USER_NOTIFICATION_STATUS_UNREAD:
            return [UserNotificationCell heightWithUserNotification:[self userNotificationUnread][indexPath.row]];
            
        case USER_NOTIFICATION_STATUS_READ:
            return [UserNotificationCell heightWithUserNotification:[self userNotificationRead][indexPath.row]];
            
        default:
            return 0;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case USER_NOTIFICATION_STATUS_READ:
            return [UserNotificationHeaderView height];
            
        default:
            return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case USER_NOTIFICATION_STATUS_READ:
            return [UserNotificationHeaderView new];
            
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
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotification class]])
    {
        [table removeLoading];
        
        ASIOperationUserNotification *ope=(ASIOperationUserNotification*) operation;
        
        [_userNotification addObjectsFromArray:ope.userNotifications];
        
        _isLoadingMore=false;
        _canLoadMore=ope.userNotifications.count==10;
        _page++;
        
        if(!_isHasReadNotification && _userNotification.count>0)
        {
            _isHasReadNotification=[_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,USER_NOTIFICATION_STATUS_READ]].count>0;
        }
        
        [self reloadData];
        
        _operationUserNotification=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotification class]])
    {
        [table removeLoading];
        _operationUserNotification=nil;
    }
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

-(void) reloadData
{
    _userNotificationRead=[NSArray new];
    _userNotificationUnread=_userNotification;
    if(_userNotification.count>0)
    {
        _userNotificationUnread=[_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,USER_NOTIFICATION_STATUS_UNREAD]];
        _userNotificationRead=[_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,USER_NOTIFICATION_STATUS_READ]];
    }
    
    [table reloadData];
}

@end