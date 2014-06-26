//
//  ShopListViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListViewController.h"
#import "GUIManager.h"
#import "ShopListCell.h"
#import "RootViewController.h"
#import "EmptyDataView.h"
#import "LoadingMoreCell.h"
#import "ShopPinInfoView.h"
#import "ShopPinView.h"
#import "ShopListCell.h"
#import "QRCodeViewController.h"
#import "CityViewController.h"
#import "CityManager.h"
#import "Constant.h"
#import "ShopUserViewController.h"
#import <MapKit/MapKit.h>
#import "ShopListSortView.h"
#import "MapView.h"
#import "ShopListPlaceCell.h"
#import "ASIOperationShopSearch.h"
#import "ASIOperationPlacelistGet.h"
#import "ASIOperationPlacelistGetDetail.h"
#import "ASIOperationGetShopList.h"
#import "Placelist.h"
#import "PlacelistViewController.h"
#import "ShopListMapCell.h"
#import "ASIOperationRemoveShopPlacelist.h"
#import "TextField.h"

#define SHOP_LIST_SCROLL_SPEED 3.f

@interface ShopListViewController ()<ShopPinDelegate,ShopListMapDelegate,ShopListCellDelegate,TextFieldDelegate,CityControllerDelegate,MKMapViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,SortSearchDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,ASIOperationPostDelegate,UITextFieldDelegate,PlacelistControllerDelegate>
{
    ASIOperationShopSearch *_operationShopSearch;
    ASIOperationPlacelistGet *_operationPlaceListDetail;
    ASIOperationGetShopList *_operationShopList;
    ASIOperationPlacelistGetDetail *_operationPlacelistGetDetail;
    ASIOperationRemoveShopPlacelist *_operationRemoveShopPlacelist;
}

@end

@implementation ShopListViewController
@synthesize delegate,searchController;

-(ShopListViewController *)initWithIDPlacelist:(int)idPlacelist
{
    self=[super initWithNibName:@"ShopListViewController" bundle:nil];
    
    _idPlacelist=idPlacelist;
    _viewMode=SHOP_LIST_VIEW_IDPLACE;
    
    return self;
}

-(ShopListViewController *)initWithKeyword:(NSString *)keyword
{
    self=[super initWithNibName:@"ShopListViewController" bundle:nil];
    
    _keyword=[NSString stringWithStringDefault:keyword];
    _viewMode=SHOP_LIST_VIEW_LIST;
    
    return self;
}

-(ShopListViewController *)initWithPlaceList:(Placelist *)placeList
{
    self=[super initWithNibName:@"ShopListViewController" bundle:nil];
    
    _placeList=placeList;
    _viewMode=SHOP_LIST_VIEW_PLACE;
    
    return self;
}

-(ShopListViewController *)initWithIDShops:(NSString *)idShops
{
    self=[super initWithNibName:@"ShopListViewController" bundle:nil];
    
    _idShops=[NSString stringWithStringDefault:idShops];
    _viewMode=SHOP_LIST_VIEW_SHOP_LIST;
    
    return self;
}

-(ShopListViewController *)initWithIDBranch:(int)idBranch
{
    self=[super initWithNibName:@"ShopListViewController" bundle:nil];

    _idShops=@"";
    _idBranch=idBranch;
    _viewMode=SHOP_LIST_VIEW_BRANCH;
    
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==tableList)
    {
        if(mapCell)
        {
            [mapCell tableDidScroll];
        }
        
        for(ShopListCell *cell in tableList.visibleCells)
        {
            if([cell isKindOfClass:[ShopListCell class]])
                [cell tableDidScroll];
        }
        
        if(scrollerView)
        {
            [self makeScrollerTitle];
        }
        
        if(!_isAnimatingZoom && !_isZoomedMap)
        {
            if(_placeList || _shopsList.count>0)
            {
                if(tableList.offsetYWithInsetTop>115)
                {
                    [UIView animateWithDuration:0.3f animations:^{
                        [self smallQRCode];
                    }];
                }
                else
                {
                    [UIView animateWithDuration:0.3f animations:^{
                        [self bigQRCode];
                    }];
                }
            }
        }
    }
}

-(void) makeScrollerTitle
{
    float per=tableList.l_co_y/(tableList.l_cs_h-tableList.l_v_h);
    
    [scrollerView l_v_setY:_scrollerViewFrame.origin.y+tableList.l_co_y+per*(visibleScrollerView.l_v_h-29)];
    
    NSIndexPath *indexPath=[tableList indexPathForRowAtPoint:scrollerView.l_v_o];
    
    if(indexPath)
    {
        UITableViewCell *cell=[tableList cellForRowAtIndexPath:indexPath];
        
        if([cell isKindOfClass:[ShopListCell class]])
        {
            ShopListCell *sCell=(ShopListCell*)cell;
            [scrollerView setTitle:(sCell.shopList.distance.length==0?sCell.shopList.numOfView:sCell.shopList.distance)];
        }
        else if([cell isKindOfClass:[ShopListMapCell class]])
        {
            [scrollerView setTitle:@"Bản đồ"];
        }
        else if([cell isKindOfClass:[ShopListPlaceCell class]])
        {
            [scrollerView setTitle:@"Danh sách địa điểm"];
        }
    }
}

-(void) reloadTable
{
    for(ShopListCell *cell in tableList.visibleCells)
    {
        if([cell isKindOfClass:[ShopListCell class]])
            [cell removeObserver];
    }
    
    [tableList reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count=0;
    
    count++;//map
    
    if(_placeList)
        count++;
    
    if(_shopsList.count>0)
        count++;
    
    return count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 1;
    
    if(section==1)
    {
        if(_placeList)
            return 1;
    }
    
    return _shopsList.count+(_canLoadMore?1:0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return _mapRowHeight;;
    }
    
    if(indexPath.section==1)
    {
        if(_placeList)
        {
            return [ShopListPlaceCell heightWithContent:_placeList.desc];
        }
    }
    
    if(_canLoadMore && indexPath.row==_shopsList.count)
        return 88;
    
    return [ShopListCell heightWithShopList:_shopsList[indexPath.row]];
}

-(void) loadMore
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
            [self requestShopSearch];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
            [self requestPlacelistDetail];
            break;
            
        case SHOP_LIST_VIEW_SHOP_LIST:
        case SHOP_LIST_VIEW_BRANCH:
            [self requestShopList];
            break;
    }
}

-(ShopListCell*) cellWithShopList:(ShopList*) shop indexPath:(NSIndexPath*) indexPath
{
    ShopListCell *cell=[tableList dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
    cell.delegate=self;
    
    [cell loadWithShopList:shop];
    cell.table=tableList;
    cell.indexPath=indexPath;
    cell.controller=self;
    
    return cell;
}

-(ShopListPlaceCell*) placeCell
{
    ShopListPlaceCell *cell=[tableList dequeueReusableCellWithIdentifier:[ShopListPlaceCell reuseIdentifier]];
    
    [cell loadWithPlace:_placeList];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        if(mapCell)
            return mapCell;
        
        ShopListMapCell *cell=[tableList dequeueReusableCellWithIdentifier:[ShopListMapCell reuseIdentifier]];
        
        cell.table=tableView;
        cell.indexPath=indexPath;
        sortView=cell.sortView;
        sortView.delegate=self;
        cell.delegate=self;
        
        [self makeSortLayout];
        
        mapCell=cell;
        map=mapCell.map;
        map.delegate=self;
        
        return cell;
    }
    
    if(indexPath.section==1)
    {
        if(_placeList)
        {
            return [self placeCell];
        }
    }
    
    if(_canLoadMore && indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
    {
        if(!_isLoadingMore)
        {
            _isLoadingMore=true;
            
            [self loadMore];
        }
        
        return [tableView loadingMoreCell];
    }
    
    return [self cellWithShopList:_shopsList[indexPath.row] indexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        [self zoomMap];
        return;
    }
    
    UITableViewCell *tableCell=[tableView cellForRowAtIndexPath:indexPath];
    if(_isZoomedMap)
    {
        if([tableCell isKindOfClass:[ShopListPlaceCell class]] ||
           [tableCell isKindOfClass:[ShopListCell class]])
            [self endZoomMap];
    }
    else
    {
        if([tableCell isKindOfClass:[ShopListMapCell class]])
        {
            [self zoomMap];
        }
        else if([tableCell isKindOfClass:[ShopListCell class]])
        {
            ShopListCell *cell=(ShopListCell*) tableCell;
            [SGData shareInstance].fScreen=[ShopListViewController screenCode];
            
            if(txt.text.length>0)
                [[SGData shareInstance].fData setObject:txt.text forKey:@"keywords"];
            if(_idShops.length>0)
                [[SGData shareInstance].fData setObject:_idShops forKey:@"idShops"];
            
            [[GUIManager shareInstance].rootViewController presentShopUserWithShop:cell.shopList.shop];
        }
    }
}

+(NSString *)screenCode
{
    return SCREEN_CODE_SHOP_LIST;
}

-(void)shopPinTouched:(ShopPinView *)pin
{
    [[GUIManager shareInstance].rootViewController presentShopUserWithShop:pin.shop.shop];
}

-(void)shopListCellTouched:(ShopListCell *)cell shop:(ShopList *)shop
{
    if(_isZoomedMap)
    {
        [self endZoomMap];
        return;
    }
    
    [cell closeLove];
    [[GUIManager shareInstance].rootViewController presentShopUserWithShop:shop.shop];
}

-(void)shopListCellTouchedAdd:(ShopListCell *)cell shop:(ShopList *)shop
{
    [cell closeLove];
    PlacelistViewController *vc=[[PlacelistViewController alloc] initWithShopList:shop];
    vc.delegate=self;
    
    [self.sgNavigationController pushViewController:vc animated:true];
}

-(void)shopListCellTouchedRemove:(ShopListCell *)cell shop:(ShopList *)shop
{
    [cell closeLove];
    
    [self showLoading];
    
    _indexPathWillRemove=cell.indexPath;
    
    _operationRemoveShopPlacelist=[[ASIOperationRemoveShopPlacelist alloc] initWithIDPlacelist:_placeList.idPlacelist.integerValue idShops:[NSString stringWithFormat:@"%i",shop.idShop.integerValue] userLat:userLat() userLng:userLng()];
    _operationRemoveShopPlacelist.delegate=self;
    
    [_operationRemoveShopPlacelist addToQueue];
}

-(void) storeRect
{
    _mapFrame=map.frame;
    _tableFrame=tableList.frame;
    _qrFrame=qrCodeView.frame;
    _buttonScanBigFrame=btnScanBig.frame;
    _buttonScanSmallFrame=btnScanSmall.frame;
    
    [self bigQRCode];
}

-(void)sortViewTouchedSort:(ShopListSortView *)_sortView
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Tìm kiếm theo" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:localizeSortList(SORT_LIST_DISTANCE), localizeSortList(SORT_LIST_VIEW), localizeSortList(SORT_LIST_LOVE),localizeSortList(SORT_LIST_DEFAULT), nil];;
    
    [self showActionSheet:sheet];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex)
        return;
    
    enum SORT_LIST sort;
    
    switch (buttonIndex) {
        case 0:
            sort=SORT_LIST_DISTANCE;
            break;
            
        case 1:
            sort=SORT_LIST_VIEW;
            break;
            
        case 2:
            sort=SORT_LIST_LOVE;
            break;
            
        case 3:
            sort=SORT_LIST_DEFAULT;
            break;
            
        default:
            sort=SORT_LIST_DISTANCE;
            break;
    }
    
    if(_sort==sort)
        return;
    
    switch (_viewMode) {
            
        case SHOP_LIST_VIEW_SHOP_LIST:
        case SHOP_LIST_VIEW_BRANCH:
            [self changeSortShopList:sort];
            break;
            
        case SHOP_LIST_VIEW_LIST:
            [self changeSort:sort];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
            [self changeSortPlace:sort];
            break;
    }
    
}

-(void) setCityName:(NSString*) cityName
{
    NSMutableParagraphStyle *paraStyle=[NSMutableParagraphStyle new];
    paraStyle.alignment=NSTextAlignmentCenter;
    
    NSAttributedString *attStr=APPLY_QUOTATION_MARK(cityName, @{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Roman" size:13],NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:paraStyle}, @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:paraStyle});
    
    [btnCity setAttributedTitle:attStr forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.qrCodeControllerHandle=self.searchController;
    
    if([CityManager shareInstance].idCitySearch)
        _idCity=[[CityManager shareInstance].idCitySearch integerValue];
    else
        _idCity=currentUser().idCity.integerValue;
    [self setCityName:CITY_NAME(_idCity)];
    
    _mapRowHeight=[self mapNormalHeight];
    
    _location.latitude=userLat();
    _location.longitude=userLng();
    
    tableList.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    self.view.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    
    [tableList registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];
    [tableList registerNib:[UINib nibWithNibName:[ShopListPlaceCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListPlaceCell reuseIdentifier]];
    [tableList registerLoadingMoreCell];
    [tableList registerNib:[UINib nibWithNibName:[ShopListMapCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListMapCell reuseIdentifier]];
    
    _shopsList=[NSMutableArray new];
    _page=-1;
    
    sortView.delegate=self;
    
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
            
            txt.text=_keyword;
            
            _sort=SORT_LIST_DEFAULT;
            [self requestShopSearch];
            [self showLoading];
            
            break;
            
        case SHOP_LIST_VIEW_SHOP_LIST:
        case SHOP_LIST_VIEW_BRANCH:
            
            _canLoadMore=false;
            _page=-1;
            _isLoadingMore=false;
            _sort=SORT_LIST_DEFAULT;
            
            
            [self requestShopList];
            [self showLoading];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
            
            txt.text=_placeList.title;
            
            _sort=SORT_LIST_DEFAULT;
            
            tableList.dataSource=self;
            tableList.delegate=self;
            
            [self reloadTable];
            
            [self showLoading];
            
            [self requestPlacelistDetail];
            
            break;
            
        case SHOP_LIST_VIEW_IDPLACE:
            
            _sort=SORT_LIST_DEFAULT;
            
            tableList.dataSource=self;
            tableList.delegate=self;
            
            [self reloadTable];
            
            [self showLoading];
            
            [self requestPlacelistGetDetail];
            
            break;
    }
 
    txt.rightViewType=TEXTFIELD_RIGHTVIEW_LOCATION;
    txt.leftViewType=TEXTFIELD_LEFTVIEW_SEARCH;
    txt.placeholder=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_USER_CITY_CHANGED,NOTIFICATION_USER_CHANGED_CITY_SEARCH];
}

-(void)textFieldTouchedRightView:(TextField *)textField
{
    [self showCityController];
}

-(void) requestPlacelistGetDetail
{
    if(_operationPlacelistGetDetail)
    {
        [_operationPlacelistGetDetail clearDelegatesAndCancel];
        _operationPlacelistGetDetail=nil;
    }
    
    _operationPlacelistGetDetail=[[ASIOperationPlacelistGetDetail alloc] initWithIDPlacelist:_idPlacelist userLat:userLat() userLng:userLng() sort:_sort];
    _operationPlacelistGetDetail.delegate=self;
    
    [_operationPlacelistGetDetail addToQueue];
}

-(void) requestPlacelistDetail
{
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail clearDelegatesAndCancel];
        _operationPlaceListDetail=nil;
    }
    
    _operationPlaceListDetail=[[ASIOperationPlacelistGet alloc] initWithIDPlacelist:_placeList.idPlacelist.integerValue userLat:_location.latitude userLng:_location.longitude sort:_sort page:_page+1];
    _operationPlaceListDetail.delegate=self;
    
    [_operationPlaceListDetail addToQueue];
}

-(void) requestShopList
{
    if(_operationShopList)
    {
        [_operationShopList clearDelegatesAndCancel];
        _operationShopList=nil;
    }
    
    _operationShopList=[[ASIOperationGetShopList alloc] initWithIDShops:_idShops userLat:userLat() userLng:userLng() page:_page+1 sort:_sort idBranch:_idBranch];
    _operationShopList.delegate=self;
    
    [_operationShopList addToQueue];
}

-(void) requestShopSearch
{
    if(_operationShopSearch)
    {
        [_operationShopSearch clearDelegatesAndCancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:_sort idCity:_idCity];
    _operationShopSearch.delegate=self;
    
    [_operationShopSearch addToQueue];
}

-(void) changeLocation:(CLLocationCoordinate2D) coordinate
{
    [self showLoading];
    
    [tableList setContentOffset:CGPointZero animated:true];
    
    _shopsList=[NSMutableArray new];
    _page=-1;
    _location=coordinate;
    _viewMode=SHOP_LIST_VIEW_LIST;
    _sort=SORT_LIST_DISTANCE;
    _placeList=nil;
    _keyword=@"";
    _idBranch=0;
    _idShops=@"";
    _isZoomedRegionMap=false;
    txt.placeholder=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    txt.text=@"";
    
    [self makeSortLayout];
    
    [self clearMap];
    
    if(_operationShopSearch)
    {
        [_operationShopSearch clearDelegatesAndCancel];
        _operationShopSearch=nil;
    }
    
    if(_keyword.length==0)
        _keyword=@"";
    
    [SGData shareInstance].fScreen=[ShopListViewController screenCode];
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:_sort idCity:_idCity];
    
    _operationShopSearch.delegate=self;
    [_operationShopSearch addToQueue];
}

-(void) changeSortShopList:(enum SORT_LIST) sort
{
    [self showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    tableList.dataSource=nil;
    _shopsList=[NSMutableArray new];
    _page=-1;
    _sort=sort;
    
    [self makeSortLayout];
    
    [self clearMap];
    
    if(_operationShopList)
    {
        [_operationShopList clearDelegatesAndCancel];
        _operationShopList=nil;
    }
    
    [SGData shareInstance].fScreen=[ShopListViewController screenCode];
    [self requestShopList];
    
    _isNeedAnimationChangeTable=true;
}

-(void) makeSortLayout
{
    UIImage *sortImage=nil;
    UIImage *sortScrollerImage=nil;
    
    switch (_sort) {
        case SORT_LIST_DEFAULT:
            sortImage=[UIImage imageNamed:@"icon_bestmatch.png"];
            sortScrollerImage=[UIImage imageNamed:@"icon_bestmatchscroll.png"];
            break;
            
        case SORT_LIST_DISTANCE:
            sortImage=[UIImage imageNamed:@"icon_distance.png"];
            sortScrollerImage=[UIImage imageNamed:@"icon_distancescroll.png"];
            break;
            
        case SORT_LIST_LOVE:
            sortImage=[UIImage imageNamed:@"icon_lovelist.png"];
            sortScrollerImage=[UIImage imageNamed:@"icon_heartscroll.png"];
            break;
            
        case SORT_LIST_VIEW:
            sortImage=[UIImage imageNamed:@"icon_viewlist.png"];
            sortScrollerImage=[UIImage imageNamed:@"icon_viewlistscroll.png"];
            break;
    }
    
    [sortView setIcon:sortImage text:localizeSortList(_sort)];
    [scrollerView setIcon:sortScrollerImage];
}

-(void) changeSort:(enum SORT_LIST) sort
{
    [self showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    tableList.dataSource=nil;
    _shopsList=[NSMutableArray new];
    _page=-1;
    _sort=sort;
    
    [self makeSortLayout];
    
    [self clearMap];
    
    if(_operationShopSearch)
    {
        [_operationShopSearch clearDelegatesAndCancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:sort idCity:_idCity];
    
    _operationShopSearch.delegate=self;
    [_operationShopSearch addToQueue];
    
    _isNeedAnimationChangeTable=true;
}

-(void) changeSortPlace:(enum SORT_LIST) sort
{
    [self showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    tableList.dataSource=nil;
    _shopsList=[NSMutableArray new];
    _page=-1;
    _sort=sort;
    
    [self makeSortLayout];
    
    [self clearMap];
    
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail clearDelegatesAndCancel];
        _operationPlaceListDetail=nil;
    }
    
    int idPlacelist=0;
    
    switch (_viewMode) {
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
            idPlacelist=_placeList.idPlacelist.integerValue;
            
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
        case SHOP_LIST_VIEW_BRANCH:
            break;
    }
    
    _operationPlaceListDetail=[[ASIOperationPlacelistGet alloc] initWithIDPlacelist:idPlacelist userLat:_location.latitude userLng:_location.longitude sort:_sort page:_page+1];
    
    _operationPlaceListDetail.delegate=self;
    [_operationPlaceListDetail addToQueue];
    
    _isNeedAnimationChangeTable=true;
}

-(void) clearMap
{
    for(id<MKAnnotation> ann in map.annotations)
    {
        MKAnnotationView *pin=[map viewForAnnotation:ann];
        
        if([pin isKindOfClass:[ShopPinView class]])
        {
            [((ShopPinView*)pin) hideInfo];
        }
    }
    
    [map removeAnnotations:map.annotations];
    [map removeOverlays:map.overlays];
    
    map.showsUserLocation=true;
    map.showsUserLocation=false;
    map.showsUserLocation=true;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self removeLoading];
        
        ASIOperationShopSearch *ope=(ASIOperationShopSearch*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopsList];
        
        _page++;
        _canLoadMore=ope.shopsList.count>=10;
        _isLoadingMore=false;
        
        [self animationTableReload];
        
        if(_isZoomedRegionMap)
            [map addMoreShopLists:ope.shopsList];
        else
            [map addShopLists:ope.shopsList];
        
        _isZoomedRegionMap=true;
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistGetDetail class]])
    {
        [self removeLoading];
        
        ASIOperationPlacelistGetDetail *ope=(ASIOperationPlacelistGetDetail*) operation;
        
        _placeList=ope.place;
        
        [_shopsList addObjectsFromArray:ope.shops];
        
        _page++;
        _canLoadMore=ope.shops.count>=10;
        _isLoadingMore=false;
        
        [self animationTableReload];
        
        if(_isZoomedRegionMap)
            [map addMoreShopLists:ope.shops];
        else
            [map addShopLists:ope.shops];
        
        _isZoomedRegionMap=true;
        
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistGet class]])
    {
        [self removeLoading];
        
        ASIOperationPlacelistGet *ope=(ASIOperationPlacelistGet*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopsList];
        
        _page++;
        _canLoadMore=ope.shopsList.count>=10;
        _isLoadingMore=false;
        
        [self animationTableReload];
        
        if(_isZoomedRegionMap)
            [map addMoreShopLists:ope.shopsList];
        else
            [map addShopLists:ope.shopsList];
        
        _isZoomedRegionMap=true;
        
        _operationPlacelistGetDetail=nil;
    }
    else if([operation isKindOfClass:[ASIOperationGetShopList class]])
    {
        [self removeLoading];
        
        ASIOperationGetShopList *ope=(ASIOperationGetShopList*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopLists];
        _canLoadMore=ope.shopLists.count>=10;
        _isLoadingMore=false;
        _page++;
        
        [self animationTableReload];
        
        if(_isZoomedRegionMap)
            [map addMoreShopLists:ope.shopLists];
        else
            [map addShopLists:ope.shopLists];
        
        _isZoomedRegionMap=true;
        
        _operationShopList=nil;
    }
    else if([operation isKindOfClass:[ASIOperationRemoveShopPlacelist class]])
    {
        [self removeLoading];
        
        ASIOperationRemoveShopPlacelist *ope=(ASIOperationRemoveShopPlacelist*) operation;
        NSString *message=ope.message;
        int status=ope.status;
        
        if(message.length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:message onOK:^{
                
                if(status==1)
                {
                    ShopList *shop=[((ShopListCell*)[tableList cellForRowAtIndexPath:_indexPathWillRemove]) shopList];
                    
                    [_shopsList removeObject:shop];
                    
                    [tableList beginUpdates];
                    
                    if(_shopsList.count==0)
                        [tableList deleteSections:[NSIndexSet indexSetWithIndex:_indexPathWillRemove.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                    else
                        [tableList deleteRowsAtIndexPaths:@[_indexPathWillRemove] withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                    [tableList endUpdates];
                    [self reloadTable];
                    
                    _indexPathWillRemove=nil;
                }
                else
                    _indexPathWillRemove=nil;
            }];
        }
        else
        {
            if(status==1)
            {
                
                [tableList beginUpdates];
                
                ShopList *shop=[((ShopListCell*)[tableList cellForRowAtIndexPath:_indexPathWillRemove]) shopList];
                
                [_shopsList removeObject:shop];
                
                if(_shopsList.count==0)
                    [tableList deleteSections:[NSIndexSet indexSetWithIndex:_indexPathWillRemove.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                else
                    [tableList deleteRowsAtIndexPaths:@[_indexPathWillRemove] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [tableList endUpdates];
                [self reloadTable];
                
                _indexPathWillRemove=nil;
            }
            else
                _indexPathWillRemove=nil;
        }
        
        _operationRemoveShopPlacelist=nil;
    }
    
    if(!_placeList && _shopsList.count==0)
    {
        //        [tableList showEmptyDataWithText:@"Không tìm thấy dữ liệu" align:EMPTY_DATA_ALIGN_TEXT_TOP];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self removeLoading];
        
        [self reloadTable];
        
        _operationShopSearch=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistGet class]])
    {
        [self removeLoading];
        
        _operationPlaceListDetail=nil;
    }
    else if ([operation isKindOfClass:[ASIOperationRemoveShopPlacelist class]])
    {
        [self removeLoading];
        
        _operationRemoveShopPlacelist=nil;
    }
}

-(void) showLoading
{
    [loadingView showLoading];
    loadingView.userInteractionEnabled=true;
}

-(void) removeLoading
{
    [loadingView removeLoading];
    loadingView.userInteractionEnabled=false;
}

-(void)viewWillAppearOnce
{
    [super viewWillAppearOnce];
    
    [self makeSortLayout];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(_isDidUpdateLocation)
        return;
    
    _isDidUpdateLocation=true;
    
    [map setRegion:MKCoordinateRegionMakeWithDistance(mapView.userLocation.location.coordinate, MAP_SPAN, MAP_SPAN) animated:false];
}

-(float) heightForZoom
{
    float height=visibleTableView.l_v_h;
    height-=115;
    height+=QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
    if(_placeList)
    {
        float cellHeight=[tableList rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].size.height;
        height-=cellHeight;
        height+=cellHeight-[ShopListPlaceCell titleHeight];
    }
    else if(_shopsList.count>0)
    {
        float cellHeight=[tableList rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].size.height;
        height-=cellHeight;
        height+=cellHeight-[ShopListCell addressHeight];
    }
    else
        height-=40;
    
    return height;
}

-(float) mapNormalHeight
{
    return 115+150;
}

-(void) zoomMap
{
    if(_isAnimatingZoom)
        return;
    
    _isAnimatingZoom=true;
    _isZoomedMap=true;
    
    [scrollerView removeFromSuperview];
    
    [tableList killScroll];
    
    _mapRowHeight=[self heightForZoom]+[self mapNormalHeight];
    
    [tableList reloadRowsAtIndexPaths:@[makeIndexPath(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
    
    [tableList l_co_setY:0 animate:true];
    self.view.userInteractionEnabled=false;
    
    [tableList removeEmptyDataView];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        
        [tableList l_v_setH:_tableFrame.size.height+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
        
        [mapCell l_v_setH:_mapRowHeight];
        [btnSearchLocation l_v_setY:75];
        
        [self smallQRCode];
    } completion:^(BOOL finished) {
        [mapCell enableMap];
        
        [tableList l_cs_setH:tableList.l_v_h];
        self.view.userInteractionEnabled=true;
        _isAnimatingZoom=false;
        
        [self showEmptyDataView];
    }];
}

-(void) smallQRCode
{
    [qrCodeView l_v_setY:_qrFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
    
    btnScanSmall.alpha=1;
    btnScanSmall.frame=_buttonScanBigFrame;
    
    btnScanBig.alpha=0;
    btnScanBig.frame=_buttonScanSmallFrame;
}

-(void) bigQRCode
{
    [qrCodeView l_v_setY:_qrFrame.origin.y];
    
    btnScanSmall.alpha=0;
    btnScanSmall.frame=_buttonScanSmallFrame;
    
    btnScanBig.alpha=1;
    btnScanBig.frame=_buttonScanBigFrame;
}

-(void) endZoomMap
{
    if(_isAnimatingZoom)
        return;
    
    _isAnimatingZoom=true;
    _isZoomedMap=false;
    [tableList killScroll];
    
    _mapRowHeight=[self mapNormalHeight];
    
    [tableList reloadRowsAtIndexPaths:@[makeIndexPath(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
    
    btnScanBig.alpha=0;
    btnScanBig.hidden=false;
    
    self.view.userInteractionEnabled=false;
    [tableList l_co_setY:0 animate:true];
    
    [tableList removeEmptyDataView];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [mapCell l_v_setH:_mapRowHeight];
        
        [self bigQRCode];
    } completion:^(BOOL finished) {
        [mapCell disabelMap];
        [self reloadTable];
        self.view.userInteractionEnabled=true;
        _isAnimatingZoom=false;

        [self showEmptyDataView];
    }];
}

- (IBAction)btnMapTouchUpInside:(id)sender {
    if(_isZoomedMap)
        [self endZoomMap];
    else
    {
        [self zoomMap];
    }
}

- (void)dealloc
{
    map.delegate=nil;
    map=nil;
    
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail clearDelegatesAndCancel];
        _operationPlaceListDetail=nil;
    }
    
    if(_operationShopSearch)
    {
        [_operationShopSearch clearDelegatesAndCancel];
        _operationShopSearch=nil;
    }
    
    if(_operationShopList)
    {
        [_operationShopList clearDelegatesAndCancel];
        _operationShopList=nil;
    }
    
    if(_operationPlacelistGetDetail)
    {
        [_operationPlacelistGetDetail clearDelegatesAndCancel];
        _operationPlacelistGetDetail=nil;
    }
    
    if(_operationRemoveShopPlacelist)
    {
        [_operationRemoveShopPlacelist clearDelegatesAndCancel];
        _operationRemoveShopPlacelist=nil;
    }
    
    tableList.delegate=nil;
}

-(void) animationTableReload
{
    if(_isNeedAnimationChangeTable)
    {
        self.view.userInteractionEnabled=false;
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            tableList.alpha=0.5f;
        } completion:^(BOOL finished) {
            tableList.dataSource=self;
            [self reloadTable];
            
            [self showEmptyDataView];
            
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                tableList.alpha=1;
            } completion:^(BOOL finished) {
                self.view.userInteractionEnabled=true;
            }];
        }];
        
        _isNeedAnimationChangeTable=false;
    }
    else
    {
        tableList.dataSource=self;
        [self reloadTable];
        
        [self showEmptyDataView];
    }
}

-(void) showEmptyDataView
{
    [tableList removeEmptyDataView];
    
    if(_shopsList.count>0)
        return;
    
    if(_placeList)
    {
        [tableList showEmptyDataViewWithText:@"Không có dữ liệu" textColor:[UIColor grayColor]];
        
        CGRect rect=[tableList rectForSection:1];
        
        [tableList.emptyDataView l_v_setY:rect.origin.y+rect.size.height+15];
    }
    else
    {
        [tableList showEmptyDataViewWithText:@"Không có dữ liệu" textColor:[UIColor grayColor]];
        int count=[tableList numberOfSections];
        
        if(count==1)
        {
            CGRect rect=[tableList rectForSection:0];
            
            if(_isZoomedMap)
            {
                [tableList.emptyDataView l_v_setY:rect.size.height+5];
            }
            else
            {
                [tableList.emptyDataView l_v_setY:rect.size.height+30];
            }
        }
        else
        {
            CGRect rect=[tableList rectForSection:1];
            [tableList.emptyDataView l_v_setY:rect.origin.y];
        }
    }
}

-(bool)isZoomedMap
{
    return _isZoomedMap;
}

-(void)showQRView
{
    
}

-(void)hideQRView
{
    
}

-(void)shopListMapTouchedLocation:(ShopListMapCell *)mapCell
{
    [self changeLocation:map.centerCoordinate];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ShopList class]])
    {
        ShopList *shop=(ShopList*)annotation;
        UIImage *iconPin=[shop iconPin];
        ShopPinView *ann = (ShopPinView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapPin"];
        if(!ann)
        {
            ann=[[ShopPinView alloc] initWithAnnotation:shop reuseIdentifier:@"mapPin"];
            ann.canShowCallout=false;
            ann.animatesDrop=false;
            ann.enabled=true;
        }
        
        ann.delegate=self;
        ann.image=iconPin;
        
        return ann;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if([view isKindOfClass:[ShopPinView class]])
    {
        for(id<MKAnnotation> ann in mapView.annotations)
        {
            MKAnnotationView *pin=[mapView viewForAnnotation:ann];
            
            if([pin isKindOfClass:[ShopPinView class]])
            {
                [((ShopPinView*)pin) hideInfo];
            }
        }
        
        ShopPinView *pin=(ShopPinView*)view;
        
        if(pin.selected)
            [pin showInfoWithShop:pin.annotation];
        else
            [pin hideInfo];
    }
    
    [map zoomShopList:view.annotation];
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    if(_operationShopSearch)
    {
        [_operationShopSearch clearDelegatesAndCancel];
        _operationShopSearch=nil;
    }
    
    [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
    [self.delegate shopListControllerTouchedBack:self];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_LIST;
    [self.delegate shopListControllerTouchedTextField:self];
    
    return false;
}

-(NSString *)keyword
{
    return _keyword;
}

-(Placelist *)placelist
{
    return _placeList;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    map.mapType=MKMapTypeHybrid;
    map.mapType=MKMapTypeStandard;
}

-(void)placelistControllerTouchedTextField:(PlacelistViewController *)controller
{
    [self.sgNavigationController popSGViewControllerWithTransition:transitionPushFromRight()];
}

- (IBAction)btnScanBigTouchUpInside:(id)sender {
    [self showQRCodeWithController:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP screenCode:[ShopListViewController screenCode]];
}

- (IBAction)btnScanSmallTouchUpInside:(id)sender {
    [self showQRCodeWithController:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[ShopListViewController screenCode]];
}

-(void)shopPinDealloc:(ShopPinView *)pin
{
}

-(void) closeLove
{
    for(ShopListCell *cell in tableList.visibleCells)
    {
        if([cell isKindOfClass:[ShopListCell class]])
        {
            [cell closeLove];
        }
    }
}

-(void) showScroller
{
    if(!scrollerView)
        return;
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        scrollerView.alpha=1;
    } completion:nil];
}

-(void) hideScrollerWithDelay:(float) delay
{
    if(!scrollerView)
        return;
    
    [UIView animateWithDuration:0.3f delay:delay options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        scrollerView.alpha=0;
    } completion:nil];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollerView)
    {
        [self showScroller];
        return;
    }
    
    if(_isZoomedMap)
        return;
    
    if(!([tableList numberOfSections]>1 && [tableList numberOfRowsInSection:1]>0))
        return;
    
    ScrollerShopList *sv=[[ScrollerShopList alloc] initWithTable:tableList];
    [sv l_v_setY:[tableList rectForRowAtIndexPath:makeIndexPath(0, 1)].origin.y];
    [sv l_v_setH:29];
    sv.userInteractionEnabled=false;
    
    [tableList addSubview:sv];
    
    scrollerView=sv;
    _scrollerViewFrame=scrollerView.frame;
    
    [self makeScrollerTitle];
    [self makeSortLayout];
    
    [self showScroller];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self makeHideScroller];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
        [self makeHideScroller];
}


-(void) makeHideScroller
{
    [self hideScrollerWithDelay:0];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[ShopListCell class]])
    {
        ShopListCell *lCell=(ShopListCell*)cell;
        
        [lCell addObserver];
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[ShopListCell class]])
    {
        ShopListCell *lCell=(ShopListCell*)cell;
        
        [lCell removeObserver];
    }
}

- (IBAction)btnCityTouchUpInside:(id)sender {
    [self showCityController];
}

-(void) showCityController
{
    CityViewController *vc=[[CityViewController alloc] initWithSelectedIDCity:_idCity];
    vc.delegate=self;
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)cityControllerDidTouchedCity:(CityViewController *)controller idCity:(int)idCity name:(NSString *)name
{
    [[CityManager shareInstance] setIdCitySearch:@(idCity)];
    if(_idCity==idCity)
        return;
    
    _idCity=idCity;
    [self setCityName:name];
    
    [self changeCity];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_USER_CITY_CHANGED])
    {
        if(_idCity==currentUser().idCity.integerValue)
            return;
        
        _idCity=currentUser().idCity.integerValue;
        [self setCityName:CITY_NAME(_idCity)];
        
        [self changeCity];
    }
    else if([notification.name isEqualToString:NOTIFICATION_USER_CHANGED_CITY_SEARCH])
    {
        if(_idCity==[CityManager shareInstance].idCitySearch.integerValue)
            return;
        
        _idCity=[[CityManager shareInstance].idCitySearch integerValue];
        [self setCityName:CITY_NAME(_idCity)];
        
        [self changeCity];
    }
}

-(void) changeCity
{
    [self changeLocation:map.centerCoordinate];
}

@end

@implementation TableShopList

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(contentOffset.y<-150)
        contentOffset.y=-150;
    
    _offsetY=contentOffset.y-self.contentOffset.y;
    
    [super setContentOffset:contentOffset];
}

-(float)offsetY
{
    return _offsetY;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.panGestureRecognizer.delegate=self;
    
    [self.panGestureRecognizer addTarget:self action:@selector(pan:)];
}

-(void) pan:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            [self.controller closeLove];
            
            CGPoint velocity=[pan velocityInView:pan.view];
            
            if(!self.controller.isZoomedMap)
            {
                if(self.l_co_y<0)
                {
                    if(velocity.y>VELOCITY_SLIDE)
                        [self.controller zoomMap];
                    else
                    {
                        if(self.l_co_y<-100)
                        {
                            [self.controller zoomMap];
                        }
                    }
                }
            }
            else
            {
                if(self.l_co_y>0)
                {
                    if(velocity.y<-VELOCITY_SLIDE)
                    {
                        [self.controller endZoomMap];
                    }
                    else
                    {
                        if([self numberOfSections]>1 && [self numberOfRowsInSection:1]>0)
                        {
                            id cell=[self cellForRowAtIndexPath:makeIndexPath(0, 1)];
                            CGRect rect=[self rectForRowAtIndexPath:makeIndexPath(0, 1)];
                            float height=0;
                            
                            if([cell isKindOfClass:[ShopListCell class]])
                            {
                                height=[ShopListCell addressHeight];
                            }
                            else if([cell isKindOfClass:[ShopListPlaceCell class]])
                            {
                                height=[ShopListPlaceCell titleHeight];
                            }
                            
                            rect.size.height-=height;
                            rect.size.height-=5;
                            
                            if(self.l_co_y>rect.size.height)
                                [self.controller endZoomMap];
                        }
                        else if(self.l_co_y>50)
                            [self.controller endZoomMap];
                    }
                }
            }
        }
            break;
            
        default:
            break;
    }
}

@end

@implementation ShopListScrollerBG

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    
    return self;
}

-(id)init
{
    self=[super init];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bgslide_head.png"] drawAtPoint:CGPointZero];
    [[UIImage imageNamed:@"bgslide_mid.png"] drawAsPatternInRect:CGRectMake(30, 0, rect.size.width-30, 29)];
    
    if(self.icon)
    {
        [self.icon drawAtPoint:CGPointMake(4, 3)];
    }
}

@end

@implementation ScrollerShopList

-(ScrollerShopList *)initWithTable:(UITableView *)table
{
    self=[super initWithFrame:CGRectMake(0, 0, table.l_v_w, 29)];
    
    ShopListScrollerBG *bgView=[[ShopListScrollerBG alloc] initWithFrame:CGRectMake(0, 0, 0, 29)];
    [self addSubview:bgView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 29)];
    label.font=[UIFont fontWithName:@"Avenir-Roman" size:12];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    [self addSubview:label];
    
    lbl=label;
    bg=bgView;
    
    bg.icon=[UIImage imageNamed:@"icon_distancescroll.png"];
    
    lbl.text=@"";
    [lbl sizeToFit];
    [lbl l_v_setH:self.l_v_h];
    [lbl l_v_setX:self.l_v_w-lbl.l_v_w];
    
    [bg l_v_setX:lbl.l_v_x-30];
    [bg l_v_setW:MAX(30,self.l_v_w-bg.l_v_x)];
    
    bg.alpha=0;
    lbl.alpha=0;
    
    return self;
}

-(void)setTitle:(NSString *)title
{
    lbl.text=title;
    [lbl sizeToFit];
    [lbl l_v_setH:self.l_v_h];
    
    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        lbl.alpha=1;
        bg.alpha=1;
        
        [lbl l_v_setX:self.l_v_w-lbl.l_v_w];
        
        [bg l_v_setX:lbl.l_v_x-30];
        [bg l_v_setW:MAX(30,self.l_v_w-bg.l_v_x)];
    } completion:nil];
}

-(void)setIcon:(UIImage *)icon
{
    bg.icon=icon;
}

@end