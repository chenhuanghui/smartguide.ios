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

@interface UserNotificationViewController ()<UITableViewDataSource,UITableViewDelegate,UserNotificationCellDelegate>

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
    
    _displayType=USER_NOTIFICATION_DISPLAY_ALL;
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationCell reuseIdentifier]];
    
    _userNotification=[NSMutableArray new];
    for(int i=0;i<10;i++)
    {
        UserNotification *obj=[UserNotification temporary];
        obj.sortOrder=@(i);
        obj.status=@(rand()%2==0);
        
        [_userNotification addObject:obj];
    }
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
            return 2;
            
        case USER_NOTIFICATION_DISPLAY_READ:
        case USER_NOTIFICATION_DISPLAY_UNREAD:
            return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_displayType) {
        case USER_NOTIFICATION_DISPLAY_ALL:
            
            if(section==0)
                return [self userNotificationUnread].count;
            else if(section==1)
                return [self userNotificationRead].count;
            else
                return 0;
            
        case USER_NOTIFICATION_DISPLAY_UNREAD:
            return [self userNotificationUnread].count;
            
        case USER_NOTIFICATION_DISPLAY_READ:
            return [self userNotificationRead].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserNotificationCell *cell=(UserNotificationCell*)[tableView dequeueReusableCellWithIdentifier:[UserNotificationCell reuseIdentifier]];
    cell.delegate=self;
    
    switch (indexPath.section) {
        case USER_NOTIFICATION_STATUS_READ:
            [cell loadWithUserNotification:[self userNotificationRead][indexPath.row]];
            break;

        case USER_NOTIFICATION_STATUS_UNREAD:
            [cell loadWithUserNotification:[self userNotificationUnread][indexPath.row]];
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)userNotificationCellTouchedDetail:(UserNotificationCell *)cell obj:(UserNotification *)obj
{
    UserNotificationDetailViewController *vc=[[UserNotificationDetailViewController alloc] initWithUserNotification:obj];
    
    [self.navigationController pushViewController:vc animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_displayType) {
        case USER_NOTIFICATION_DISPLAY_ALL:
            
            switch (indexPath.section) {
                case USER_NOTIFICATION_STATUS_READ:
                    return [UserNotificationCell heightWithUserNotification:[self userNotificationRead][indexPath.row]];
                    
                case USER_NOTIFICATION_STATUS_UNREAD:
                    return [UserNotificationCell heightWithUserNotification:[self userNotificationUnread][indexPath.row]];
            }
            
        case USER_NOTIFICATION_DISPLAY_UNREAD:
            return [self userNotificationUnread].count;
            
        case USER_NOTIFICATION_DISPLAY_READ:
            return [self userNotificationRead].count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (_displayType) {
        case USER_NOTIFICATION_DISPLAY_ALL:
            if(section==USER_NOTIFICATION_STATUS_READ)
                return [UserNotificationHeaderView height];
            break;
            
        default:
            return 0;
    }
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (_displayType) {
        case USER_NOTIFICATION_DISPLAY_ALL:
            if(section==USER_NOTIFICATION_STATUS_READ)
            {
                return [UserNotificationHeaderView new];
            }
            break;
            
        default:
            break;
    }
    
    return [UIView new];
}

-(NSArray*) userNotificationUnread
{
    if(_userNotification.count>0)
        return [_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,USER_NOTIFICATION_STATUS_UNREAD]]?:[NSArray array];
    
    return [NSArray array];
}

-(NSArray*) userNotificationRead
{
    if(_userNotification.count>0)
        return [_userNotification filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K==%i",UserNotification_Status,USER_NOTIFICATION_STATUS_READ]]?:[NSArray array];
    
    return [NSArray array];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    
}

@end