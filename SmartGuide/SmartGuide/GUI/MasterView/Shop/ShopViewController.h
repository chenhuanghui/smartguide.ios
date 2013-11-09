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
#import "PanDragViewHandle.h"

@protocol ShopViewDelegate <NSObject>

-(void) shopViewSelectedShop;
-(void) shopViewBackToShopListAnimated:(bool) animated;

@end

@interface ShopViewController : SGNavigationController<ShopCatalogDelegate,ShopListDelegate,UINavigationControllerDelegate>
{
}

@property (nonatomic, assign) id<ShopViewDelegate> shopDelegate;
@property (nonatomic, strong, readonly) ShopListViewController *shopList;

@end
