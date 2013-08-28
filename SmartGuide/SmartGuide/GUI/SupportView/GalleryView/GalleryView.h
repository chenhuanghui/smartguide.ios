//
//  GalleryView.h
//  SmartGuide
//
//  Created by XXX on 8/16/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryCell.h"
#import "GMGridView.h"
#import "GridViewTemplate.h"

@class GalleryView;

@protocol GalleryViewDelegate <NSObject>

-(void) galleryViewBack:(GalleryView*) galleryView;
-(CGRect) galleryViewFrameForAnimationHide:(GalleryView*) galleryView index:(int) index;
-(bool) galleryViewAllowDescription:(GalleryView*) galleryView;

@optional
-(NSString*) galleryViewDescriptionImage:(int) index;

@end

@interface GalleryView : UIView<UIGestureRecognizerDelegate,GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate>
{
    __weak IBOutlet GMGridView *grid;
    
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UITextView *txt;
    __weak IBOutlet UIView *blurr;
    __weak IBOutlet UIView *bg;
    bool _isAllowDescription;
}

-(void) animationImage:(UIImage*) image startRect:(CGRect) rect;

-(GMGridView*) gridView;

@property (nonatomic, assign) id<GalleryViewDelegate> delegate;
@property (nonatomic, assign) int selectedIndex;

@end
