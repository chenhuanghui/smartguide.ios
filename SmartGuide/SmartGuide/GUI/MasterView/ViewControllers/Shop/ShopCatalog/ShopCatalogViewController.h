//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "Constant.h"
#import "ASIOperationShopCatalog.h"
#import "ShopViewController.h"

@interface ShopCatalogViewController : SGViewController<ASIOperationPostDelegate,ShopControllerHandle>
{
    ASIOperationShopCatalog *_operationShopCatalog;
    
    __weak IBOutlet UIView *groupAll;
    __weak IBOutlet UIView *groupFood;
    __weak IBOutlet UIView *groupDrink;
    __weak IBOutlet UIView *groupHealth;
    __weak IBOutlet UIView *groupEntertaiment;
    __weak IBOutlet UIView *groupFashion;
    __weak IBOutlet UIView *groupTravel;
    __weak IBOutlet UIView *groupProduction;
    __weak IBOutlet UIView *groupEducation;
    
    UIView *_launchingView;
}

@property (nonatomic, assign) id<ShopCatalogDelegate> delegate;

@end
