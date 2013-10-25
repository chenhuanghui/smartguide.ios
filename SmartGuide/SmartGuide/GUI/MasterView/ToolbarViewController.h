//
//  ToolbarViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolbarDelegate <NSObject>

-(void) toolbarSetting;

@end

@interface ToolbarViewController : UIViewController
{
    __weak IBOutlet UIButton *btnSetting;
}

@property (nonatomic, assign) id<ToolbarDelegate> delegate;

@end
