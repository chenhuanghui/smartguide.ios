//
//  SwitchSetting.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchSetting;

@protocol SwitchSettingDelegate <NSObject>

-(void) switchChanged:(SwitchSetting*) sw;

@end

@interface SwitchSetting : UIView
{
    __weak IBOutlet UIButton *btn;
    
}

@property (nonatomic, assign) bool ON;
@property (nonatomic, assign) id<SwitchSettingDelegate> delegate;

@end
