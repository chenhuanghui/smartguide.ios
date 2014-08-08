//
//  404ViewController.m
//  Infory
//
//  Created by XXX on 8/7/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "NotFound404ViewController.h"
#import "GUIManager.h"
#import "SGNavigationController.h"

@interface NotFound404ViewController ()

@end

@implementation NotFound404ViewController

- (instancetype)init
{
    self = [super initWithNibName:@"NotFound404ViewController" bundle:nil];
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

-(IBAction) btnBackTouchupInside:(id)sender
{
    [self.delegate notFound404ControllerTouchedBack:self];
}

@end