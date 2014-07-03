//
//  ScanCodeController.h
//  Infory
//
//  Created by XXX on 6/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGNavigationController, ScanCodeController;

@protocol ScanCodeControllerDelegate <SGViewControllerDelegate>

@optional
-(void) scanCodeControllerTouchedClose:(ScanCodeController*) controller;
-(void) scanCodeController:(ScanCodeController*) controller scannedURL:(NSURL*) url;

@end

@interface ScanCodeController : SGViewController
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIImageView *imgvScanTop;
    __weak IBOutlet UIImageView *imgvScanBot;
    __weak IBOutlet UIImageView *imgvScan;
    __weak IBOutlet UIButton *btnClose;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *botView;
    
    __strong SGNavigationController *_navi;
}

-(void) closeScanOnCompleted:(void(^)()) completed;

@property (nonatomic, assign) enum SCANCODE_ANIMATION_TYPE scanAnimationType;
@property (nonatomic, weak) id<ScanCodeControllerDelegate> delegate;

@end

@interface UIViewController(ScanCode)

-(void) showScanCodeWithDelegate:(id<ScanCodeControllerDelegate>) delegate;
-(void) showScanCodeWithDelegate:(id<ScanCodeControllerDelegate>) delegate animationType:(enum SCANCODE_ANIMATION_TYPE) animationType;
-(void) closeScanCode;

@end