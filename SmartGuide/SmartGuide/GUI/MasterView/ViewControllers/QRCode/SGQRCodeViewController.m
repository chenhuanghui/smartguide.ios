//
//  SGQRCodeViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGQRCodeViewController.h"

@interface SGQRCodeViewController ()

@end

@implementation SGQRCodeViewController
@synthesize delegate,containView,containViewFrame;

- (id)init
{
    self = [super initWithNibName:@"SGQRCodeViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _isShowed=false;
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

-(void)setContainView:(UIView *)_containView
{
    containView=_containView;   
    containViewFrame=containView.frame;
}

@end

#import <objc/runtime.h>

static char SGQRControllerObjectKey;

@implementation SGViewController(QRCode)

-(void)setQrController:(SGQRCodeViewController *)qrController
{
    objc_setAssociatedObject(self, &SGQRControllerObjectKey, qrController, OBJC_ASSOCIATION_ASSIGN);
}

-(SGQRCodeViewController *)qrController
{
    return objc_getAssociatedObject(self, &SGQRControllerObjectKey);
}

-(void)showQRCodeWithContorller:(SGViewController<SGQRCodeControllerDelegate> *)controller inView:(UIView *)view
{
    SGQRCodeViewController *qr=[SGQRCodeViewController new];
    qr.delegate=controller;
    qr.containView=view;
    [controller setQrController:qr];
    
    [controller addChildViewController:qr];
    [view addSubview:qr.view];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [view l_v_setO:CGPointZero];
    }];
}

-(void)hideQRCode
{
    if(self.qrController)
    {
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            self.qrController.containView.frame=self.qrController.containViewFrame;
        } completion:^(BOOL finished) {
            [self.qrController.view removeFromSuperview];
            [self.qrController removeFromParentViewController];
            self.qrController=nil;
        }];
    }
}

@end