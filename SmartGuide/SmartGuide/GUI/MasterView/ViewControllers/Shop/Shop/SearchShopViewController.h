//
//  SearchShopViewController.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SearchViewController.h"
#import "ASIOperationPlacelistGetList.h"
#import "ASIOperationSearchAutocomplete.h"

@class SearchShopViewController;

@protocol SearchShopControllerDelegate <SGViewControllerDelegate>

-(void) searchShopControllerTouchedBack:(SearchShopViewController*) controller;
-(void) searchShopControllerSearch:(SearchShopViewController*) controller keyword:(NSString*) keyword;
-(void) searchShopControllerTouchPlaceList:(SearchShopViewController*) controller placeList:(Placelist*) place;

@end

@interface SearchShopViewController : SGViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SearchControllerHandle,ASIOperationPostDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UIView *topView;
    
    NSString *_keyword;
    __weak Placelist *_placelist;
    
    //key: text người dùng nhập
    //value: 1 dictionary 2 KVP
    //value 1: key shop value array shops-dictionary từ api
    //value 2: key placelist value array placelist-dictionary từ api
    NSMutableDictionary *_autocomplete;
    
    ASIOperationPlacelistGetList *_operationPlacelistGetList;
    
    int _pagePlacelist;
    NSMutableArray *_placeLists;
    bool _canLoadMorePlaceList;
    bool _isLoadingMore;
}

-(SearchShopViewController*) initWithKeyword:(NSString*) keyword;
-(SearchShopViewController*) initWithPlacelist:(Placelist*) place;

-(void) setKeyword:(NSString*) keyword;
-(void) setPlacelist:(Placelist*) place;

@property (nonatomic, weak) id<SearchShopControllerDelegate> delegate;

@end