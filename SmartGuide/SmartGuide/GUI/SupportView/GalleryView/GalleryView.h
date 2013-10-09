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
#import "GMGridViewCell.h"

@class GalleryView;
@class GalleryItem;
@class GalleryGridView;

@protocol GalleryViewDelegate <NSObject>

-(bool) galleryViewAllowDescription:(GalleryView*) galleryView;
-(bool) galleryViewAllowLoadMore:(GalleryView*) galleryView;
-(NSUInteger) numberOfItemInGallery:(GalleryView*) galleryView;
-(GalleryItem*) galleryViewItemAtIndex:(GalleryView*) gallerYView index:(NSUInteger) index;
-(void) galleryViewBack:(GalleryView*) galleryView;
-(void)galleryViewLoadMore:(GalleryView*) galleryView atPage:(NSUInteger) page needWait:(bool*) isNeedWait;

@end

@interface GalleryView : UIView<UIGestureRecognizerDelegate,UIScrollViewDelegate,GMGridViewDataSource>
{
    __weak IBOutlet GalleryGridView *grid;
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UITextView *txt;
    __weak IBOutlet UIView *blurr;
    __weak IBOutlet UIView *bg;
    bool _isAllowDescription;
    
    bool _isAllowLoadMore;
    NSUInteger _currentIndex;
    NSUInteger _page;
    bool _isNeedReload;
    bool _isLoadingMore;
}

-(GalleryView*) initWithDelegate:(id<GalleryViewDelegate>) delegate defaultIndex:(NSUInteger) currentIndex;

-(NSUInteger) currentIndex;
-(void) endLoadMore;
-(void) setAllowLoadMore:(bool) isAllowLoadMore;
-(void) setPage:(int) page;

@property (nonatomic, assign) id<GalleryViewDelegate> delegate;

@end

@interface GalleryItem : NSObject

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageDescription;

@end

@interface GalleryGridView : GMGridView<UIGestureRecognizerDelegate, UIScrollViewDelegate>

@end

@interface GalleryGridCell : GMGridViewCell

@end

@interface GalleryLayoutStragery : GMGridViewLayoutHorizontalPagedStrategy

@end