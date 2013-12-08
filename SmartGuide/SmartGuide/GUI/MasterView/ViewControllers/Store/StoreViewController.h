//
//  StoreViewController.h
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "StoreShopViewController.h"
#import "StoreShopItemsViewController.h"
#import "SGQRCodeViewController.h"

@class StoreViewController;

@protocol StoreControllerDelegate <SGViewControllerDelegate>

-(void) storeControllerTouchedSetting:(StoreViewController*) controller;

@end

@interface StoreViewController : SGViewController<SGQRCodeControllerDelegate>
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *qrView;
    IBOutlet SGNavigationController *storeNavigation;
}

@property (nonatomic, weak) id<StoreControllerDelegate> delegate;

@end
