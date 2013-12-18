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
    
    ASIOperationPlacelistGetList *_operationPlacelistGetList;
    
    int _pagePlacelist;
    NSMutableArray *_placeLists;
    bool _canLoadMorePlaceList;
    bool _isLoadingMore;
}

-(SearchShopViewController*) initWithKeyword:(NSString*) keyword;

@property (nonatomic, weak) id<SearchShopControllerDelegate> delegate;

@end