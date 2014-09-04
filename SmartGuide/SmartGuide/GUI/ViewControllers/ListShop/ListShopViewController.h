//
//  ListShopViewController.h
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

@class Button, NavigationView, NavigationTitleLabel, TableAPI;

@interface ListShopViewController : ViewController
{
    __weak IBOutlet NavigationView *titleView;
    __weak IBOutlet NavigationTitleLabel *lblTitle;
    __weak IBOutlet Button *btnBack;
    __weak IBOutlet TableAPI *table;
}

-(ListShopViewController*) initWithIDPlacelist:(int) idPlacelist;
-(ListShopViewController*) initWithIDShops:(NSString*) idShops;
-(ListShopViewController*) initWithKeyword:(NSString*) keyword;
-(ListShopViewController*) initWithIDBrand:(int) idBrand;

@property (nonatomic, assign, readonly) int idPlacelist;
@property (nonatomic, strong, readonly) NSString *idShops;
@property (nonatomic, strong, readonly) NSString *keyword;
@property (nonatomic, assign, readonly) int idBrand;

@end
