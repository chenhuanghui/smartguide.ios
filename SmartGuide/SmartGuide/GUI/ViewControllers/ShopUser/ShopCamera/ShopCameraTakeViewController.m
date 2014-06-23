//
//  ShopCameraViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopCameraTakeViewController.h"

@interface ShopCameraTakeViewController ()

@end

@implementation ShopCameraTakeViewController

- (id)init
{
    self = [super initWithNibName:@"ShopCameraTakeViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;

#if TARGET_IPHONE_SIMULATOR
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
#else
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
    picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    picker.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    picker.showsCameraControls=false;
#endif
    picker.navigationBarHidden=true;
    picker.toolbarHidden=true;
    
    [picker l_v_setS:cameraView.l_v_s];
    [cameraView addSubview:picker.view];
    picker.view.autoresizingMask=UIViewAutoresizingAll();
    
    camera=picker;
    
    [self makeFlashStatus];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) makeFlashStatus
{
#if !TARGET_IPHONE_SIMULATOR
    switch (picker.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeAuto:
            lblFlashStatus.text=@"Auto";
            break;
            
        case UIImagePickerControllerCameraFlashModeOff:
            lblFlashStatus.text=@"Off";
            break;
            
        case UIImagePickerControllerCameraFlashModeOn:
            lblFlashStatus.text=@"On";
            break;
    }
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTakePictureTouchUpInside:(id)sender {
    [camera takePicture];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img=info[UIImagePickerControllerOriginalImage];
    
    [self.delegate shopCameraTakeDidCapture:self image:img];
}

- (IBAction)btnSwitchCameraTouchUpInside:(id)sender {
    switch (camera.cameraDevice) {
        case UIImagePickerControllerCameraDeviceFront:
            camera.cameraDevice=UIImagePickerControllerCameraDeviceRear;
            break;
            
        case UIImagePickerControllerCameraDeviceRear:
            camera.cameraDevice=UIImagePickerControllerCameraDeviceFront;
            break;
    }
}

- (IBAction)btnFlashTouchUpInside:(id)sender {
    
    switch (camera.cameraFlashMode) {
        case UIImagePickerControllerCameraFlashModeOn:
            camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeOff;
            break;
            
        case UIImagePickerControllerCameraFlashModeOff:
            camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
            break;
            
        case UIImagePickerControllerCameraFlashModeAuto:
            camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
            break;
    }
    
    [self makeFlashStatus];
}

@end
