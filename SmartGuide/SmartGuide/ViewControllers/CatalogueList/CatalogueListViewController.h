//
//  CatalogueListViewController.h
//  SmartGuide
//
//  Created by XXX on 7/11/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "Group.h"
#import "CatalogueListCell.h"
#import "ASIOperationShopInGroup.h"
#import "TableTemplate.h"
#import "RootViewController.h"
#import "SlideQRCodeViewController.h"

enum LIST_MODE {
    LIST_SHOP = 0,
    LIST_SEARCH = 1,
    };

@class CatalogueListViewController,ShopDetailViewController,TemplateList,TemplateSearch,TableList;

@protocol CatalogueListViewDelegate <NSObject>

-(void) catalogueListLoadShopFinished:(CatalogueListViewController*) catalogueListView;

@end

@interface CatalogueListViewController : ViewController<TableTemplateDelegate,ASIOperationPostDelegate,SlideQRCodeDelegate>
{
    __weak IBOutlet TableList *tableShop;
    __weak IBOutlet UIButton *btnUp;
    __weak IBOutlet UIButton *btnDown;
    __weak IBOutlet UIView *blurTop;
    __weak IBOutlet UIView *blurBottom;
    
    bool _isInitedShopDetail;
}

-(void) loadGroup:(Group*) group city:(City*) city;
-(void) loadGroups:(NSArray*) group;
-(void) handleSearchResult:(NSString*) searchKey result:(NSArray*) array page:(int) page selectedShop:(Shop*) selectedShop selectedRow:(NSIndexPath*) lastSelectedRow;

-(void) pushShopDetailWithShop:(Shop*) shop animated:(bool) animate;

-(void) switchToModeList;

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
@property (nonatomic, readonly) Group *firstGroup;
@property (nonatomic, strong) City *city;
@property (nonatomic, strong) ASIOperationShopInGroup *opeartionShopInGroup;
@property (nonatomic, assign) CatalogueListViewController *catalogueList;

@end

@interface TemplateSearch : TableTemplate<ASIOperationPostDelegate>

-(TemplateSearch*) initWithSearchKey:(NSString*) searchKey result:(NSArray*) array page:(int) page withTableView:(UITableView*) table withDelegate:(id<TableTemplateDelegate>) delegate selectedShop:(Shop*) selectedShop selectedRow:(NSIndexPath*) lastSelectedRow;

-(void) loadAtPage:(int) page;
-(void) reset;

@property (nonatomic, strong) NSString *searchKey;
@property (nonatomic, assign) Shop *selectedShop;
@property (nonatomic, strong) NSIndexPath *lastSelectedRow;
@property (nonatomic, strong) ASIOperationSearchShop *operationSearchShop;
@property (nonatomic, assign) CatalogueListViewController *catalogueList;

@end

@interface TableList : UITableView

@end