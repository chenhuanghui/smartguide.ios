//
//  SGRootViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@interface SGRootViewController : SGViewController

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UIView *toolbarView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *qrCodeView;

@property (nonatomic, readonly, assign) CGRect containFrame;
@property (nonatomic, readonly, assign) CGRect toolbarFrame;
@property (nonatomic, readonly, assign) CGRect contentFrame;
@property (nonatomic, readonly, assign) CGRect qrCodeFrame;

@end
