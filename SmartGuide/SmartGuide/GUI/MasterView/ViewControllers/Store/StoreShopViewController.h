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
#import "StoreViewController.h"

@class StoreShopScrollView, StoreViewController, StoreShopTableAds,StoreShopViewController;

@protocol StoreShopControllerDelegate <SGViewControllerDelegate>

-(void) storeShopControllerTouchedShop:(StoreShopViewController*) controller;

@end

@interface StoreShopViewController : SGViewController<UITableViewDelegate,UITableViewDataSource,GMGridViewActionDelegate,GMGridViewDataSource,ASIOperationPostDelegate,StoreControllerHandle>
{
    __weak IBOutlet StoreShopScrollView *scroll;
    __weak IBOutlet StoreShopTableAds *tableAds;
    __weak IBOutlet GMGridView *tableShop;
    
    CGRect _tableAdsFrame;
    CGRect _tableShopFrame;
    
    NSMutableArray *_shopsLastest;
    NSMutableArray *_shopsTopSellers;
    bool _canLoadMoreShopLastest;
    bool _canLoadMoreTopSellers;
    
    ASIOperationStoreShopList *_operationShopList;
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