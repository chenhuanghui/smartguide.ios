//
//  ShopCameraViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopCameraTakeViewController;

@protocol ShopCameraTakeDelegate <SGViewControllerDelegate>

-(void) shopCameraTakeDidCapture:(ShopCameraTakeViewController*) controller image:(UIImage*) image;

@end

@interface ShopCameraTakeViewController : SGViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImagePickerController *camera;
    __weak IBOutlet UILabel *lblFlashStatus;
    __weak IBOutlet UIView *cameraView;
}

@property (nonatomic, weak) id<ShopCameraTakeDelegate> delegate;
@property (nonatomic, assign) UIImagePickerControllerCameraFlashMode flashMode;

@end
