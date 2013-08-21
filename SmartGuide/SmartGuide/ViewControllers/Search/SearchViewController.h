//
//  SearchViewController.h
//  SmartGuide
//
//  Created by XXX on 8/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableTemplate.h"
#import "ASIOperationSearchShop.h"

@class Shop,SearchViewController;

@protocol SearchViewDelegate <NSObject>

-(void) searchView:(SearchViewController*) searchView selectedShop:(Shop*) shop;

@end

@interface SearchViewController : UIViewController<TableTemplateDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UITableView *table;
    TableTemplate *templateTable;
    ASIOperationSearchShop *_operation;
    NSString *_searchText;
    
    __weak Shop *_selectedShop;
    NSIndexPath *_selectedRow;
}

-(void) search:(NSString*) text;
-(void) handleResult:(NSArray*) shops text:(NSString*) text page:(int) page;
-(void) cancelSearch;
-(NSString*) searchText;
-(NSArray*) result;
-(int) page;
-(Shop*) selectedShop;
-(NSIndexPath*) selectedRow;

@property (nonatomic, assign) id<SearchViewDelegate> delegate;

@end
