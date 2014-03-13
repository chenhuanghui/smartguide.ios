//
//  SGRootViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class SGSettingViewController,ScrollViewRoot;

@interface SGRootViewController : SGViewController
{   
    __weak IBOutlet ScrollViewRoot *scrollContent;
    __weak IBOutlet UIView *leftView;
}

-(void) showSettingController;
-(void) hideSettingController;

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, readonly, assign) CGRect containFrame;
@property (nonatomic, readonly, assign) CGRect contentFrame;
@property (nonatomic, strong) SGSettingViewController *settingController;

@end

@interface ScrollViewRoot : UIScrollView
{
    __weak UITapGestureRecognizer *tapGes;
}

@end