//
//  StoreShopInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "StoreShopItemCell.h"
#import "GMGridView.h"
#import "SGScrollView.h"
#import "StoreViewController.h"
#import "ASIOperationStoreShopItem.h"

@class StoreShopInfoScrollView,StoreShopInfoViewController,StoreItemListController;

@interface StoreShopInfoViewController : SGViewController<GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate,StoreControllerHandle,ASIOperationPostDelegate,StoreShopItemDelegate>
{
    __weak IBOutlet UIView *topView;
    __weak GMGridView *gridLatest;
    __weak GMGridView *gridTopSellers;
    __weak SGScrollView *scrollLatest;
    __weak SGScrollView *scrollTopSellers;
    __weak IBOutlet UILabel *lblNameBot;
    __weak IBOutlet UIView *gridContainer;
    __weak IBOutlet UIImageView *imgvShopLogo;
    __weak IBOutlet UILabel *lblShopName;
    __weak IBOutlet UILabel *lblShopType;
    __weak IBOutlet UILabel *lblShopDesc;
    __weak SGNavigationController *itemNavi;
    StoreItemListController *itemLatest;
    StoreItemListController *itemTopSellers;
    bool _canLoadMoreLatest;
    bool _canLoadMoreTopSellers;
    NSUInteger _pageShopLatest;
    NSUInteger _pageShopTopSellers;
    ASIOperationStoreShopItem *_operationItemLatest;
    ASIOperationStoreShopItem *_operationItemTopSellers;
    NSMutableArray *_itemLastest;
    NSMutableArray *_itemTopSellers;
    
    CGRect _gridLatestFrame;
    CGRect _gridTopSellersFrame;
    CGRect _gridContainerFrame;
    CGRect _lblNameBotFrame;
    
    __weak StoreShop *_store;

    CGPoint _scrollOffset;
}

-(StoreShopInfoViewController*) initWithStore:(StoreShop*) store;

-(void) prepareOnBack;

@property (nonatomic, weak) StoreViewController *storeController;

@end

@interface StoreShopInfoScrollView : SGScrollView
{
}

@end

@interface StoreItemListController : SGViewController
{
    __weak GMGridView *grid;
    __weak SGScrollView *scroll;
    CGRect _gridFrame;
}

-(StoreItemListController*) initWithFrame:(CGRect) rect;

-(GMGridView*) gridView;
-(CGRect) gridFrame;
-(SGScrollView*) scroll;
-(void) makeScrollSize;

@end