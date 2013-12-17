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
#import "MapList.h"
#import "ShopListCell.h"
#import "SearchViewController.h"
#import "ASIOperationShopSearch.h"

@class ScrollShopList,ShopListContentView;

@protocol ShopListControllerDelegate <SGViewControllerDelegate>



@end

@interface ShopListViewController : SGViewController<MKMapViewDelegate,UIScrollViewDelegate,ScrollerDelegate,UIGestureRecognizerDelegate,SortSearchDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,ShopListCellDelegate,SearchControllerHandle,ASIOperationPostDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITableView *tableList;
    __weak IBOutlet ScrollShopList *scroll;
    __weak IBOutlet UIButton *btnMap;
    __weak IBOutlet ShopSearchSortView *sortView;
    __weak IBOutlet UIButton *btnSearchLocation;
    __weak IBOutlet UIView *qrCodeView;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet UITextField *txt;
    
    CGRect _mapFrame;
    CGRect _tableFrame;
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
    
    ASIOperationShopSearch *_operationShopSearch;
    NSString *_keyword;
    NSMutableArray *_shopsList;
    NSUInteger _page;
    enum SORT_SHOP_LIST _sort;
    bool _canLoadMore;
    bool _isZoomedRegionMap;
    
    CLLocationCoordinate2D _location;
}

-(ShopListViewController*) initWithKeyword:(NSString*) keyword;
-(ShopListViewController*) initWithPlaceList;

-(bool) isZoomedMap;

@property (nonatomic, assign) id<ShopListControllerDelegate> delegate;
@property (nonatomic, strong) NSString *catalog;

@end

@interface ScrollShopList : SGScrollView<UIGestureRecognizerDelegate>

@end

@protocol ShopListScrollerDelegate <NSObject>

-(UIScrollView*) scrollView;

@end

@interface ShopListContentView : UIView

@end

@interface ShopListView : UIView

@end