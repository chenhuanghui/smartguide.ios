//
//  KeyboardUtility.m
//  SmartGuide
//
//  Created by MacMini on 11/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "KeyboardUtility.h"

static KeyboardUtility *_keyboardUtility=nil;
@implementation KeyboardUtility
@synthesize keyboardState;

+(KeyboardUtility *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyboardUtility=[[KeyboardUtility alloc] init];
    });
    
    return _keyboardUtility;
}

- (id)init
{
    self = [super init];
    if (self) {
        keyboardState=KEYBOARD_STATE_HIDDEN;
    }
    return self;
}

+(void)load
{
    [[KeyboardUtility shareInstance] registerNotification];
}

-(void) registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillShowNotification object:nil];
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    keyboardState=KEYBOARD_STATE_WILL_SHOW;
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    keyboardState=KEYBOARD_STATE_WILL_HIDDEN;
}

-(void) keyboardDidHide:(NSNotification*) notification
{
    keyboardState=KEYBOARD_STATE_HIDDEN;
}

-(void) keyboardDidShow:(NSNotification*) notification
{
    keyboardState=KEYBOARD_STATE_SHOWED;
}

@end
