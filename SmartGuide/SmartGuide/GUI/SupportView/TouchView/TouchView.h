//
//  TouchView.h
//  SmartGuide
//
//  Created by XXX on 8/4/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TouchViewDelegate <NSObject>

@optional
-(void) viewTouchBegan:(UIView*) touchView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) viewTouchMoved:(UIView*) touchView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) viewTouchEnded:(UIView*) touchView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) viewTouchCancelled:(UIView*) touchView touches:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface TouchView : UIView

@property (nonatomic, assign) id<TouchViewDelegate> delegate;

@end
