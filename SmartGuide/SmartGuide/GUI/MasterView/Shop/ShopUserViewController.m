//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"
#import "GUIManager.h"

@interface ShopUserViewController ()

@end

@implementation ShopUserViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"ShopUserViewController" bundle:nil];
    if (self) {
        
    }
    return self;
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
- (IBAction)like:(id)sender {
    [[GUIManager shareInstance] showLoginDialogWithMessage:@"LOGIN TO LIKE" onCompleted:^(bool isLogined) {
        [AlertView showAlertOKWithTitle:nil withMessage:[NSString stringWithFormat:@"LOGINED %i",isLogined] onOK:nil];
    }];
}

@end
