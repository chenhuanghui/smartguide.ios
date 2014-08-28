//
//  TabInboxListViewController.m
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabInboxListViewController.h"
#import "OperationMessageList.h"
#import "MessageList.h"
#import "MessageAction.h"
#import "MessageSender.h"
#import "TableTemplates.h"
#import "NavigationView.h"

@interface TabInboxListViewController ()

@end

@implementation TabInboxListViewController

-(TabInboxListViewController *)initWithSender:(MessageSender *)sender
{
    self=[super init];
    
    _sender=sender;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
