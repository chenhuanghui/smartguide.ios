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
#import "ShopListSortView.h"
#import "Scroller.h"
#import "ShopViewController.h"
#import "MapList.h"

@class ScrollShopList,ShopListContentView;

@interface ShopListViewController : SGViewController<MKMapViewDelegate,UIScrollViewDelegate,ScrollerDelegate,UIGestureRecognizerDelegate,SortViewDelegate,UIActionSheetDelegate,ShopControllerHandle,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tableList;
    __weak IBOutlet ScrollShopList *scroll;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet ShopListSortView *sortView;
    __weak IBOutlet UIButton *btnSearchLocation;
    __weak IBOutlet ShopListContentView *contentView;
    __weak IBOutlet UIView *qrCodeView;
    
    CGRect _mapFrame;
    CGRect _tableFrame;
    CGRect _contentFrame;
    CGRect _scrollFrame;
    CGRect _viewFrame;
    CGRect _qrFrame;
    CGRect _sortFrame;
    CGRect _buttonMapFrame;
    CGRect _buttonSearchLocationFrame;
    
    bool _isZoomedMap;
    bool _isAnimatingZoomMap;

    __weak UITapGestureRecognizer *_tapTop;
    __weak UITapGestureRecognizer *_tapBot;
    
    Scroller *scroller;
    NSIndexPath *_lastScrollerIndexPath;
    
    bool _isDidUpdateLocation;
}

-(bool) isZoomedMap;
-(void) scrollViewSetContentOffset:(CGPoint) contentOffset;

@property (nonatomic, assign) id<ShopListDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@interface ScrollShopList : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) bool disableScrollUp;
@property (nonatomic, readonly) CGPoint offset;
@property (nonatomic, weak) ShopListViewController *shopListController;
@property (nonatomic, assign) float minContentOffsetY;

@end

@protocol ShopListScrollerDelegate <NSObject>

-(UIScrollView*) scrollView;

@end

@interface ShopListContentView : UIView

@end

@interface ShopListView : UIView

@end