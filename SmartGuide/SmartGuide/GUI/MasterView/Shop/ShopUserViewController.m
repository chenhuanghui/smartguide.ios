//
//  ShopUserViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserViewController.h"

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

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
