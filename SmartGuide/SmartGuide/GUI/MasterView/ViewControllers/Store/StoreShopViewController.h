//
//  StoreShopViewController.h
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "GMGridView.h"
#import "StoreCardViewController.h"
#import "ASIOperationStoreShopList.h"
#import "ASIOperationStoreAllStore.h"
#import "StoreViewController.h"

@class StoreShopScrollView, StoreViewController, StoreShopTableAds,StoreShopViewController,StoreShopListController;

@protocol StoreShopControllerDelegate <SGViewControllerDelegate>

-(void) storeShopControllerTouchedShop:(StoreShopViewController*) controller;

@end

@interface StoreShopViewController : SGViewController<UITableViewDelegate,UITableViewDataSource,GMGridViewActionDelegate,GMGridViewDataSource,ASIOperationPostDelegate,StoreControllerHandle>
{
    __weak IBOutlet StoreShopTableAds *tableAds;
    __weak IBOutlet UIView *gridContainer;
    __weak SGNavigationController *shopNavi;
    StoreShopListController *shopLatest;
    StoreShopListController *shopTopSellers;
    
    __weak GMGridView *gridLatest;
    __weak GMGridView *gridTopSellers;
    
    CGRect _tableAdsFrame;
    CGRect _gridLatestFrame;
    CGRect _gridTopFrame;
    CGRect _gridContainerFrame;
    
    NSMutableArray *_shopsLatest;
    NSMutableArray *_shopsTopSellers;
    bool _canLoadMoreShopLatest;
    bool _canLoadMoreTopSellers;
    
    NSUInteger _pageShopLatest;
    NSUInteger _pageShopTopSellers;
    ASIOperationStoreShopList *_operationShopsLatest;
    ASIOperationStoreShopList *_operationShopsTopSellers;
    ASIOperationStoreAllStore *_operationAllStore;
}

@property (nonatomic, weak) id<StoreShopControllerDelegate> delegate;

@end

@interface StoreShopScrollView : UIScrollView<UIGestureRecognizerDelegate>
{
    CGPoint _offset;
}

-(CGPoint) offset;

@property (nonatomic, assign) float minContentOffsetY;

@end

@interface StoreShopTableAds : UITableView
{
    CGPoint _offset;
}

-(CGPoint) offset;

@end

@interface StoreShopListController : SGViewController
{
    __weak GMGridView *grid;
}

-(GMGridView*) gridView;

@end