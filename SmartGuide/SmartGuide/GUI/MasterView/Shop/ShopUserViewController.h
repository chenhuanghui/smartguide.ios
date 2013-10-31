//
//  ShopUserViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Shop.h"

@protocol ShopUserDelegate <NSObject>

-(void) shopUserFinished;

@end

@interface ShopUserViewController : SGViewController

+(ShopUserViewController*) shareInstance;
-(void) setShop:(Shop*) shop;

@property (nonatomic, assign) id<ShopUserDelegate> delegate;

@end
