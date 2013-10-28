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
#import "ShopUserViewController.h"
#import "Constant.h"
#import "NavigationViewController.h"
#import "PanGestureView.h"

@protocol ShopViewDelegate <NSObject>

-(void) shopViewSelectedShop;
-(void) shopViewBackToShopListAnimated:(bool) animated;

@end

@interface ShopViewController : UINavigationController<ShopCatalogDelegate,ShopListDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,PanGestureDelegate>
{
    UIPanGestureRecognizer *panGes;
    PanGestureView *panHandle;
}

@property (nonatomic, weak) UIViewController *previousController;
@property (nonatomic, assign) id<ShopViewDelegate> shopDelegate;

@end
