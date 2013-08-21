//
//  LoadingCell.m
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "LoadingCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

@implementation LoadingCell

-(void)willRemoveSubview:(UIView *)subview
{
    [activityIndicator stopAnimating];
    
    [super willRemoveSubview:subview];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
//    self.backgroundColor=[UIColor blackColor];
    activityIndicator.frame=self.frame;
    activityIndicator.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    blackView.backgroundColor=COLOR_BACKGROUND_APP;
    blackView.alpha=0.3f;
    [blackView.layer setMasksToBounds:YES];
    [blackView.layer setCornerRadius:10.0];
    [blackView.layer setBorderColor:[[UIColor clearColor] CGColor]];
    [blackView.layer setBorderWidth:1.0];
    
    CGRect rect=CGRectZero;
    rect.size=CGSizeMake(50, 50);
    blackView.frame=rect;
    blackView.center=activityIndicator.center;
    
    [UIView animateWithDuration:0.5f animations:^{
        blackView.alpha=1;
    }];
    
    [super willMoveToSuperview:newSuperview];
}

-(void)startAnimation
{
    [activityIndicator startAnimating];
}

+(NSString *)reuseIdentifier
{
    return @"LoadingCell";
}

@end
