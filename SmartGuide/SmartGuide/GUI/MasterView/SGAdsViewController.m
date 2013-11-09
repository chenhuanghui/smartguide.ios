//
//  SGAdsViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGAdsViewController.h"

@interface SGAdsViewController ()

@end

@implementation SGAdsViewController

- (id)init
{
    self = [super initWithNibName:@"SGAdsViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadAds
{
    if(_operationAds)
    {
        [_operationAds cancel];
        _operationAds=nil;
    }
    
    _operationAds=[[ASIOperationGetAds alloc] initAds];
    _operationAds.delegatePost=self;
    
    [_operationAds startAsynchronous];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    _operationAds=nil;
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    _operationAds=nil;
}

@end
