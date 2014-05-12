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

@interface UserNotificationDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate,UserNotificationDetailCellDelegate>

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
    
    [UserNotificationContent markDeleteAllObjects];
    [[DataManager shareInstance] save];
    
    _canLoadMore=true;
    _isLoadingMore=false;
    _page=-1;
    _userNotificationContents=[NSMutableArray new];
    
    [table registerNib:[UINib nibWithNibName:[UserNotificationDetailCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[UserNotificationDetailCell reuseIdentifier]];
    [table registerLoadingMoreCell];
    
    [self requestNotification];
    [table showLoading];
}

-(void) requestNotification
{
    if(_operationNotificationContent)
    {
        [_operationNotificationContent clearDelegatesAndCancel];
        _operationNotificationContent=nil;
    }
    
    _operationNotificationContent=[[ASIOperationUserNotificationContent alloc] initWithIDNotification:_obj.idNotification.integerValue page:_page+1 userLat:userLat() userLng:userLng()];
    _operationNotificationContent.delegatePost=self;
    
    [_operationNotificationContent startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationContent class]])
    {
        [table removeLoading];
        
        ASIOperationUserNotificationContent *ope=(ASIOperationUserNotificationContent*) operation;
        
        [_userNotificationContents addObjectsFromArray:ope.notifications];
        _canLoadMore=ope.notifications.count==10;
        _isLoadingMore=false;
        _page++;
        
        [table reloadData];
        
        _operationNotificationContent=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUserNotificationContent class]])
    {
        [table removeLoading];
        
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
    
    return [UserNotificationDetailCell heightWithUserNotificationDetail:_userNotificationContents[indexPath.row]];
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
    
    UserNotificationDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:[UserNotificationDetailCell reuseIdentifier]];
    
    [cell loadWithUserNotificationDetail:_userNotificationContents[indexPath.row]];
    cell.delegate=self;
    
    return cell;
}

+(NSString *)screenCode
{
    return @"S00601";
}

-(void)userNotificationDetailCellTouchedGo:(UserNotificationDetailCell *)cell userNotificationDetail:(UserNotificationContent *)obj
{
    [SGData shareInstance].fScreen=@"S00601";
    
//    switch (obj.enumActionType) {
//        case USER_NOTIFICATION_CONTENT_TYPE_SHOP_DETAIL:
//            [[GUIManager shareInstance].rootViewController presentShopUserWithIDShop:obj.idShop.integerValue];
//            break;
//            
//        case USER_NOTIFICATION_CONTENT_TYPE_SHOP_LIST:
//            
//            if(obj.idPlacelist)
//                [[GUIManager shareInstance].rootViewController showShopListWithIDPlace:obj.idPlacelist.integerValue];
//            else if(obj.keywords.length>0)
//                [[GUIManager shareInstance].rootViewController showShopListWithKeywords:obj.keywords];
//            else if(obj.idShops.length>0)
//                [[GUIManager shareInstance].rootViewController showShopListWithIDShops:obj.idShops];
//            
//            break;
//            
//        case USER_NOTIFICATION_CONTENT_TYPE_TUTORIAL:
//            if(obj.urlTutorial.length>0)
//                [[GUIManager shareInstance].rootViewController showWebviewWithURL:URL(obj.urlTutorial)];
//            break;
//            
//        case USER_NOTIFICATION_CONTENT_TYPE_NONE:
//            break;
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
