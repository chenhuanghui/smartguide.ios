//
//  MainViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "SGNavigationController.h"
#import "SearchShopViewController.h"

@class ShopViewController,ShopCatalogViewController,ShopListViewController;

@protocol ShopCatalogDelegate <SGViewControllerDelegate>

-(void) shopCatalogSelectedCatalog:(ShopCatalog*) group;

@end

@protocol ShopListDelegate <SGViewControllerDelegate>

-(void) shopListSelectedShop;

@end

@protocol ShopViewDelegate <SGViewControllerDelegate>

-(void) shopControllerTouchedSetting:(ShopViewController*) controller;
-(void) shopControllerTouchedNotification:(ShopViewController*) controller;

@end

@protocol ShopControllerHandle <NSObject>

-(void) showQRView;
-(void) hideQRView;

@property (nonatomic, weak) ShopViewController *shopController;
@property (nonatomic, weak) UIView *qrCodeView;
@property (nonatomic, assign) CGRect qrViewFrame;
@property (nonatomic, assign) bool isShowedQRView;

@end

@interface ShopViewController : SGViewController<ShopCatalogDelegate,ShopListDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *searchView;
    __weak IBOutlet UIView *titleView;
    __weak IBOutlet UITextField *txtSearch;
    
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnNotification;
    __weak IBOutlet UIButton *btnCancel;
    __weak IBOutlet UIButton *btnConfig;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIButton *btnQRCode;
    
    __weak IBOutlet UILabel *lblLocation;
    
    __weak SearchShopViewController *searchShopController;
    
    CGRect _qrViewFrame;
}

-(void) showShopListWithGroup:(ShopCatalog*) group;

-(CGRect) qrViewFrame;
-(float) searchFieldHeight;

@property (weak, nonatomic) IBOutlet SGNavigationController *childNavigationController;
@property (nonatomic, weak) id<ShopViewDelegate> delegate;
@property (nonatomic, weak, readonly) ShopCatalogViewController *shopCatalog;
@property (nonatomic, weak, readonly) ShopListViewController *shopList;

@end
