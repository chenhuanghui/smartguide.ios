//
//  ShopCameraViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "ShopCameraTakeViewController.h"
#import "ShopCameraPostViewController.h"
#import "UserUploadGalleryManager.h"

@class ShopCameraViewController;

@protocol ShopCameraControllerDelegate <SGViewControllerDelegate>

-(void) shopCameraControllerDidUploadPhoto:(ShopCameraViewController*) controller;

@end

@interface ShopCameraViewController : SGViewController<ShopCameraTakeDelegate,ShopCameraPostDelegae>
{
    __weak SGNavigationController *cameraNavi;
    __weak Shop *_shop;
    
    UserGalleryUpload *_currentUpload;
}

-(ShopCameraViewController*) initWithShop:(Shop*) shop;

@property (nonatomic, weak) id<ShopCameraControllerDelegate> delegate;

@end
