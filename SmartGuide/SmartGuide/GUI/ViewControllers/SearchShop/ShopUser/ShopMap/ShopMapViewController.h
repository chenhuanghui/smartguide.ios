//
//  ShopMapViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "MapView.h"
#import "Shop.h"

@interface ShopMapViewController : SGViewController
{
    __weak IBOutlet MapView *map;
    
    __weak Shop* _shop;
    bool _didRouterUserLocation;
}

-(ShopMapViewController*) initWithShop:(Shop*) shop;

@end