//
//  MainViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCategoriesViewController.h"
#import "ShopListViewController.h"
#import "ShopUserViewController.h"
#import "Constant.h"
#import "NavigationViewController.h"
#import "TransportViewController.h"

@interface ShopViewController : UINavigationController<ShopCategoriesDelegate,ShopListDelegate,ShopUserDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    CGPoint _startDragPoint;
}

@property (nonatomic, weak) UIViewController *previousController;

@end
