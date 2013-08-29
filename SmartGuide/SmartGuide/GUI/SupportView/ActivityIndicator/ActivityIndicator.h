//
//  ActivityIndicator.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityIndicator;

@protocol ActivityIndicatorDelegate <NSObject>

@optional
-(void) activityIndicatorCountdownEnded:(ActivityIndicator*) activityIndicator;

@end

@interface ActivityIndicator : UIView
{
    NSTimer *_timerCountdown;
    NSString *_indicatorTitle;
}

-(ActivityIndicator*) initWithTitle:(NSString*) title;

-(void) setTitle:(NSString*) title;
-(void) alignLayout:(UIView*) newSuperview;
-(void) startAnimation;

@property (nonatomic, unsafe_unretained) id touchDelegate;
@property (nonatomic, assign) id<ActivityIndicatorDelegate> delegate;
@property (nonatomic, assign) int countdown;
@property (nonatomic, assign) bool allowCancel;
@property (nonatomic, assign) id tagID;

@end

@interface UIView(ActivityIndicator)

-(ActivityIndicator*) showLoadingWithTitle:(NSString*) title;
-(ActivityIndicator*) showLoadingWithTitle:(NSString *)title countdown:(int) countdown delegate:(id<ActivityIndicatorDelegate>) delegate;
-(void) removeLoading;

@end