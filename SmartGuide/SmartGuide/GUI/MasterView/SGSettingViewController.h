//
//  SGSettingViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@protocol SGSettingDelegate <NSObject>

-(void) SGSettingHide;

@end

@interface SGSettingViewController : UIViewController

@property (nonatomic, assign) id<SGSettingDelegate> delegate;

@end
