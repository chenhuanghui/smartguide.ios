//
//  ShopCategoriesViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedViewController.h"
#import "GUIManager.h"

@interface NewFeedViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txt.l_v_h)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    [table registerNib:[UINib nibWithNibName:[NewFeedPromotionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedPromotionCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[NewFeedImagesCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedImagesCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[NewFeedListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedListCell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[NewFeedInfoCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[NewFeedInfoCell reuseIdentifier]];
    
    _page=-1;
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
        _canLoadMore=ope.homes.count==5;
        _isLoadingMore=false;
        _page++;
        
        [table reloadData];
        
        _operationUserHome=nil;
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
    return _homes.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _homes.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
            return [NewFeedListCell height];
            
        case USER_HOME_TYPE_6:
            return [NewFeedInfoCell heightWithHome6:home.home6];
            
        case USER_HOME_TYPE_7:
            return [NewFeedInfoCell heightWithHome7:home.home7];
            
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserHome *home=_homes[indexPath.row];
    
    switch (home.enumType) {
        case USER_HOME_TYPE_1:
        {
            NewFeedPromotionCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedPromotionCell reuseIdentifier]];
            
            return cell;
        }
            
        case USER_HOME_TYPE_2:
        {
            NewFeedImagesCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedImagesCell reuseIdentifier]];
            
            return cell;
        }
            
        case USER_HOME_TYPE_3:
        {
            NewFeedListCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListCell reuseIdentifier]];
            
            return cell;
        }
        case USER_HOME_TYPE_4:
        {
            NewFeedListCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListCell reuseIdentifier]];
            
            return cell;
        }
        case USER_HOME_TYPE_5:
        {
            NewFeedListCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedListCell reuseIdentifier]];
            
            return cell;
        }
            
        case USER_HOME_TYPE_6:
        {
            NewFeedInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedInfoCell reuseIdentifier]];
            
            return cell;
        }
            
        case USER_HOME_TYPE_7:
        {
            NewFeedInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:[NewFeedInfoCell reuseIdentifier]];
            
            return cell;
        }
            
        default:
            return 0;
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserHome *home=_homes[indexPath.row];
    switch (home.enumType) {
        case USER_HOME_TYPE_1:
        {
            
        }
            break;
            
        case USER_HOME_TYPE_2:
        {
            
        }
            break;
            
        case USER_HOME_TYPE_3:
        {
            
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
            
        default:
            break;
    }
}

@end
