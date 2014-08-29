//
//  TabUserViewController.m
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TabUserViewController.h"
#import "ImageManager.h"
#import "DataManager.h"

@interface TabUserViewController ()

@end

@implementation TabUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [imgvAvatar defaultLoadImageWithURL:currentUser().avatar];
    imgvAvatar.layer.borderColor=[UIColor lightGrayColor].CGColor;
    imgvAvatar.layer.borderWidth=8;
    lblName.text=currentUser().name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
