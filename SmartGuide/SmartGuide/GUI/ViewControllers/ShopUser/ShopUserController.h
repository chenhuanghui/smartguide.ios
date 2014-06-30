//
//  ShopUserController.h
//  Infory
//
//  Created by XXX on 6/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopUserController, ButtonBackShopUser,TouchView, ShopUserViewController, Shop;

@protocol ShopUserControllerDelegate <SGViewControllerDelegate>

-(void) shopUserControllerTouchedClose:(ShopUserController*) controller;
-(void) shopUserControllerTouchedScanQRCode:(ShopUserController*) controller;

@end

@interface ShopUserController : SGViewController
{
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UIButton *btnBack;
    SGNavigationController *_navi;
}

-(ShopUserController*) initWithIDShop:(int) idShop;
-(ShopUserController*) initWithShop:(Shop*) shop;

@property (nonatomic, weak) id<ShopUserControllerDelegate> delegate;

@end
