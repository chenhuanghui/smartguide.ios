//
//  ShopUserController.h
//  Infory
//
//  Created by XXX on 6/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ShopUserController, ButtonBackShopUser,TouchView, ShopUserViewController;

@protocol ShopUserControllerDelegate <SGViewControllerDelegate>

-(void) shopUserControllerTouchedClose:(ShopUserController*) controller;
-(void) shopUserControllerTouchedScanQRCode:(ShopUserController*) controller;

@end

@interface ShopUserController : SGViewController
{
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UIButton *btnBack;
    SGNavigationController *_navi;
    
    int _idShop;
    Shop *_shop;
}

-(ShopUserController*) initWithIDShop:(int) idShop;
-(ShopUserController*) initWithShop:(Shop*) shop;

@property (nonatomic, weak) id<ShopUserControllerDelegate> delegate;
@property (nonatomic, weak) ShopUserViewController* shopController;

@end
