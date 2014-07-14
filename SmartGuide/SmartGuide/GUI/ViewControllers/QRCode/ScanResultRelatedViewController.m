//
//  ScanResultRelatedViewController.m
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedViewController.h"

@interface ScanResultRelatedViewController ()

@end

@implementation ScanResultRelatedViewController

-(ScanResultRelatedViewController *)initWithRelatedContain:(ScanCodeRelatedContain *)object
{
    self=[super initWithNibName:@"ScanResultRelatedViewController" bundle:nil];
    
    _relatedContain=object;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    [self.delegate scanResultRelatedControllerTouchedBack:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
