//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

@protocol ShopCatalogDelegate <NSObject>

-(void) shopCategoriesSelectedGroup;

@end

@interface ShopCatalogViewController : UIViewController

@property (nonatomic, assign) id<ShopCatalogDelegate> delegate;

@end
