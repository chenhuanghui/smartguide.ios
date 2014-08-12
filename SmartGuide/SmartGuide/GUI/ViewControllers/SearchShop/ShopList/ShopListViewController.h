//
//  ShopListViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SearchViewController.h"

@class ScrollShopList,ShopListContentView,ShopListViewController,TableShopList,ScrollerShopList, ShopListSortView, ShopListMapCell, MapView, SearchTextField;

enum SHOP_LIST_VIEW_MODE {
    SHOP_LIST_VIEW_LIST = 0,
    SHOP_LIST_VIEW_PLACE = 1,
    SHOP_LIST_VIEW_SHOP_LIST = 2,
    SHOP_LIST_VIEW_IDPLACE = 3,
    SHOP_LIST_VIEW_BRANCH = 4,
    };

@protocol ShopListControllerDelegate <SGViewControllerDelegate>

-(void) shopListControllerTouchedBack:(ShopListViewController*) controller;
-(void) shopListControllerTouchedTextField:(ShopListViewController*) controller;

@end

@interface ShopListViewController : SGViewController<SearchControllerHandle>
{
    __weak IBOutlet TableShopList *tableList;
    __weak IBOutlet ShopListSortView *sortView;
    __weak IBOutlet UIButton *btnSearchLocation;
    __weak IBOutlet UIView *qrCodeView;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet SearchTextField *txt;
    __weak IBOutlet UIView *loadingView;
    __strong ShopListMapCell *mapCell;
    __weak MapView *map;
    __weak IBOutlet UIView *visibleTableView;//dùng để tính vị trí animation
    __weak IBOutlet UIView *visibleScrollerView;//dùng để tính chiều cao scroller;

    __weak IBOutlet UIButton *btnCity;
    CGRect _mapFrame;
    CGRect _tableFrame;
    CGRect _qrFrame;
    CGRect _buttonScanBigFrame;
    CGRect _buttonScanSmallFrame;
    
    bool _isZoomedMap;
    float _heightZoomedMap;
    bool _isAnimatingZoom;
    
    bool _isDidUpdateLocation;

    NSIndexPath *_indexPathWillRemove;
    
    NSString *_keyword;
    __weak Placelist *_placeList;
    NSMutableArray *_shopsList;
    NSString *_idShops;
    int _idPlacelist;
    int _idBranch;
    
    int _page;
    enum SORT_LIST _sort;
    bool _canLoadMore;
    bool _isZoomedRegionMap;
    bool _isAnimationZoom;
    bool _isLoadingMore;
    enum SHOP_LIST_VIEW_MODE _viewMode;
    
    CLLocationCoordinate2D _location;
    
    bool _didMakeScrollSize;
    bool _isNeedAnimationChangeTable;
    float _mapRowHeight;
    
    __weak ScrollerShopList *scrollerView;
    CGRect _scrollerViewFrame;
    int _idCity;
}

-(ShopListViewController*) initWithKeyword:(NSString*) keyword;
-(ShopListViewController*) initWithPlaceList:(Placelist*) placeList;
-(ShopListViewController*) initWithIDShops:(NSString*) idShops;
-(ShopListViewController*) initWithIDPlacelist:(int) idPlacelist;
-(ShopListViewController*) initWithIDBranch:(int) idBranch;

-(NSString*) keyword;
-(Placelist*) placelist;

-(bool) isZoomedMap;

@property (nonatomic, assign) id<ShopListControllerDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@protocol ShopListScrollerDelegate <NSObject>

-(UIScrollView*) scrollView;

@end

@interface TableShopList : UITableView<UIGestureRecognizerDelegate>
{
    float _offsetY;
}

-(float) offsetY;

@property (nonatomic, weak) IBOutlet ShopListViewController *controller;

@end

@interface ShopListScrollerBG : UIView

@property (nonatomic, strong) UIImage *icon;

@end

@interface ScrollerShopList : UIView
{
    __weak UILabel *lbl;
    __weak ShopListScrollerBG* bg;
}

-(ScrollerShopList*) initWithTable:(UITableView*) table;
-(void) setTitle:(NSString*) title;
-(void) setIcon:(UIImage*) icon;

@end