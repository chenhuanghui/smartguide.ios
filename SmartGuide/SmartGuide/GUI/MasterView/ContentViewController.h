//
//  MasterViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthorizationViewController.h"
#import "NavigationViewController.h"
#import "ShopViewController.h"

@protocol ContentViewDelegate <NSObject>

-(void) contentViewSelectedShop;
-(void) contentViewBackToShopListAnimated:(bool) isAnimated;

@end

@interface ContentViewController : UINavigationController<ShopViewDelegate>

@property (nonatomic, strong, readonly) ShopViewController *shopController;

@property (nonatomic, assign) id<ContentViewDelegate> contentDelegate;

@end
