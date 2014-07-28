//
//  SearchShopViewController.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SearchViewController.h"

enum SEARCH_SHOP_VIEW_MODE {
    SEARCH_SHOP_VIEW_PLACELIST = 0,
    SEARCH_SHOP_VIEW_AUTOCOMPLETE = 1
    };

@class SearchShopViewController,SearchShopBGView;

@protocol SearchShopControllerDelegate <SGViewControllerDelegate>

-(void) searchShopControllerTouchedBack:(SearchShopViewController*) controller;
-(void) searchShopControllerSearch:(SearchShopViewController*) controller keyword:(NSString*) keyword;
-(void) searchShopControllerTouchPlaceList:(SearchShopViewController*) controller placeList:(Placelist*) place;
-(void) searchShopControllerTouchedIDPlacelist:(SearchShopViewController*) controller idPlacelist:(int) idPlacelist;

@end

@interface SearchShopViewController : SGViewController<SearchControllerHandle>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UIButton *btnSearch;
    __weak IBOutlet UIButton *btnCity;
    __weak IBOutlet UIView *bgCity;
    __weak IBOutlet UIScrollView *scroll;
    
    int _idCity;
    
    NSString *_keyword;
    NSString *_searchKey;
    NSString *_searchDisplayKey;
    
    //key: text người dùng nhập
    //value: 1 dictionary 2 KVP
    //value 1: key shop value array shops-dictionary từ api
    //value 2: key placelist value array placelist-dictionary từ api
    NSMutableDictionary *_autocomplete;
    NSMutableArray *_searchInQuery;
    
    int _pagePlacelist;
    NSMutableArray *_placeLists;
    bool _canLoadMorePlaceList;
    bool _isLoadingMore;
    
    CGRect _tableFrame;
    
    NSMutableDictionary *_operationsAutocompleted;
}

-(SearchShopViewController*) initWithKeyword:(NSString*) keyword;

-(void) setKeyword:(NSString*) keyword;

@property (nonatomic, weak) id<SearchShopControllerDelegate> delegate;

@end

@interface SearchShopBGView : UIView
{
    UIImage *imgMid;
    UIImage *imgTop;
    UIImage *imgBottom;
}

@end