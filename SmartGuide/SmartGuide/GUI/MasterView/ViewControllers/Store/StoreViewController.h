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

@class StoreViewController,StoreScrollView, StoreShopInfoViewController,StoreShopViewController;

@protocol StoreControllerHandle <NSObject>
@property (nonatomic, weak) StoreViewController *storeController;

-(void) storeControllerButtonLatestTouched:(UIButton*) btn;
-(void) storeControllerButtonTopSellersTouched:(UIButton*) btn;

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
    __weak IBOutlet UIView *rayView;
    IBOutlet SGNavigationController *storeNavigation;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIButton *btnLatest;
    __weak IBOutlet UIButton *btnTopSellers;
    
    CGRect _rayViewFrame;
    CGRect _bgViewFrame;
    CGRect _bgImageViewFrame;
}

-(void) showShop:(StoreShop*) shop;

-(UIView*) rayView;
-(CGRect) rayViewFrame;

-(UIView*) bgView;
-(UIImageView*) bgImageView;
-(CGRect) bgViewFrame;
-(CGRect) bgImageViewFrame;

-(UIButton*) buttonLatest;
-(UIButton*) buttonTopSellers;

@property (nonatomic, weak) id<StoreControllerDelegate> delegate;

@end

@interface StoreScrollView : UIScrollView

@end