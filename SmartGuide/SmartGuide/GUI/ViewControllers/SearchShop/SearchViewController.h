//
//  SearchViewController.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "UserHome.h"

enum SEARCH_VIEW_MODE {
    SEARCH_VIEW_MODE_SEARCH = 0,
    SEARCH_VIEW_MODE_LIST = 1,
    SEARCH_VIEW_MODE_SHOP_LIST = 2,
    SEARCH_VIEW_MODE_HOME_3 = 3,
    SEARCH_VIEW_MODE_KEYWORK_SHOP_LIST = 4,
    SEARCH_VIEW_MODE_IDPLACE = 5,
    };

@class ShopListViewController,SearchViewController,SearchShopViewController,Placelist;

@protocol SearchControllerHandle <NSObject>

@property (nonatomic, weak) SearchViewController *searchController;

@end

@interface SearchViewController : SGViewController
{
    __strong SGNavigationController *searchNavi;
    __weak IBOutlet UIView *contentView;
    
    enum SEARCH_VIEW_MODE _viewMode;
    __weak Placelist *_place;
    __weak UserHome3 *_home3;
    NSString *_idShops;
    NSString *_keyword;
    int _idPlacelist;
}

-(SearchViewController*) initWithKeyword:(NSString*) keyword;
-(SearchViewController*) initWithPlace:(Placelist*) place;
-(SearchViewController*) initWithIDPlace:(int) idPlace;
-(SearchViewController*) initWithIDShops:(NSString*) idShops;
-(SearchViewController*) initWithKeyword:(NSString*) keyword viewMode:(enum SEARCH_VIEW_MODE) viewMode;

@end