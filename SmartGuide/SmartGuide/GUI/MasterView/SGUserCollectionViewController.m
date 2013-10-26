//
//  SGUserCollectionViewController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserCollectionViewController.h"

@interface SGUserCollectionViewController ()

@end

@implementation SGUserCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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

- (IBAction)btn:(id)sender {
    ShopUserViewController *vc=[[ShopUserViewController alloc] init];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)shopUserFinished
{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
