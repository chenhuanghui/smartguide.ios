//
//  ShopCameraPostViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopCameraPostViewController;

@protocol ShopCameraPostDelegae <SGViewControllerDelegate>

-(void) shopCameraControllerDidSend:(ShopCameraPostViewController*) controller;

@end

@interface ShopCameraPostViewController : SGViewController

-(ShopCameraPostViewController*) initWithImage:(UIImage*) image;

@end
