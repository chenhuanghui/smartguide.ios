//
//  AlphaView.h
//  SmartGuide
//
//  Created by XXX on 7/30/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ALPHA_TAG 123

@interface AlphaView : UIView

@end

@interface UIView(AlphaView)

-(AlphaView*) makeAlphaView;
-(AlphaView*) makeAlphaViewBelowView:(UIView*) view;
-(AlphaView*) alphaView;
-(AlphaView*) alphaViewWithColor:(UIColor*) color;
-(AlphaView*) alphaViewWithColor:(UIColor*) color belowView:(UIView*) view;
-(void) removeAlphaView;

@end