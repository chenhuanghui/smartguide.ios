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
#import "ShopUserViewController.h"
#import <MapKit/MapKit.h>
#import "ShopSearchSortView.h"
#import "Scroller.h"
#import "SGMapView.h"
#import "ShopListCell.h"
#import "ShopListPlaceCell.h"
#import "SearchViewController.h"
#import "ASIOperationShopSearch.h"
#import "ASIOperationPlacelistGet.h"
#import "ASIOperationPlacelistGetDetail.h"
#import "ASIOperationGetShopList.h"
#import "Placelist.h"
#import "PlacelistViewController.h"
#import "ShopListMapCell.h"

@class ScrollShopList,ShopListContentView,ShopListViewController,TableShopList;

enum SHOP_LIST_VIEW_MODE {
    SHOP_LIST_VIEW_LIST = 0,
    SHOP_LIST_VIEW_PLACE = 1,
    SHOP_LIST_VIEW_SHOP_LIST = 2,
    SHOP_LIST_VIEW_IDPLACE = 3,
    };

@protocol ShopListControllerDelegate <SGViewControllerDelegate>

-(void) shopListControllerTouchedBack:(ShopListViewController*) controller;
-(void) shopListControllerTouchedTextField:(ShopListViewController*) controller;

@end

@interface ShopListViewController : SGViewController<MKMapViewDelegate,UIScrollViewDelegate,ScrollerDelegate,UIGestureRecognizerDelegate,SortSearchDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,ShopListCellDelegate,SearchControllerHandle,ASIOperationPostDelegate,UITextFieldDelegate,PlacelistControllerDelegate>
{
    __weak IBOutlet TableShopList *tableList;
    __weak IBOutlet ShopSearchSortView *sortView;
    __weak IBOutlet UIButton *btnSearchLocation;
    __weak IBOutlet UIView *qrCodeView;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIView *loadingView;
    __strong ShopListMapCell *mapCell;
    __weak SGMapView *map;
    __weak IBOutlet UIView *visibleTableView;//dùng để tính vị trí animation

    CGRect _mapFrame;
    CGRect _tableFrame;
    CGRect _qrFrame;
    CGRect _buttonScanBigFrame;
    CGRect _buttonScanSmallFrame;
    
    bool _isZoomedMap;
    float _heightZoomedMap;
    bool _isAnimatingZoom;
    
    bool _isDidUpdateLocation;
    
    ASIOperationShopSearch *_operationShopSearch;
    ASIOperationPlacelistGet *_operationPlaceListDetail;
    ASIOperationGetShopList *_operationShopList;
    ASIOperationPlacelistGetDetail *_operationPlacelistGetDetail;
    
    NSString *_keyword;
    __weak Placelist *_placeList;
    NSMutableArray *_shopsList;
    NSString *_idShops;
    int _idPlacelist;
    
    NSUInteger _page;
    enum SORT_LIST _sort;
    bool _canLoadMore;
    bool _isZoomedRegionMap;
    bool _isAnimationZoom;
    bool _isLoadingMore;
    enum SHOP_LIST_VIEW_MODE _viewMode;
    
    CLLocationCoordinate2D _location;
    
    NSIndexPath *_scrollerIndexPath;
    
    bool _didMakeScrollSize;
    
    bool _isNeedAnimationChangeTable;
    
    float _mapRowHeight;
}

-(ShopListViewController*) initWithKeyword:(NSString*) keyword;
-(ShopListViewController*) initWithPlaceList:(Placelist*) placeList;
-(ShopListViewController*) initWithIDShops:(NSString*) idShops;
-(ShopListViewController*) initWithIDPlacelist:(int) idPlacelist;

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