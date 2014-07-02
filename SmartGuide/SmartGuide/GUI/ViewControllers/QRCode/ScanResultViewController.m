//
//  ScanResultViewController.m
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultViewController.h"

@interface ScanResultViewController ()

@end

@implementation ScanResultViewController

-(ScanResultViewController *)initWithCode:(NSString *)code
{
    self=[super initWithNibName:@"ScanResultViewController" bundle:nil];
    
    _code=code;
    
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

@end

@implementation ScanResult

-(enum SCAN_RESULT_TYPE)enumType
{
    switch ((enum SCAN_RESULT_TYPE)self.type) {
        case SCAN_RESULT_TYPE_PLACELIST:
            return SCAN_RESULT_TYPE_PLACELIST;
            
        case SCAN_RESULT_TYPE_PROMOTION:
            return SCAN_RESULT_TYPE_PROMOTION;
            
        case SCAN_RESULT_TYPE_SHOP:
            return SCAN_RESULT_TYPE_SHOP;
            
        case SCAN_RESULT_TYPE_UNKNOW:
            return SCAN_RESULT_TYPE_UNKNOW;
    }
    
    return SCAN_RESULT_TYPE_UNKNOW;
}

@end