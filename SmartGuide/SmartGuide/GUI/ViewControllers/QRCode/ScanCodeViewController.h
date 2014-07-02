//
//  ScanCodeViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ScanCodeViewController;

@protocol ScanCodeViewControllerDelegate <SGViewControllerDelegate>

-(void) scanCodeViewController:(ScanCodeViewController*) controller scannedText:(NSString*) text;

@end

@interface ScanCodeViewController : SGViewController
{
    __weak IBOutlet UIButton *btnTorch;
    __weak IBOutlet UILabel *lblTorch;
    __weak IBOutlet UIView *cameraView;
    __weak IBOutlet UIButton *btnMakeCode;
}

@property (nonatomic, weak) id<ScanCodeViewControllerDelegate> delegate;

@end

@interface ScanCodeBackgroundView : UIView

@end