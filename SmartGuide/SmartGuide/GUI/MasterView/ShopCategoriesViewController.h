//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

@protocol ShopCategoriesDelegate <NSObject>

-(void) shopCategoriesSelectedGroup;

@end

@interface ShopCategoriesViewController : ViewController

@property (nonatomic, assign) id<ShopCategoriesDelegate> delegate;

@end
