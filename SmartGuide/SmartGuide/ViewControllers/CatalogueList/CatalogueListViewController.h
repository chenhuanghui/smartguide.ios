//
//  CatalogueListViewController.h
//  SmartGuide
//
//  Created by XXX on 7/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "ShopCatalog.h"
#import "CatalogueListCell.h"
#import "ASIOperationShopInGroup.h"
#import "TableTemplate.h"
#import "RootViewController.h"
#import "SlideQRCodeViewController.h"
#import "Flags.h"
#import "LocationManager.h"

enum LIST_MODE {
    LIST_SHOP = 0,
    LIST_SEARCH = 1,
    };

@class CatalogueListViewController,ShopDetailViewController,TemplateList,TemplateSearch,TableList;

@interface CatalogueListViewController : ViewController<TableTemplateDelegate,ASIOperationPostDelegate,SlideQRCodeDelegate>
{
    __weak IBOutlet TableList *tableShop;
    __weak IBOutlet UIView *blurTop;
    __weak IBOutlet UIView *blurBottom;
    
    bool _isInitedShopDetail;
    bool _isNeedReload;
    UIImageView *imgvTutorial;
    UIImageView *imgvTutorialText;
}

-(void) reloadDataForChangedCity:(int) city;
-(void) loadGroup:(ShopCatalog*) group city:(int) city sortType:(enum SORT_BY) sortBy;
-(void) loadGroups:(NSArray*) group sortType:(enum SORT_BY) sortBy city:(int) city;
-(void) handleSearchResult:(NSString*) searchKey result:(NSArray*) array page:(int) page selectedShop:(Shop*) selectedShop selectedRow:(NSIndexPath*) lastSelectedRow sortBy:(enum SORT_BY) sortBy promotionFilter:(enum SHOP_PROMOTION_FILTER_TYPE) promotionFilter groups:(NSString*) groups;

-(void) pushShopDetailWithShop:(Shop*) shop animated:(bool) animate;
-(void) showShopDetail;

-(void) switchToModeList;
-(void) setIsNeedReload;

-(NSArray*) currentShops;

@property (nonatomic, strong) TemplateSearch *templateSearch;
@property (nonatomic, strong) TemplateList *templateList;

@property (nonatomic, assign) id<CatalogueListViewDelegate> delegate;
@property (nonatomic, readonly) enum LIST_MODE mode;

@end

// Su dung de debug
@interface CatalogueListView : UIView
@end

@interface TemplateList : TableTemplate<ASIOperationPostDelegate>

-(void) loadShopAtPage:(int) page;
-(void) reset;

@property (nonatomic, assign) Shop *selectedShop;
@property (nonatomic, strong) NSIndexPath *lastSelectedRow;
@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, readonly) ShopCatalog *firstGroup;
@property (nonatomic, assign) int city;
@property (nonatomic, assign) enum SORT_BY sortBy;
@property (nonatomic, strong) ASIOperationShopInGroup *opeartionShopInGroup;
@property (nonatomic, assign) CatalogueListViewController *catalogueList;

@end

@interface TemplateSearch : TableTemplate<ASIOperationPostDelegate>

-(TemplateSearch*) initWithSearchKey:(NSString*) searchKey result:(NSArray*) array page:(int) page withTableView:(UITableView*) table withDelegate:(id<TableTemplateDelegate>) delegate selectedShop:(Shop*) selectedShop selectedRow:(NSIndexPath*) lastSelectedRow sortBy:(enum SORT_BY) sortBy groups:(NSString*) groups promotionFilter:(enum SHOP_PROMOTION_FILTER_TYPE) promotionFilter;

-(void) loadAtPage:(int) page;
-(void) reset;

@property (nonatomic, strong) NSString *searchKey;
@property (nonatomic, assign) enum SORT_BY sortBy;
@property (nonatomic, assign) enum SHOP_PROMOTION_FILTER_TYPE promotionFilter;
@property (nonatomic, strong) NSString *groups;
@property (nonatomic, assign) Shop *selectedShop;
@property (nonatomic, strong) NSIndexPath *lastSelectedRow;
@property (nonatomic, strong) ASIOperationSearchShop *operationSearchShop;
@property (nonatomic, assign) CatalogueListViewController *catalogueList;

@end

@interface TableList : UITableView

@end