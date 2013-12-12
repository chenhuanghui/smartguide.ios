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

@class StoreShopScrollView, StoreViewController, StoreShopTableAds,StoreShopViewController;

@protocol StoreShopControllerDelegate <SGViewControllerDelegate>

-(void) storeShopControllerTouchedShop:(StoreShopViewController*) controller;

@end

@interface StoreShopViewController : SGViewController<UITableViewDelegate,UITableViewDataSource,GMGridViewActionDelegate,GMGridViewDataSource>
{
    __weak IBOutlet StoreShopScrollView *scroll;
    __weak IBOutlet StoreShopTableAds *tableAds;
    __weak IBOutlet GMGridView *tableShop;
    
    CGRect _tableAdsFrame;
    CGRect _tableShopFrame;
    
    NSMutableArray *_shops;
}

@property (nonatomic, weak) StoreViewController *storeController;
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