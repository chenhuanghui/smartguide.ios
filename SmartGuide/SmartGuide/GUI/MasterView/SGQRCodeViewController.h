//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGQRCodeViewController;

@protocol SGQRCodeControllerDelegate <SGViewControllerDelegate>

-(void) qrcodeControllerRequestShow:(SGQRCodeViewController*) controller;
-(void) qrcodeControllerRequestClose:(SGQRCodeViewController*) controller;
-(void) qrcodeControllerScanned:(SGQRCodeViewController*) controller;

@end

@interface SGQRCodeViewController : SGViewController
{
    bool _isShowed;
}

@property (nonatomic, assign) id<SGQRCodeControllerDelegate> delegate;

@end
