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

-(void) initComponents;
-(void) drawDotCurrentPage:(CGContextRef) context atPoint:(CGPoint) pnt;
-(void) drawDotOtherPage:(CGContextRef) context atPoint:(CGPoint) pnt;

// Set these to control the PageControl.
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger numberOfPages;

// Customize these as well as the backgroundColor property.
@property (nonatomic, strong) UIColor *dotColorCurrentPage;
@property (nonatomic, strong) UIColor *dotColorOtherPage;

// Optional delegate for callbacks when user taps a page dot.
@property (nonatomic, weak) NSObject<PageControlDelegate> *delegate;

@property (nonatomic, weak) UIScrollView *scroll;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, assign) float kDotDiameter;
@property (nonatomic, assign) float kDotSpacer;

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
}

@property (nonatomic, weak) NSObject<PageControlNextDelegate> *delegate;

@end

@interface PageControlShopGallery : PageControl

@property (nonatomic, assign) float lineWidth;

@end