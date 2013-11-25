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
@synthesize delegate;

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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_isShowed)
        [self.delegate qrcodeControllerRequestClose:self];
    else
        [self.delegate qrcodeControllerRequestShow:self];
    
    _isShowed=!_isShowed;
}

- (IBAction)qr:(id)sender {
    [self.delegate qrcodeControllerRequestClose:self];
}

@end
