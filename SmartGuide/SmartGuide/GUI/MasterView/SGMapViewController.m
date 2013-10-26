//
//  SGMapViewController.m
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGMapViewController.h"

@interface SGMapViewController ()

@end

@implementation SGMapViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"SGMapViewController" bundle:nil];
    if (self) {
        
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

-(void)dealloc
{
    NSLog(@"dealloc %@", CLASS_NAME);
}

@end
