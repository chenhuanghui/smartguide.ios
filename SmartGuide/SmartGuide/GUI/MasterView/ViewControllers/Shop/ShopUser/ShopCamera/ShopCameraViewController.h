//
//  ShopCameraViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@interface ShopCameraViewController : SGViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    __weak UIImagePickerController *camera;
}

@end
