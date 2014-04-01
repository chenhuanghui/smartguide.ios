//
//  NotificationDetailViewController.m
//  Infory
//
//  Created by XXX on 3/31/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "UserNotificationDetailViewController.h"
#import "UserNotificationDetailCell.h"

@interface UserNotificationDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserNotificationDetailViewController

-(UserNotificationDetailViewController *)initWithUserNotification:(UserNotification *)obj
{
    self=[super initWithNibName:@"UserNotificationDetailViewController" bundle:nil];
    
    _obj=obj;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _userNotificationDetails=[NSMutableArray new];
    
    for(int i=0;i<10;i++)
    {
        UserNotificationDetail *obj=[UserNotificationDetail temporary];
        
        obj.sortOrder=@(i);
        
        [_userNotificationDetails addObject:obj];
    }
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationDetailCell reuseIdentifier]];
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
    return _userNotificationDetails.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _userNotificationDetails.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UserNotificationDetailCell heightWithUserNotificationDetail:_userNotificationDetails[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserNotificationDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:[UserNotificationDetailCell reuseIdentifier]];
    
    [cell loadWithUserNotificationDetail:_userNotificationDetails[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
