//
//  UIScrollView+TPKeyboardAvoidingAdditions.h
//  TPKeyboardAvoidingSample
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2013 A Tasty Pixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPKeyboardAvoidingState : NSObject
@property (nonatomic, assign) UIEdgeInsets priorInset;
@property (nonatomic, assign) UIEdgeInsets priorScrollIndicatorInsets;
@property (nonatomic, assign) BOOL         keyboardVisible;
@property (nonatomic, assign) CGRect       keyboardRect;
@property (nonatomic, assign) CGSize       priorContentSize;
@property (nonatomic, strong) NSMutableArray *exceptViews;
@end

@interface UIScrollView (TPKeyboardAvoidingAdditions)
- (BOOL)TPKeyboardAvoiding_focusNextTextField;
- (void)TPKeyboardAvoiding_scrollToActiveTextField;

- (void)TPKeyboardAvoiding_keyboardWillShow:(NSNotification*)notification;
- (void)TPKeyboardAvoiding_keyboardWillHide:(NSNotification*)notification;
- (void)TPKeyboardAvoiding_updateContentInset;
- (void)TPKeyboardAvoiding_updateFromContentSizeChange;
- (void)TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:(UIView*)view;
- (UIView*)TPKeyboardAvoiding_findFirstResponderBeneathView:(UIView*)view;
-(CGSize)TPKeyboardAvoiding_calculatedContentSizeFromSubviewFrames;

@property (nonatomic, strong, readwrite) TPKeyboardAvoidingState *keyboardAvoidingState;

@end
