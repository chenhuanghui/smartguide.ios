//
//  TextField.h
//  SmartGuide
//
//  Created by XXX on 8/25/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextFieldDelegate <UITextFieldDelegate>

-(bool) textFieldDeleteBackward;

@end

@interface TextField : UITextField

@property (nonatomic, assign) id<TextFieldDelegate> delegate;

@end
