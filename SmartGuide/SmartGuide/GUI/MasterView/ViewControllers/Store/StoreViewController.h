//
//  StoreViewController.h
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "SGQRCodeViewController.h"
#import "StoreShop.h"
#import "StoreShopItem.h"
#import "StoreCart.h"

@class StoreViewController,StoreScrollView, StoreShopInfoViewController,StoreShopViewController;

@protocol StoreControllerHandle <NSObject>
@property (nonatomic, weak) StoreViewController *storeController;

@optional
-(void) handleBackCallbackCompleted:(void(^)()) completed;

@end

@protocol StoreControllerDelegate <SGViewControllerDelegate>

-(void) storeControllerTouchedSetting:(StoreViewController*) controller;

@end

@interface StoreViewController : SGViewController<SGQRCodeControllerDelegate>
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UIImageView *bgImageView;
    IBOutlet SGNavigationController *storeNavigation;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UILabel *lblCart;
    
    CGRect _bgViewFrame;
    CGRect _bgImageViewFrame;
    
    __weak StoreShop *_store;
}

-(void) showShop:(StoreShop*) shop;
-(void) showItem:(StoreShopItem*) item;
-(void) buyItem:(StoreShopItem*) item;
-(void) enableTouch;
-(void) disableTouch;

-(UIView*) bgView;
-(UIImageView*) bgImageView;
-(CGRect) bgViewFrame;
-(CGRect) bgImageViewFrame;

-(UIView*) qrView;

@property (nonatomic, weak) id<StoreControllerDelegate> delegate;
@property (nonatomic, readonly) enum SORT_STORE_SHOP_LIST_TYPE sortType;

@end

@interface StoreScrollView : UIScrollView

@end