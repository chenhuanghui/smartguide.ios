//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@protocol SGQRCodeDelegate <SGViewControllerDelegate>

-(void) SGQRCodeRequestShow;

@end

@interface SGQRCodeViewController : SGViewController

@property (nonatomic, assign) id<SGQRCodeDelegate> delegate;

@end
