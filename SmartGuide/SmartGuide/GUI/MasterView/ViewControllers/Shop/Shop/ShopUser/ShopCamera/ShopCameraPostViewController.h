//
//  ShopCameraPostViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "HPGrowingTextView.h"
#import "ASIOperationUploadUserGallery.h"
#import "Shop.h"

@class ShopCameraPostViewController;

@protocol ShopCameraPostDelegae <SGViewControllerDelegate>

-(void) shopCameraControllerDidSend:(ShopCameraPostViewController*) controller;

@end

@interface ShopCameraPostViewController : SGViewController<HPGrowingTextViewDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UIImageView *imgvBG;
    __weak IBOutlet UIImageView *imgvPhoto;
    __weak IBOutlet UIButton *btnSend;
    __weak IBOutlet UIButton *btnShare;
    __weak IBOutlet HPGrowingTextView *txt;
    
    UIImage *_img;
    ASIOperationUploadUserGallery *_operation;
    __weak Shop *_shop;
}

-(ShopCameraPostViewController*) initWithShop:(Shop*) shop image:(UIImage*) image;

@property (nonatomic, weak) id<ShopCameraPostDelegae> delegate;

@end
