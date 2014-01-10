//
//  LoadingView.h
//  SmartGuide
//
//  Created by MacMini on 13/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    __weak UIView *bgView;
    __weak UIActivityIndicatorView *indicatorView;
}

-(LoadingView*) initWithView:(UIView*) view;
-(UIView*) backgroundView;
-(UIActivityIndicatorView*) activityIndicatorView;

@end

@interface UIView(Loading)
@property (nonatomic, readwrite,weak) LoadingView *loadingView;

-(void) showLoading;
-(void) removeLoading;
-(void) removeLoading:(bool) animate;
-(void) showLoadingInsideFrame:(CGRect) rect;

@end