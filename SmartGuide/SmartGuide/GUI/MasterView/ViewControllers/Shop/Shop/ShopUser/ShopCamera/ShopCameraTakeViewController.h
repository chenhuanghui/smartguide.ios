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
    __weak UIImagePickerController *camera;
    UIImagePickerController *picker;
    __weak IBOutlet UILabel *lblFlashStatus;
}

@property (nonatomic, weak) id<ShopCameraTakeDelegate> delegate;

@end
