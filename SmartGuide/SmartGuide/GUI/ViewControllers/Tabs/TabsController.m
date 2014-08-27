//
//  TabsController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabsController.h"
#import "TabHomeViewController.h"
#import "TabInboxViewController.h"
#import "TabSearchViewController.h"
#import "TabUserViewController.h"
#import "TabScanViewController.h"
#import "NavigationController.h"

@interface TabsController ()

@end

@implementation TabsController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBar.hidden=true;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    TabHomeViewController *tabHome=[TabHomeViewController new];
    TabSearchViewController *tabSearch=[TabSearchViewController new];
    TabScanViewController *tabScan=[TabScanViewController new];
    TabInboxViewController *tabInbox=[TabInboxViewController new];
    TabUserViewController *tabUser=[TabUserViewController new];
    
    NavigationController *nav1=[[NavigationController alloc] initWithRootViewController:tabHome];
    NavigationController *nav2=[[NavigationController alloc] initWithRootViewController:tabSearch];
    NavigationController *nav3=[[NavigationController alloc] initWithRootViewController:tabScan];
    NavigationController *nav4=[[NavigationController alloc] initWithRootViewController:tabInbox];
    NavigationController *nav5=[[NavigationController alloc] initWithRootViewController:tabUser];
    
    _tabHome=nav1;
    _tabSearch=nav2;
    _tabScan=nav3;
    _tabInbox=nav4;
    _tabUser=nav5;
    
    self.viewControllers=@[nav1, nav2, nav3, nav4, nav5];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
