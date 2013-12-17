//
//  SearchShopViewController.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SearchViewController.h"

@class SearchShopViewController;

@protocol SearchShopControllerDelegate <SGViewControllerDelegate>

-(void) searchShopControllerTouchedBack:(SearchShopViewController*) controller;
-(void) searchShopControllerSearch:(SearchShopViewController*) controller keyword:(NSString*) keyword;
-(void) searchShopControllerTouchPlaceList:(SearchShopViewController*) controller;

@end

@interface SearchShopViewController : SGViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SearchControllerHandle>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UIView *topView;
    
    NSString *_keyword;
}

-(SearchShopViewController*) initWithKeyword:(NSString*) keyword;

@property (nonatomic, weak) id<SearchShopControllerDelegate> delegate;

@end