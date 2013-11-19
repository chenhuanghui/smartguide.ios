//
//  ShopUserViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Shop.h"
#import "SGNavigationController.h"
#import "HitTestView.h"

@class ScrollShopUser;

@protocol ShopUserDelegate <SGViewControllerDelegate>

-(void) shopUserFinished;

@end

@interface ShopUserViewController : SGViewController
{
    __strong IBOutlet SGNavigationController *shopNavi;
    __weak IBOutlet SGViewController *detailController;
    __weak IBOutlet ScrollShopUser *scrollShopUser;
    __weak IBOutlet UIView *contentScroll;
    __weak IBOutlet HitTestView *detailView;
}

-(void) setShop:(Shop*) shop;

@property (nonatomic, assign) id<ShopUserDelegate> delegate;

@end

@interface ScrollShopUser : UIScrollView

@end