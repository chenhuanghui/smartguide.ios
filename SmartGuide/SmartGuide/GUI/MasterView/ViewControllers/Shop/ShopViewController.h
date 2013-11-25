//
//  MainViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCatalogViewController.h"
#import "ShopListViewController.h"
#import "Constant.h"
#import "SGNavigationController.h"
#import "SearchShopViewController.h"

@class ShopViewController;

@protocol ShopViewDelegate <SGViewControllerDelegate>

-(void) shopControllerTouchedSetting:(ShopViewController*) controller;

@end

@interface ShopViewController : SGViewController<ShopCatalogDelegate,ShopListDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
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
    
    __weak SearchShopViewController *searchShopController;
}

-(void) showShopListWithGroup:(ShopCatalog*) group;

@property (weak, nonatomic) IBOutlet SGNavigationController *childNavigationController;


@property (nonatomic, weak) id<ShopViewDelegate> delegate;
@property (nonatomic, weak, readonly) ShopCatalogViewController *shopCatalog;
@property (nonatomic, weak, readonly) ShopListViewController *shopList;

@end
