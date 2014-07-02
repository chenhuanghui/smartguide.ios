//
//  ScanCodeController.h
//  Infory
//
//  Created by XXX on 6/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGNavigationController, ScanCodeController, ScanObject;

@protocol ScanCodeControllerDelegate <SGViewControllerDelegate>

-(void) scanCodeController:(ScanCodeController*) controller scannedObject:(ScanObject*) obj;

@optional
-(void) scanCodeControllerTouchedClose:(ScanCodeController*) controller;

@end

@interface ScanCodeController : SGViewController
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *scanView;
    __weak IBOutlet UIImageView *imgvScanTop;
    __weak IBOutlet UIImageView *imgvScanBot;
    __weak IBOutlet UIImageView *imgvScan;
    __weak IBOutlet UIButton *btnClose;
    __weak IBOutlet UILabel *lblTitle;
    
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

enum SCAN_OBJECT_TYPE
{
    SCAN_OBJECT_TYPE_TEXT=0,
    SCAN_OBJECT_TYPE_URL=1,
    SCAN_OBJECT_TYPE_IDSHOP=2,
    SCAN_OBJECT_TYPE_IDPLACELIST=3,
    SCAN_OBJECT_TYPE_IDBRANCH=4,
    SCAN_OBJECT_TYPE_IDSHOPS=5
};

@interface ScanObject : NSObject

-(enum SCAN_OBJECT_TYPE) enumType;

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSNumber *idShop;
@property (nonatomic, strong) NSNumber *idPlacelist;
@property (nonatomic, strong) NSNumber *idBranch;
@property (nonatomic, strong) NSString *idShops;

@end