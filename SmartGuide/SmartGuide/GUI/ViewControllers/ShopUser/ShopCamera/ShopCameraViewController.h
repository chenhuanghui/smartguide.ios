//
//  ShopCameraViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopCameraViewController, SGNavigationController, UserGalleryUpload;

@protocol ShopCameraControllerDelegate <SGViewControllerDelegate>

-(void) shopCameraControllerDidUploadPhoto:(ShopCameraViewController*) controller upload:(UserGalleryUpload*) upload;

@end

@interface ShopCameraViewController : SGViewController
{
    __weak SGNavigationController *cameraNavi;
    __weak Shop *_shop;
    
    UserGalleryUpload *_currentUpload;
    
    bool _idPostDone;
}

-(ShopCameraViewController*) initWithShop:(Shop*) shop;

@property (nonatomic, weak) id<ShopCameraControllerDelegate> delegate;

@end
