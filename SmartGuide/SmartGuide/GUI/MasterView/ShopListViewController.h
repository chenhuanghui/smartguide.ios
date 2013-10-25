//
//  ShopListViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

@protocol ShopListDelegate <NSObject>

-(void) shopListSelectedShop;

@end

@interface ShopListViewController : ViewController

@property (nonatomic, assign) id<ShopListDelegate> delegate;

@end
