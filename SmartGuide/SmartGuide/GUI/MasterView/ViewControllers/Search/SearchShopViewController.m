//
//  SearchShopViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SearchShopViewController.h"

@interface SearchShopViewController ()

@end

@implementation SearchShopViewController

- (id)init
{
    self = [super initWithNibName:@"SearchShopViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.layer.masksToBounds=true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
