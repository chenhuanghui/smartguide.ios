//
//  ShopMenu.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopDetailViewController.h"

@interface ShopMenu : UIView<UITableViewDataSource,UITableViewDelegate,ShopViewHandle>
{
    __weak IBOutlet UITableView *tableMenu;
    __weak Shop *_shop;
    NSMutableDictionary *_productType;
    NSArray *_productTypeName;
    NSNumberFormatter *_priceFormat;
}

-(ShopMenu*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

@end
