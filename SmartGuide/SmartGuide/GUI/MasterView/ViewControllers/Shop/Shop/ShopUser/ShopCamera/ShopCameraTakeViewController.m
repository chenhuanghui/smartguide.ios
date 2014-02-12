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
    
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;

    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    picker.showsCameraControls=false;
    picker.navigationBarHidden=true;
    picker.toolbarHidden=true;
    
    [picker l_v_setS:self.l_v_s];
    
    [self presentModalViewController:picker animated:false];
    picker.cameraOverlayView=self.view;
    
    camera=picker;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTakePictureTouchUpInside:(id)sender {
    [camera takePicture];
    
    [self.delegate shopCameraTakeDidCapture:self image:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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
            camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
            break;
            
        case UIImagePickerControllerCameraFlashModeAuto:
            camera.cameraFlashMode=UIImagePickerControllerCameraFlashModeOff;
    }
}

@end
