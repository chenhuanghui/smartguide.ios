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

@interface SearchViewController : UIViewController<TableTemplateDelegate,ASIOperationPostDelegate,UIGestureRecognizerDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIView *blurTop;
    __weak IBOutlet UIView *blurBot;
    __weak IBOutlet UIView *searchView;
    __weak IBOutlet UIView *filterView;
    
    __weak IBOutlet UIView *food;
    __weak IBOutlet UIView *drink;
    __weak IBOutlet UIView *health;
    __weak IBOutlet UIView *entertaiment;
    __weak IBOutlet UIView *fashion;
    __weak IBOutlet UIView *travel;
    __weak IBOutlet UIView *production;
    __weak IBOutlet UIView *education;

    __weak IBOutlet UIButton *btnLike;
    __weak IBOutlet UIButton *btnView;
    __weak IBOutlet UIButton *btnDistance;
    __weak IBOutlet UIButton *btnShopKM;
    
    TableTemplate *templateTable;
    ASIOperationSearchShop *_operation;
    NSString *_searchText;
    NSString *_groups;
    enum SORT_BY _sortBy;
    enum SHOP_PROMOTION_FILTER_TYPE _promotionFilter;
    
    __weak Shop *_selectedShop;
    NSIndexPath *_selectedRow;
    __weak UITapGestureRecognizer *tapGes;
}

-(void) search:(NSString*) text;
-(void) handleResult:(NSArray*) shops text:(NSString*) text page:(int) page groups:(NSString*) groups sortBy:(enum SORT_BY) sortBy promotionFilter:(enum SHOP_PROMOTION_FILTER_TYPE) promotionFilter;
-(void) cancelSearch;
-(NSString*) searchText;
-(NSArray*) result;
-(int) page;
-(Shop*) selectedShop;
-(NSIndexPath*) selectedRow;
-(NSString*) groups;
-(enum SORT_BY) sortBy;
-(enum SHOP_PROMOTION_FILTER_TYPE) promotionFilter;

- (IBAction)btnCheckAllTouchUpInside:(id)sender;
- (IBAction)btnCheckNonTouchUpInside:(id)sender;
- (IBAction)btnGetAwardTouchUpInside:(id)sender;
- (IBAction)btnGetPointTouchUpInside:(id)sender;
- (IBAction)btnMostLikeTouchUpInside:(id)sender;
- (IBAction)btnMostViewTouchUpInside:(id)sender;
- (IBAction)btnDistanceTouchUpInside:(id)sender;
- (IBAction)btnShopKMTouchUpInside:(id)sender;

@property (nonatomic, assign) id<SearchViewDelegate> delegate;

@end
