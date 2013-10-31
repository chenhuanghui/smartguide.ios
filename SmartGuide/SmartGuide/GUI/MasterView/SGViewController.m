//
//  SGViewController.m
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@interface SGViewController ()

@end

@implementation SGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for(NSString *notification in [self registerNotifications])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:notification object:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)registerNotifications
{
    return @[];
}

-(void)receiveNotification:(NSNotification *)notification
{
    
}

-(void)dealloc
{
    for (NSString *notification in [self registerNotifications]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notification object:nil];
    }
    
    DEALLOC_LOG
}

@end
