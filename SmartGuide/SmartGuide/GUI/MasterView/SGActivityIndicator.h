//
//  SGActivityIndicator.h
//  SmartGuide
//
//  Created by MacMini on 28/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

@interface SGActivityIndicator : UIView

-(SGActivityIndicator*) initWithView:(UIView*) view;

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicator;

@end

@interface UIView(SGActivityIndicator)

-(void) SGShowLoading;
-(void) SGRemoveLoading;

@end