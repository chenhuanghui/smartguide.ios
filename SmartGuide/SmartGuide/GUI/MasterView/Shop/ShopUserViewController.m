//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"

static ShopUserViewController *_shopUser=nil;
@interface ShopUserViewController ()

@end

@implementation ShopUserViewController
@synthesize delegate;

+(ShopUserViewController *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shopUser=[[ShopUserViewController alloc] init];
    });
    
    return _shopUser;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setShop:(Shop *)shop
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn:(id)sender {
    [self.delegate shopUserFinished];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
