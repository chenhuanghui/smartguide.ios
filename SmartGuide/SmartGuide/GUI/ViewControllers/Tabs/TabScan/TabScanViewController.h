//
//  TabScanViewController.h
//  Infory
//
//  Created by XXX on 8/25/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Enums.h"

@class NavigationView, NavigationTitleLabel, TabScanViewController;

@protocol TabScanControllerDelegate <ViewControllerDelegate>

-(void) tabScanControllerTouchedClose:(TabScanViewController*) controller;
-(void) tabScanController:(TabScanViewController*) controller scannedText:(NSString*) text type:(enum SCAN_CODE_TYPE) codeType;

@end

@interface TabScanViewController : ViewController
{
    __weak IBOutlet NavigationView *titleView;
    __weak IBOutlet NavigationTitleLabel *lblTitle;
    __weak IBOutlet UIView *scanView;
    __weak IBOutlet UIView *cameraView;
    __weak IBOutlet UIView *centerView;
    __weak IBOutlet UIScrollView *scroll;
    __weak IBOutlet UIView *inputView;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btnTorch;
    __weak IBOutlet UILabel *lblTorch;
    __weak IBOutlet UIButton *btnInput;
    __weak IBOutlet UIButton *btnScan;
    __weak IBOutlet UIView *lineHor;
    __weak IBOutlet UIView *lineVer;
}

-(TabScanViewController*) initWithDelegate:(id<TabScanControllerDelegate>) delegate;

@property (nonatomic, weak) id<TabScanControllerDelegate> delegate;

@end