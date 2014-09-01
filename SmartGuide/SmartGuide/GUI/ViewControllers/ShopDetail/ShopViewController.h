//
//  ShopDetailViewController.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@class TableShopInfo;

@interface ShopViewController : ViewController
{
    __weak IBOutlet TableShopInfo *table;
}

-(ShopViewController*) initWithIDShop:(int) idShop;

@end

@interface TableShopInfo : UITableView

@end