//
//  PageControl.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageControlDelegate;

@interface PageControl : UIView

// Set these to control the PageControl.
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger numberOfPages;

// Customize these as well as the backgroundColor property.
@property (nonatomic, strong) UIColor *dotColorCurrentPage;
@property (nonatomic, strong) UIColor *dotColorOtherPage;

// Optional delegate for callbacks when user taps a page dot.
@property (nonatomic, weak) NSObject<PageControlDelegate> *delegate;

@end

@protocol PageControlDelegate<NSObject>
@optional
- (void)pageControlPageDidChange:(PageControl *)pageControl;
@end

@class PageControlNext;

@protocol PageControlNextDelegate <PageControlDelegate>

-(void) pageControlTouchedNext:(PageControlNext*) pageControl;

@end

@interface PageControlNext : PageControl
{
    __weak UIButton *btn;
}

@property (nonatomic, weak) NSObject<PageControlNextDelegate> *delegate;

@end