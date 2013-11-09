//
//  ToolbarViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@protocol ToolbarDelegate <SGViewControllerDelegate>

-(void) toolbarSetting;
-(void) toolbarUserCollection;
-(void) toolbarUserLogin;

@end

@interface ToolbarViewController : SGViewController
{
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnUserCollection;
    __weak IBOutlet UIButton *btnMap;
}

@property (nonatomic, assign) id<ToolbarDelegate> delegate;

@end
