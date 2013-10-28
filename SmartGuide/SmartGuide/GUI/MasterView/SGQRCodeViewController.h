//
//  SGQRCodeViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGQRCodeDelegate <NSObject>

-(void) SGQRCodeRequestShow;

@end

@interface SGQRCodeViewController : UIViewController

@property (nonatomic, assign) id<SGQRCodeDelegate> delegate;

@end
