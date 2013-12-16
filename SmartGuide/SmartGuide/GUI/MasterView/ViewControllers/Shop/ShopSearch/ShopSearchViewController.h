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
#import "ShopSearchSortView.h"
#import "Scroller.h"
#import "ShopViewController.h"
#import "MapList.h"
#import "ShopSearchCell.h"

@class ScrollShopList,ShopListContentView;

@interface ShopSearchViewController : SGViewController<MKMapViewDelegate,UIScrollViewDelegate,ScrollerDelegate,UIGestureRecognizerDelegate,SortSearchDelegate,UIActionSheetDelegate,ShopControllerHandle,UITableViewDataSource,UITableViewDelegate,ShopListCellDelegate>
{
    __weak IBOutlet UITableView *tableList;
    __weak IBOutlet ScrollShopList *scroll;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet ShopSearchSortView *sortView;
    __weak IBOutlet UIButton *btnSearchLocation;
    __weak IBOutlet ShopListContentView *contentView;
    __weak IBOutlet UIView *qrCodeView;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIButton *btnScanSmall;
    
    CGRect _mapFrame;
    CGRect _tableFrame;
    CGRect _contentFrame;
    CGRect _scrollFrame;
    CGRect _viewFrame;
    CGRect _qrFrame;
    CGRect _sortFrame;
    CGRect _buttonMapFrame;
    CGRect _buttonSearchLocationFrame;
    CGRect _buttonScanBigFrame;
    CGRect _buttonScanSmallFrame;
    
    bool _isZoomedMap;
    float _heightZoomedMap;
    bool _isAnimatingZoom;

    __weak UITapGestureRecognizer *_tapTop;
    __weak UITapGestureRecognizer *_tapBot;
    
    __weak UIImageView *scrollBar;
    __weak UILabel *scrollerLabel;
    __weak UIImageView *scrollerImageView;
    __weak UIView *scrollerView;
    __weak UIView *scrollerBGView;
    __weak IBOutlet UIView *scrollerContain;
    
    NSIndexPath *_lastScrollerIndexPath;
    
    bool _isDidUpdateLocation;
    bool _isAllowDiffScrollMap;
}

-(ShopSearchViewController*) initWithKeyword:(NSString*) keyword;
-(ShopSearchViewController*) initWithPlaceList;

-(bool) isZoomedMap;
-(void) scrollViewSetContentOffset:(CGPoint) contentOffset;

@property (nonatomic, assign) id<ShopListDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@interface ScrollShopList : UIScrollView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) bool disableScrollUp;
@property (nonatomic, readonly) CGPoint offset;
@property (nonatomic, weak) ShopSearchViewController *shopListController;
@property (nonatomic, assign) float minContentOffsetY;

@end

@protocol ShopListScrollerDelegate <NSObject>

-(UIScrollView*) scrollView;

@end

@interface ShopListContentView : UIView

@end

@interface ShopListView : UIView

@end