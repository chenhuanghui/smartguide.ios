//
//  SearchViewController.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"

enum SEARCH_VIEW_MODE {
    SEARCH_VIEW_MODE_SEARCH = 0,
    SEARCH_VIEW_MODE_LIST = 1
    };

@class ShopListViewController,SearchViewController;

@protocol SearchControllerHandle <NSObject>

@property (nonatomic, weak) SearchViewController *searchController;

@end

@interface SearchViewController : SGViewController
{
    __weak SGNavigationController *searchNavi;
    __weak IBOutlet UIView *contentView;
    
    enum SEARCH_VIEW_MODE _viewMode;
}

-(SearchViewController*) initWithSearch;
-(SearchViewController*) initWithKeyword:(NSString*) keyword;
-(SearchViewController*) initWithPlaceLists;

@end