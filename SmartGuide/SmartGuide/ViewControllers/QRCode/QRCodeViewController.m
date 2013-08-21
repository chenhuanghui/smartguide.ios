//
//  QRCodeViewController.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.showsZBarControls=false;
    self.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    self.wantsFullScreenLayout=false;
    self.readerDelegate=self;
    self.showsCameraControls=false;
    self.supportedOrientationsMask=ZBarOrientationMask(UIInterfaceOrientationPortrait);
    
    [scanner setSymbology:ZBAR_I25|ZBAR_QRCODE
                   config: ZBAR_CFG_ENABLE
                       to: 0];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry
{
    NSLog(@"readerControllerDidFailToRead");
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id <NSFastEnumeration> syms = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *sym;
    for(sym in syms) {
        break;
    }
    
    if(delegate)
        [delegate qrCodeCaptureImage:[info objectForKey:UIImagePickerControllerOriginalImage] text:sym.data];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}

@end
