//
//  SGSearchController.m
//  SmartGuide
//
//  Created by MacMini on 25/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGShopSearchController.h"

@interface SGShopSearchController ()

@end

@implementation SGShopSearchController

- (id)init
{
    self = [super initWithNibName:@"SGShopSearchController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addChildViewController:self.childNavigationController];
    [contentView addSubview:self.childNavigationController.view];
    
    CGRect rect=contentView.frame;
    rect.origin=CGPointZero;
    
    self.childNavigationController.view.frame=rect;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate shopSearchControllerTouchedSetting:self];
}

- (IBAction)btnCancelTouchUpInside:(id)sender {
    [self hideSearchView];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self showSearchView];
    return true;
}

-(void) showSearchView
{
    displaySearchView.alpha=0;
    displaySearchView.hidden=false;
    btnCancel.alpha=0;
    btnCancel.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        displaySearchView.alpha=1;
        btnCancel.alpha=1;
        btnSetting.alpha=0;
    } completion:^(BOOL finished) {
        btnSetting.hidden=true;
    }];
}

-(void) hideSearchView
{
    btnSetting.alpha=0;
    btnSetting.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        displaySearchView.alpha=0;
        btnCancel.alpha=0;
        btnSetting.alpha=1;
    } completion:^(BOOL finished) {
        btnCancel.hidden=true;
        displaySearchView.hidden=true;
    }];
}

@end
