//
//  SGRootViewController.m
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGRootViewController.h"

@interface SGRootViewController ()

@end

@implementation SGRootViewController
@synthesize containFrame,toolbarFrame,contentFrame,qrCodeFrame,adsFrame;

- (id)initWithDelegate:(id<SGViewControllerDelegate>)_delegate
{
    self = [super initWithNibName:@"SGRootViewController" bundle:nil];
    if (self) {
        self.delegate=_delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    containFrame=self.containView.frame;
    toolbarFrame=self.toolbarView.frame;
    contentFrame=self.contentView.frame;
    qrCodeFrame=self.qrCodeView.frame;
    adsFrame=self.adsView.frame;
    
    self.containView.layer.masksToBounds=true;
    self.toolbarView.layer.masksToBounds=true;
    self.contentView.layer.masksToBounds=true;
    self.qrCodeView.layer.masksToBounds=true;
    self.adsView.layer.masksToBounds=true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
