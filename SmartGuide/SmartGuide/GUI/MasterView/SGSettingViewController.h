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

-(void) SGSettingHided;

@end

@interface SGSettingViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CGPoint _startPoint;
}

-(void) showSettingWithContaintView:(UIView*) containtView slideView:(UIView*) slideView;

@property (nonatomic, assign) id<SGSettingDelegate> delegate;
@property (nonatomic, assign) UIView *slideView;

@end
