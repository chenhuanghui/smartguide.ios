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
#import "SGRootViewController.h"
#import "EmptyDataView.h"
#import "LoadingMoreCell.h"
#import "ShopPinInfoView.h"
#import "ShopPinView.h"
#import "ShopListCell.h"

#define SHOP_LIST_SCROLL_SPEED 3.f

@interface ShopListViewController ()<ShopPinDelegate,ShopListMapDelegate,ShopListCellDelegate>

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

-(void) reloadTable
{
    [tableList reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            return (_shopsList.count==0?0:1)+1;
            
        case SHOP_LIST_VIEW_PLACE:
            return 1+1;
            
        case SHOP_LIST_VIEW_IDPLACE:
            if(_placeList)
                return 1+1;
            else
                return 0+1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 1;
    
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            return _shopsList.count+(_canLoadMore?1:0);
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
            return _shopsList.count+1+(_canLoadMore?1:0);
    }
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
            [self requestShopList];
            break;
    }
}

-(ShopListCell*) cellWithShopList:(ShopList*) shop indexPath:(NSIndexPath*) indexPath
{
    ShopListCell *cell=[tableList dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
    cell.delegate=self;
    
    [cell loadWithShopList:shop];
    [cell setButtonTypeIsTypeAdded:true];
    cell.table=tableList;
    cell.indexPath=indexPath;
    cell.controller=self;
    
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
    
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
        {
            if(_canLoadMore && indexPath.row==_shopsList.count)
            {
                if(!_isLoadingMore)
                {
                    [self loadMore];
                    _isLoadingMore=true;
                }
                
                return [tableList loadingMoreCell];
            }
            
            return [self cellWithShopList:_shopsList[indexPath.row] indexPath:indexPath];
        }
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
            
            switch (indexPath.row) {
                case 0:
                {
                    ShopListPlaceCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListPlaceCell reuseIdentifier]];
                    
                    [cell loadWithPlace:_placeList];
                    
                    return cell;
                }
                    
                default:
                {
                    if(_canLoadMore && indexPath.row==_shopsList.count)
                    {
                        if(!_isLoadingMore)
                        {
                            [self loadMore];
                            _isLoadingMore=true;
                        }
                        
                        return [tableList loadingMoreCell];
                    }
                    
                    return [self cellWithShopList:_shopsList[indexPath.row-1] indexPath:indexPath];
                }
            }
            
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return _mapRowHeight;;
    }
    
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            
            if(_canLoadMore && indexPath.row==_shopsList.count)
                return 88;
            
            return [ShopListCell heightWithShopList:_shopsList[indexPath.row]];
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
        {
            switch (indexPath.row) {
                case 0:
                    return [ShopListPlaceCell heightWithContent:_placeList.desc];
                    
                default:
                    
                    if(_canLoadMore && indexPath.row==_shopsList.count)
                        return 88;
                    
                    return [ShopListCell heightWithShopList:_shopsList[indexPath.row-1]];
            }
        }
    }
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
            
            [[GUIManager shareInstance] presentShopUserWithShopList:cell.shopList];
        }
    }
}

+(NSString *)screenCode
{
    return SCREEN_CODE_SHOP_LIST;
}

-(void)shopPinTouched:(ShopPinView *)pin
{
    [[GUIManager shareInstance] presentShopUserWithShopList:pin.shop];
}

-(void)shopListCellTouched:(ShopListCell *)cell shop:(ShopList *)shop
{
    if(_isZoomedMap)
    {
        [self endZoomMap];
        return;
    }
    
    [cell closeLove];
    [[GUIManager shareInstance] presentShopUserWithShopList:shop];
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
    PlacelistViewController *vc=[[PlacelistViewController alloc] initWithShopList:shop];
    vc.delegate=self;
    
    [self.sgNavigationController pushViewController:vc animated:true];
}

-(void) storeRect
{
    _mapFrame=map.frame;
    _tableFrame=tableList.frame;
    _qrFrame=qrCodeView.frame;
    _buttonScanBigFrame=btnScanBig.frame;
    _buttonScanSmallFrame=btnScanSmall.frame;
}

-(void)sortViewTouchedSort:(ShopSearchSortView *)_sortView
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Tìm kiếm theo" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:localizeSortList(SORT_LIST_DISTANCE), localizeSortList(SORT_LIST_VIEW), localizeSortList(SORT_LIST_LOVE),localizeSortList(SORT_LIST_DEFAULT), nil];;
    
    [sheet showInView:self.view];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
            
            _sort=SORT_LIST_DISTANCE;
            [self requestShopSearch];
            [self showLoading];
            
            break;
            
        case SHOP_LIST_VIEW_SHOP_LIST:
            
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
            
            [tableList reloadData];
            
            [self showLoading];
            
            [self requestPlacelistDetail];
            
            break;
            
        case SHOP_LIST_VIEW_IDPLACE:
            
            _sort=SORT_LIST_DEFAULT;
            
            tableList.dataSource=self;
            tableList.delegate=self;
            
            [tableList reloadData];
            
            [self showLoading];
            
            [self requestPlacelistGetDetail];
            
            break;
    }
    
    if(txt.text.length==0)
    {
        txt.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
        txt.placeholder=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    }
}

-(void) requestPlacelistGetDetail
{
    if(_operationPlacelistGetDetail)
    {
        [_operationPlacelistGetDetail clearDelegatesAndCancel];
        _operationPlacelistGetDetail=nil;
    }
    
    _operationPlacelistGetDetail=[[ASIOperationPlacelistGetDetail alloc] initWithIDPlacelist:_idPlacelist userLat:userLat() userLng:userLng() sort:_sort];
    _operationPlacelistGetDetail.delegatePost=self;
    
    [_operationPlacelistGetDetail startAsynchronous];
}

-(void) requestPlacelistDetail
{
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail clearDelegatesAndCancel];
        _operationPlaceListDetail=nil;
    }
    
    _operationPlaceListDetail=[[ASIOperationPlacelistGet alloc] initWithIDPlacelist:_placeList.idPlacelist.integerValue userLat:_location.latitude userLng:_location.longitude sort:_sort page:_page+1];
    _operationPlaceListDetail.delegatePost=self;
    
    [_operationPlaceListDetail startAsynchronous];
}

-(void) requestShopList
{
    if(_operationShopList)
    {
        [_operationShopList clearDelegatesAndCancel];
        _operationShopList=nil;
    }
    
    _operationShopList=[[ASIOperationGetShopList alloc] initWithIDShops:_idShops userLat:userLat() userLng:userLng() page:_page+1 sort:_sort];
    _operationShopList.delegatePost=self;
    
    [_operationShopList startAsynchronous];
}

-(void) requestShopSearch
{
    if(_operationShopSearch)
    {
        [_operationShopSearch clearDelegatesAndCancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:_sort];
    _operationShopSearch.delegatePost=self;
    
    [_operationShopSearch startAsynchronous];
}

-(void) changeLocation:(CLLocationCoordinate2D) coordinate
{
    [self showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    _shopsList=[NSMutableArray new];
    _page=-1;
    _location=coordinate;
    _viewMode=SHOP_LIST_VIEW_LIST;
    _sort=SORT_LIST_DISTANCE;
    _placeList=nil;
    _keyword=@"";
    txt.text=TEXTFIELD_SEARCH_PLACEHOLDER_TEXT;
    
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
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:_sort];
    
    _operationShopSearch.delegatePost=self;
    [_operationShopSearch startAsynchronous];
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
            sortScrollerImage=[UIImage imageNamed:@"icon_lovescroll.png"];
            break;
            
        case SORT_LIST_VIEW:
            sortImage=[UIImage imageNamed:@"icon_viewlist.png"];
            sortScrollerImage=[UIImage imageNamed:@"icon_viewlistscroll.png"];
            break;
    }
    
    [sortView setIcon:sortImage text:localizeSortList(_sort)];
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
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:sort];
    
    _operationShopSearch.delegatePost=self;
    [_operationShopSearch startAsynchronous];
    
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
            break;
    }
    
    _operationPlaceListDetail=[[ASIOperationPlacelistGet alloc] initWithIDPlacelist:idPlacelist userLat:_location.latitude userLng:_location.longitude sort:_sort page:_page+1];
    
    _operationPlaceListDetail.delegatePost=self;
    [_operationPlaceListDetail startAsynchronous];
    
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
        _canLoadMore=ope.shopsList.count==10;
        _isLoadingMore=false;
        
        [self animationTableReload];
        
        if(!_isZoomedRegionMap)
            [map addShopLists:ope.shopsList];
        else
            [map addMoreShopLists:ope.shopsList];
        
        _isZoomedRegionMap=true;
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistGetDetail class]])
    {
        [self removeLoading];
        
        ASIOperationPlacelistGetDetail *ope=(ASIOperationPlacelistGetDetail*) operation;
        
        _placeList=ope.place;
        
        [_shopsList addObjectsFromArray:ope.shops];
        
        _page++;
        _canLoadMore=ope.shops.count==10;
        _isLoadingMore=false;
        
        [self animationTableReload];
        
        if(!_isZoomedRegionMap)
            [map addShopLists:ope.shops];
        else
            [map addMoreShopLists:ope.shops];
        
        _isZoomedRegionMap=true;
        
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistGet class]])
    {
        [self removeLoading];
        
        ASIOperationPlacelistGet *ope=(ASIOperationPlacelistGet*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopsList];
        
        _page++;
        _canLoadMore=ope.shopsList.count==10;
        _isLoadingMore=false;
        
        [self animationTableReload];
        
        if(!_isZoomedRegionMap)
            [map addShopLists:ope.shopsList];
        else
            [map addMoreShopLists:ope.shopsList];
        
        _isZoomedRegionMap=true;
        
        _operationPlacelistGetDetail=nil;
    }
    else if([operation isKindOfClass:[ASIOperationGetShopList class]])
    {
        [self removeLoading];
        
        ASIOperationGetShopList *ope=(ASIOperationGetShopList*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopLists];
        _canLoadMore=ope.shopLists.count==10;
        _isLoadingMore=false;
        _page++;
        
        [self animationTableReload];
        
        if(!_isZoomedRegionMap)
            [map addShopLists:ope.shopLists];
        else
            [map addMoreShopLists:ope.shopLists];
        
        _isZoomedRegionMap=true;
        
        _operationShopList=nil;
    }
    
    if(!_placeList && _shopsList.count==0)
        [tableList showEmptyDataWithText:@"Không tìm thấy dữ liệu" align:EMPTY_DATA_ALIGN_TEXT_TOP];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self removeLoading];
        
        _operationShopSearch=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistGet class]])
    {
        [self removeLoading];
        
        _operationPlaceListDetail=nil;
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
    }
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

    [tableList killScroll];
    
    _mapRowHeight=[self heightForZoom]+[self mapNormalHeight];
    
    [tableList reloadRowsAtIndexPaths:@[indexPath(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
    
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [qrCodeView l_v_setY:_qrFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
        [tableList l_v_setH:_tableFrame.size.height+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
        [tableList l_co_setY:0];
        [mapCell l_v_setH:_mapRowHeight];
        [btnSearchLocation l_v_setY:75];
        btnScanSmall.alpha=0;
        btnScanSmall.hidden=false;
        btnScanSmall.alpha=1;
        btnScanBig.alpha=0;
        btnScanBig.frame=_buttonScanSmallFrame;
        btnScanSmall.frame=_buttonScanBigFrame;
    } completion:^(BOOL finished) {
        [mapCell enableMap];
        
        [tableList l_cs_setH:tableList.l_v_h];
        self.view.userInteractionEnabled=true;
        _isAnimatingZoom=false;
    }];
}

-(void) endZoomMap
{
    if(_isAnimatingZoom)
        return;
    
    _isAnimatingZoom=true;
    _isZoomedMap=false;
    [tableList killScroll];
    
    _mapRowHeight=[self mapNormalHeight];
    
    [tableList reloadRowsAtIndexPaths:@[indexPath(0, 0)] withRowAnimation:UITableViewRowAnimationNone];
    
    btnScanBig.alpha=0;
    btnScanBig.hidden=false;
    
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [qrCodeView l_v_setY:_qrFrame.origin.y];
        [mapCell l_v_setH:_mapRowHeight];
        [tableList l_co_setY:0];
        btnScanBig.alpha=1;
        btnScanSmall.alpha=0;
        btnScanBig.frame=_buttonScanBigFrame;
        btnScanSmall.frame=_buttonScanSmallFrame;
    } completion:^(BOOL finished) {
        [mapCell disabelMap];
        [tableList reloadData];
        self.view.userInteractionEnabled=true;
        _isAnimatingZoom=false;
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
            [tableList reloadData];
            
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
        [tableList reloadData];
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
    [self.sgNavigationController popViewControllerWithTransition:transitionPushFromRight()];
}

- (IBAction)btnScanBigTouchUpInside:(id)sender {
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP screenCode:[ShopListViewController screenCode]];
}

- (IBAction)btnScanSmallTouchUpInside:(id)sender {
    [self showQRCodeWithContorller:self inView:self.view withAnimationType:QRCODE_ANIMATION_TOP_BOT screenCode:[ShopListViewController screenCode]];
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
                }
            }
            NSLog(@"velocity %@ %f",NSStringFromCGPoint(velocity),self.l_co_y);
        }
            break;
            
        default:
            break;
    }
}

@end