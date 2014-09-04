//
//  ListShopViewController.m
//  Infory
//
//  Created by XXX on 9/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ListShopViewController.h"
#import "OperationShopList.h"
#import "OperationPlacelistDetail.h"
#import "OperationPlacelistGet.h"
#import "OperationSearchShop.h"
#import "TabHomeShopCell.h"
#import "ListShopPlacelistTableCell.h"
#import "TableTemplates.h"
#import "Button.h"
#import "NavigationView.h"
#import "Place.h"

enum LIST_SHOP_DATA_TYPE
{
    LIST_SHOP_DATA_TYPE_KEYWORD=0,
    LIST_SHOP_DATA_TYPE_PLACE=1,
    LIST_SHOP_DATA_TYPE_IDSHOPS=2,
    LIST_SHOP_DATA_TYPE_IDBRAND=3,
};

@interface ListShopViewController ()<ASIOperationPostDelegate, TableAPIDataSource, UITableViewDelegate>
{
    OperationShopList *_opeShopList;
    OperationPlacelistDetail *_opePlacelistDetail;
    OperationPlacelistGet *_opePlacelistGet;
    OperationSearchShop *_opeSearchShop;
    
    NSUInteger _page;
    bool _canLoadMore;
    bool _loadingMore;
}

@property (nonatomic, assign) enum LIST_SHOP_DATA_TYPE dataType;
@property (nonatomic, strong) Place *place;
@property (nonatomic, strong) NSMutableArray *shops;

@end

@implementation ListShopViewController

-(ListShopViewController *)initWithIDPlacelist:(int)idPlacelist
{
    self=[super init];
    
    _idPlacelist=idPlacelist;
    _dataType=LIST_SHOP_DATA_TYPE_PLACE;
    
    return self;
}

-(ListShopViewController *)initWithIDShops:(NSString *)idShops
{
    self=[super init];
    
    _idShops=[idShops copy];
    _dataType=LIST_SHOP_DATA_TYPE_IDSHOPS;
    
    return self;
}

-(ListShopViewController *)initWithKeyword:(NSString *)keyword
{
    self=[super init];
    
    _keyword=[keyword copy];
    _dataType=LIST_SHOP_DATA_TYPE_KEYWORD;
    
    return self;
}

-(ListShopViewController *)initWithIDBrand:(int)idBrand
{
    self=[super init];
    
    _idBrand=idBrand;
    _dataType=LIST_SHOP_DATA_TYPE_IDBRAND;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnBack.layoutType=BUTTON_LAYOUT_TYPE_BACK;
    
    [table registerListShopPlacelistTableCell];
    [table registerTabHomeShopCell];
    
    _canLoadMore=false;
    _loadingMore=false;
    _page=0;
    table.canLoadMore=false;
    
    self.shops=[NSMutableArray array];
    
    switch (_dataType) {
        case LIST_SHOP_DATA_TYPE_IDSHOPS:
            
            lblTitle.text=@"";
            [self requestIDShops];
            [table showLoading];
            
            break;
            
        case LIST_SHOP_DATA_TYPE_IDBRAND:
            
            lblTitle.text=@"";
            [self requestBrand];
            [table showLoading];
            
            break;
            
        case LIST_SHOP_DATA_TYPE_KEYWORD:
            
            lblTitle.text=_keyword;
            [self requestShopSearch];
            [table showLoading];
            
            break;
            
        case LIST_SHOP_DATA_TYPE_PLACE:
            
            lblTitle.text=@"";
            [self requestPlaceDetail];
            [table showLoading];
            
            break;
    }
}

-(void) requestShopSearch
{
    _opeSearchShop=[[OperationSearchShop alloc] initWithKeyword:_keyword userLat:userLat() userLng:userLng() page:_page sort:SHOP_LIST_SORT_TYPE_DEFAULT idCity:currentUser().idCity.integerValue];
    _opeSearchShop.delegate=self;
    
    [_opeSearchShop addToQueue];
}

-(void) requestPlaceDetail
{
    _opePlacelistDetail=[[OperationPlacelistDetail alloc] initWithIDPlace:_idPlacelist userLat:userLat() userLng:userLng() sort:PLACE_SORT_TYPE_DEFAULT];
    _opePlacelistDetail.delegate=self;
    
    [_opePlacelistDetail addToQueue];
}

-(void) requestPlaceGet
{
    _opePlacelistGet=[[OperationPlacelistGet alloc] initWithIDPlace:_idPlacelist userLat:userLat() userLng:userLng() sort:PLACE_SORT_TYPE_DEFAULT page:_page];
    _opePlacelistGet.delegate=self;
    
    [_opePlacelistGet addToQueue];
}

-(void) requestIDShops
{
    _opeShopList=[[OperationShopList alloc] initWithIDShops:_idShops idBrand:0 userLat:userLat() userLng:userLng() page:_page sort:SHOP_LIST_SORT_TYPE_DEFAULT];
    _opeShopList.delegate=self;
    
    [_opeShopList addToQueue];
}

-(void) requestBrand
{
    _opeShopList=[[OperationShopList alloc] initWithIDShops:nil idBrand:_idBrand userLat:userLat() userLng:userLng() page:_page sort:SHOP_LIST_SORT_TYPE_DEFAULT];
    _opeShopList.delegate=self;
    
    [_opeShopList addToQueue];
}

#pragma mark UITableView DataSource

-(void)tableLoadMore:(TableAPI *)tableAPI
{
    if(_loadingMore)
        return;
    
    _loadingMore=true;
    
    switch (_dataType) {
        case LIST_SHOP_DATA_TYPE_KEYWORD:
            [self requestShopSearch];
            break;
            
        case LIST_SHOP_DATA_TYPE_PLACE:
            [self requestPlaceGet];
            break;
            
        case LIST_SHOP_DATA_TYPE_IDSHOPS:
            [self requestIDShops];
            break;
            
        case LIST_SHOP_DATA_TYPE_IDBRAND:
            [self requestBrand];
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_dataType) {
        case LIST_SHOP_DATA_TYPE_KEYWORD:
            return MIN(_shops.count, 1);
            
        case LIST_SHOP_DATA_TYPE_PLACE:
            
            if(!_place)
                return 0;
            
            return 2;
            
        case LIST_SHOP_DATA_TYPE_IDSHOPS:
            return MIN(_shops.count, 1);
            
        case LIST_SHOP_DATA_TYPE_IDBRAND:
            return MIN(_shops.count, 1);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_dataType) {
        case LIST_SHOP_DATA_TYPE_KEYWORD:
            return _shops.count;
            
        case LIST_SHOP_DATA_TYPE_PLACE:
            if(section==0)
                return 1;
            else
                return _shops.count;
            
        case LIST_SHOP_DATA_TYPE_IDSHOPS:
            return _shops.count;
            
        case LIST_SHOP_DATA_TYPE_IDBRAND:
            return _shops.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_dataType) {
        case LIST_SHOP_DATA_TYPE_KEYWORD:
            return [[tableView tabHomeShopPrototypeCell] calculateHeight:_shops[indexPath.row]];
            
        case LIST_SHOP_DATA_TYPE_PLACE:
            if(indexPath.section==0)
                return [[tableView listShopPlacelistTablePrototypeCell] calculatorHeight:_place];
            else
                return [[tableView tabHomeShopPrototypeCell] calculateHeight:_shops[indexPath.row]];
            
        case LIST_SHOP_DATA_TYPE_IDSHOPS:
            return [[tableView tabHomeShopPrototypeCell] calculateHeight:_shops[indexPath.row]];
            
        case LIST_SHOP_DATA_TYPE_IDBRAND:
            return [[tableView tabHomeShopPrototypeCell] calculateHeight:_shops[indexPath.row]];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_dataType) {
        case LIST_SHOP_DATA_TYPE_KEYWORD:
        {
            TabHomeShopCell *cell=[tableView tabHomeShopCell];
            
            [cell loadWithShopInfoList:_shops[indexPath.row]];
            
            return cell;
        }
            
        case LIST_SHOP_DATA_TYPE_PLACE:
        {
            if(indexPath.section==0)
            {
                ListShopPlacelistTableCell *cell=[tableView listShopPlacelistTableCell];
                
                [cell loadWithPlace:_place];
                
                return cell;
            }
            else
            {
                TabHomeShopCell *cell=[tableView tabHomeShopCell];
                
                [cell loadWithShopInfoList:_shops[indexPath.row]];
                
                return cell;
            }
        }
            
        case LIST_SHOP_DATA_TYPE_IDSHOPS:
        {
            TabHomeShopCell *cell=[tableView tabHomeShopCell];
            
            [cell loadWithShopInfoList:_shops[indexPath.row]];
            
            return cell;
        }
            
        case LIST_SHOP_DATA_TYPE_IDBRAND:
        {
            TabHomeShopCell *cell=[tableView tabHomeShopCell];
            
            [cell loadWithShopInfoList:_shops[indexPath.row]];
            
            return cell;
        }
    }
}

#pragma mark ASIOperation Delegate

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationSearchShop class]])
    {
        [table removeLoading];
        
        OperationSearchShop *ope=(id)operation;
        
        [_shops addObjectsFromArray:ope.shops];
        _canLoadMore=ope.shops.count>=10;
        _loadingMore=false;
        _page++;
        
        table.canLoadMore=_canLoadMore;
        [table reloadData];
        
        _opeSearchShop=nil;
    }
    else if([operation isKindOfClass:[OperationPlacelistDetail class]])
    {
        [table removeLoading];
        
        OperationPlacelistDetail *ope=(id)operation;
        
        self.place=ope.place;
        self.shops=[NSMutableArray array];
        [_shops addObjectsFromArray:ope.shops];
        lblTitle.text=self.place.title;
        
        _canLoadMore=ope.shops.count>=10;
        _loadingMore=false;
        _page=0;
        
        table.canLoadMore=_canLoadMore;
        [table reloadData];
        
        _opePlacelistDetail=nil;
    }
    else if([operation isKindOfClass:[OperationPlacelistGet class]])
    {
        [table removeLoading];
        
        OperationPlacelistGet *ope=(id)operation;
        
        [_shops addObjectsFromArray:ope.shops];
        _canLoadMore=ope.shops.count>=10;
        _loadingMore=false;
        _page++;
        
        table.canLoadMore=_canLoadMore;
        [table reloadData];
        
        _opePlacelistGet=nil;
    }
    else if([operation isKindOfClass:[OperationShopList class]])
    {
        [table removeLoading];
        
        OperationShopList *ope=(id)operation;
        
        [_shops addObjectsFromArray:ope.shops];
        _canLoadMore=ope.shops.count>=10;
        _loadingMore=false;
        _page++;
        
        table.canLoadMore=_canLoadMore;
        [table reloadData];
        
        _opeShopList=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)dealloc
{
    OperationRelease(_opePlacelistDetail);
    OperationRelease(_opePlacelistGet);
    OperationRelease(_opeSearchShop);
    OperationRelease(_opeShopList);
}

@end
