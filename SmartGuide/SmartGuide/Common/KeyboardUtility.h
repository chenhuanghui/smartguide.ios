//
//  KeyboardUtility.h
//  SmartGuide
//
//  Created by MacMini on 11/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

enum KEYBOARD_STATE {
    KEYBOARD_STATE_HIDDEN = 0,
    KEYBOARD_STATE_SHOWED = 1,
    KEYBOARD_STATE_WILL_SHOW = 2,
    KEYBOARD_STATE_WILL_HIDDEN = 3,
    };

@interface KeyboardUtility : NSObject

+(KeyboardUtility*) shareInstance;
-(bool) isKeyboardVisible;

@property (nonatomic, readonly) enum KEYBOARD_STATE keyboardState;
@property (nonatomic, assign) CGRect keyboardFrame;

@end
