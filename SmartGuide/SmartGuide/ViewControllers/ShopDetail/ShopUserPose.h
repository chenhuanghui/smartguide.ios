//
//  ShopUserPose.h
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ASIOperationUploadUserGallery.h"
#import "ShopUserGallery.h"
#import "FacebookManager.h"

@class ShopUserPose;

@protocol ShopUserPoseDelegate <NSObject>

-(void) shopUserPostFinished:(ShopUserPose*) userPose userGallery:(ShopUserGallery*) userGallery;
-(void) shopUserPostCancelled:(ShopUserPose*) userPose;

@end

@interface ShopUserPose : UIView<ASIOperationPostDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIButton *btnFace;
    __weak IBOutlet UITextView *txt;
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIButton *btnSend;
    __weak IBOutlet UIView *containView;
    
    __weak Shop *_shop;
    
    bool _isSharedFacebook;
    
    __weak UIViewController *_viewController;
    UIView *_rootView;
}

-(ShopUserPose*) initWithViewController:(UIViewController*) viewController shop:(Shop*) shop;
-(void) show;

-(void) setImage:(UIImage*) image shop:(Shop*) shop;

@property (nonatomic, assign) id<ShopUserPoseDelegate> delegate;

@end
