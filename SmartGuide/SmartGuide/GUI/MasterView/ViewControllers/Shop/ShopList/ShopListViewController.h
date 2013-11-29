//
//  ShopListViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"
#import "SGTableTemplate.h"
#import "ASIOperationShopInGroup.h"
#import "ShopUserViewController.h"
#import <MapKit/MapKit.h>
#import "ACTimeScroller.h"
#import "ShopListSortView.h"
#import "Scroller.h"

@class ScrollShopList;

@protocol ShopListDelegate <SGViewControllerDelegate>

-(void) shopListSelectedShop;

@end

@interface ShopListViewController : SGViewController<MKMapViewDelegate,UIScrollViewDelegate,ScrollerDelegate>
{
    __weak IBOutlet UITableView *tableList;
    __weak IBOutlet MKMapView *map;
    __weak IBOutlet ScrollShopList *scroll;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet ShopListSortView *sortView;
    __weak IBOutlet UIButton *btnSearchLocation;
    
    CGPoint _scrollOffset;
    CGRect _mapFrame;
    CGPoint _mapCenter;
    CGRect _tableFrame;
    
    bool _isZoomedMap;
    bool _isAnimatingZoomMap;
    
    __weak UITapGestureRecognizer *_tapTop;
    __weak UITapGestureRecognizer *_tapBot;
    
    Scroller *scroller;
    NSIndexPath *_lastScrollerIndexPath;
    
    bool _isDidUpdateLocation;
}

@property (nonatomic, assign) id<ShopListDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@interface ScrollShopList : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) bool disableScrollUp;
@property (nonatomic, readonly) CGPoint offset;

@end

@protocol ShopListScrollerDelegate <NSObject>

-(UIScrollView*) scrollView;

@end