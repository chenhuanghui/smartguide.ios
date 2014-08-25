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
    
    _tabHome=tabHome;
    _tabSearch=tabSearch;
    _tabScan=tabScan;
    _tabInbox=tabInbox;
    _tabUser=tabUser;
    
    self.viewControllers=@[tabHome, tabSearch, tabScan, tabInbox, tabUser];
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
