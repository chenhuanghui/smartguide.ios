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

#define SHOP_LIST_SCROLL_SPEED 3.f

@interface ShopListViewController ()<ShopPinDelegate>

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

-(NSArray *)registerNotifications
{
    return @[UIApplicationDidBecomeActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            return _shopsList.count==0?0:1;
            
        case SHOP_LIST_VIEW_PLACE:
            return 1;
            
        case SHOP_LIST_VIEW_IDPLACE:
            if(_placeList)
                return 1;
            else
                return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            
            ShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
            cell.delegate=self;
            
            [cell loadWithShopList:_shopsList[indexPath.row]];
            [cell setButtonTypeIsTypeAdded:true];
            
            return cell;
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
                    
                    ShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
                    cell.delegate=self;
                    
                    [cell loadWithShopList:_shopsList[indexPath.row-1]];
                    [cell setButtonTypeIsTypeAdded:_placeList.idAuthor.integerValue!=currentUser().idUser.integerValue];
                    
                    return cell;
                }
            }
            
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            
            if(_canLoadMore && indexPath.row==_shopsList.count)
                return 88;
            
            return [ShopListCell heightWithContent:[_shopsList[indexPath.row] desc]];
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
        {
            switch (indexPath.row) {
                case 0:
                    return [ShopListPlaceCell heightWithContent:_placeList.desc];
                    
                default:
                    
                    if(_canLoadMore && indexPath.row==_shopsList.count)
                        return 88;
                    
                    return [ShopListCell heightWithContent:[_shopsList[indexPath.row-1] desc]];
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopList *shop=nil;
    switch (_viewMode) {
            
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            
            if(_canLoadMore && indexPath.row==_shopsList.count)
                return;
            
            shop=_shopsList[indexPath.row];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
        case SHOP_LIST_VIEW_IDPLACE:
        {
            switch (indexPath.row) {
                case 0:
                    
                    break;
                    
                default:
                    
                    if(_canLoadMore && indexPath.row==_shopsList.count)
                        return;
                    
                    shop=_shopsList[indexPath.row-1];
                    break;
            }
        }
            break;
    }
    
    if(shop)
    {
        [SGData shareInstance].fScreen=[ShopListViewController screenCode];
        
        if(txt.text.length>0)
            [[SGData shareInstance].fData setObject:txt.text forKey:@"keywords"];
        if(_idShops.length>0)
            [[SGData shareInstance].fData setObject:_idShops forKey:@"idShops"];
        
        [[GUIManager shareInstance] presentShopUserWithShopList:shop];
    }
}

+(NSString *)screenCode
{
    return SCREEN_CODE_SHOP_LIST;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    return;
    if(object==scrollBar)
    {
        
        float new=[change[NSKeyValueChangeNewKey] floatValue];
        
        [UIView animateWithDuration:0.1f animations:^{
            scrollerView.alpha=new;
        }];
    }
    else if([object isKindOfClass:[MKPinAnnotationView class]])
    {
    }
}

-(void)shopPinTouched:(ShopPinView *)pin
{
    [[GUIManager shareInstance] presentShopUserWithShopList:pin.shop];
}

-(void) loadScroller
{
    if(scrollerView)
        return;
    
    scrollBar=[scroll scrollBar];
    scrollBar.clipsToBounds=false;
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(-315, 0, 315, scrollBar.l_v_h)];
    v.layer.masksToBounds=true;
    v.backgroundColor=[UIColor clearColor];
    v.hidden=_isZoomedMap;
    v.autoresizingMask=UIViewAutoresizingAll();
    
    scrollerView=v;
    
    UIView *bg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, scrollBar.l_v_h)];
    bg.backgroundColor=[UIColor clearColor];
    bg.autoresizingMask=UIViewAutoresizingAll();
    
    scrollerBGView=bg;
    
    [v addSubview:bg];
    
    UIImageView *slide_head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgslide_head.png"]];
    slide_head.frame=CGRectMake(0, 0, 30, scrollerView.l_v_h);
    slide_head.contentMode=UIViewContentModeCenter;
    slide_head.autoresizingMask=UIViewAutoresizingAll();
    
    [bg addSubview:slide_head];
    
    UIView *slide_mid=[[UIView alloc] initWithFrame:CGRectMake(slide_head.l_v_w, 0, bg.l_v_w-slide_head.l_v_w, bg.l_v_h)];
    slide_mid.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgslide_mid.png"]];
    slide_head.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
    slide_head.contentMode=UIViewContentModeCenter;
    
    [bg addSubview:slide_mid];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(-3, 0, 315, 29)];
    label.textAlignment=NSTextAlignmentRight;
    label.backgroundColor=[UIColor clearColor];
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:12];
    label.autoresizingMask=UIViewAutoresizingNone;
    
    scrollerLabel=label;
    
    [v addSubview:label];
    
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_heartscroll.png"]];
    imageView.contentMode=UIViewContentModeLeft;
    imageView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    imageView.frame=bg.frame;
    [imageView l_v_addX:3];
    
    [bg addSubview:imageView];
    
    scrollerImageView=imageView;
    
    [scrollBar addSubview:scrollerView];
    //[scrollerContain addSubview:scrollerView];
    
    //[scrollerBGView l_v_setX:scrollerView.l_v_w];
    
    [self makeSortLayout];
    
    scrollerView.hidden=true;
}

-(void)shopListCellTouched:(ShopList *)shop
{
    if(_isZoomedMap)
    {
        [self endZoomMap];
        return;
    }
    
    [[GUIManager shareInstance] presentShopUserWithShopList:shop];
}

-(void)shopListCellTouchedAdd:(ShopList *)shop
{
    PlacelistViewController *vc=[[PlacelistViewController alloc] initWithShopList:shop];
    vc.delegate=self;
    
    [self.sgNavigationController pushViewController:vc animated:true];
}

-(void)shopListCellTouchedRemove:(ShopList *)shop
{
    PlacelistViewController *vc=[[PlacelistViewController alloc] initWithShopList:shop];
    vc.delegate=self;
    
    [self.sgNavigationController pushViewController:vc animated:true];
}

-(void) storeRect
{
    _tableFrame=tableList.frame;
    _qrFrame=qrCodeView.frame;
    _buttonMapFrame=btnMap.frame;
    _buttonSearchLocationFrame=btnSearchLocation.frame;
    _sortFrame=sortView.frame;
    _buttonScanBigFrame=btnScanBig.frame;
    _buttonScanSmallFrame=btnScanSmall.frame;
    _scrollFrame=scroll.frame;
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
    
    scroll.minimumOffsetY=-1;
    
    _isAllowDiffScrollMap=true;
    map.userInteractionEnabled=false;
    map.scrollEnabled=false;
    map.zoomEnabled=false;
    
    if([map respondsToSelector:@selector(setShowsBuildings:)])
        map.showsBuildings=false;
    
    if([map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        map.showsPointsOfInterest=false;
    
    CGRect rect=CGRectZero;
    rect.size.height=self.l_v_h-qrCodeView.l_v_h+QRCODE_RAY_HEIGHT;
    rect.size.width=self.l_v_w;
    rect.origin.y=-tableList.l_v_h/SHOP_LIST_SCROLL_SPEED;
    map.frame=rect;
    
    _mapFrame=rect;
    
    _location.latitude=userLat();
    _location.longitude=userLng();
    
    tableList.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    self.view.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    
    [tableList registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];
    [tableList registerNib:[UINib nibWithNibName:[ShopListPlaceCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListPlaceCell reuseIdentifier]];
    [tableList registerLoadingMoreCell];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTop:)];
    tap.delegate=self;
    _tapTop=tap;
    
    [self.view addGestureRecognizer:tap];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    [scroll.panGestureRecognizer addTarget:self action:@selector(scrollPanGes:)];
    
    _shopsList=[NSMutableArray new];
    _page=-1;
    
    sortView.delegate=self;
    btnSearchLocation.hidden=_viewMode==SHOP_LIST_VIEW_PLACE;
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(!_didMakeScrollSize)
    {
        _didMakeScrollSize=true;
        
        [self makeScrollSize];
        [self makeSortLayout];
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
    scrollerImageView.image=sortScrollerImage;
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
        
        [self makeScrollSize];
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
        
        [self makeScrollSize];
        
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
        
        [self makeScrollSize];
        
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
        
        [self makeScrollSize];
        
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

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==_tapTop)
    {
        if(_isZoomedMap)
        {
            CGPoint pnt=[gestureRecognizer locationInView:tableList];
            
            if(CGRectContainsPoint(CGRectMake(0, 0, tableList.l_v_w, tableList.l_v_h), pnt))
                return true;
            
            return false;
        }
        else
        {
            CGPoint pnt=[gestureRecognizer locationInView:self.view];
            CGRect rect=CGRectMake(0, 0, self.l_v_w, [scroll convertPoint:tableList.l_v_o toView:self.view].y-1);
            
            if(CGRectContainsPoint(rect, pnt))
            {
                if([sortView pointInside:[gestureRecognizer locationInView:sortView] withEvent:nil])
                    return false;
                
                return true;
            }
            
            return false;
        }
    }
    
    return true;
}

-(void) makeScrollSize
{
    if(self.isZoomedMap)
        return;
    
    float actuallyTableHeight=_scrollFrame.size.height-_tableFrame.origin.y-_qrFrame.size.height-QRCODE_RAY_HEIGHT;
    
    float height=_tableFrame.origin.y;
    
    if(tableList.l_cs_h>actuallyTableHeight)
    {
        height+=tableList.l_cs_h;
        scroll.contentSize=CGSizeMake(scroll.l_v_w, height);
        scroll.contentInset=UIEdgeInsetsMake(0, 0, QRCODE_BIG_HEIGHT-QRCODE_RAY_HEIGHT, 0);
        scroll.scrollIndicatorInsets=scroll.contentInset;
    }
    else
    {
        height=_scrollFrame.size.height+1;
        [scroll l_cs_setH:height];
        scroll.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
        scroll.scrollIndicatorInsets=scroll.contentInset;
    }
}

-(void) tapTop:(UITapGestureRecognizer*) ges
{
    if(_isZoomedMap)
        [self endZoomMap];
    else
        [self zoomMap];
}

-(UIScrollView *)scrollView
{
    return scroll;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==scroll)
    {
        [map l_v_setY:_mapFrame.origin.y+scroll.contentOffset.y-scroll.contentOffset.y/SHOP_LIST_SCROLL_SPEED];
        
        float y=tableList.l_v_y-scrollView.l_co_y;
        
        if(map.superview)
        {
            if(y<0)
                [map removeFromSuperview];
        }
        else
        {
            if(y>0)
                [scroll insertSubview:map belowSubview:tableList];
        }
        
        if(_tableFrame.origin.y-scrollView.l_co_y<=0)
        {
            [tableList l_v_setY:scrollView.l_co_y];
            [tableList l_co_setY:scrollView.l_co_y-_tableFrame.origin.y];
        }
        else
        {
            [tableList l_v_setY:_tableFrame.origin.y];
            [tableList l_co_setY:0];
        }
        
        return;
        //begin scroller
        
        if(_isZoomedMap)
            return;
        
        float height=(scroll.l_cs_h+scroll.contentInset.bottom-scroll.l_v_h);
        float percent=(scroll.l_co_y)/height;
        
        y=percent*(scrollerContain.l_v_h);
        
        y=MAX(36, y);
        y=MIN(scrollerContain.l_v_h-scrollerView.l_v_h-QRCODE_RAY_HEIGHT, y);
        
//        [UIView animateWithDuration:0.3f animations:^{
//            [scrollerView l_v_setY:y];
//        }];
        
        CGPoint pnt=scrollerView.l_v_o;
        pnt.x=0;
        pnt=[scrollerContain convertPoint:pnt toView:scroll];
        
        NSString *scrollerText=@"Bản đồ";
        
        if(pnt.y<_tableFrame.origin.y)
        {
            CGSize size=[scrollerText sizeWithFont:scrollerLabel.font];
            
            size.height=scrollerLabel.l_v_h;
            
            scrollerLabel.text=scrollerText;
            
            [UIView animateWithDuration:0.1 animations:^{
//                [scrollerBGView l_v_setX:(scrollerBGView.l_v_w-size.width)-scrollerImageView.image.size.width-15];
            } completion:^(BOOL finished) {
                scrollerLabel.text=scrollerText;
            }];
        }
        else
        {
            pnt=[scroll convertPoint:pnt toView:tableList];
            
            NSIndexPath *indexPath=[tableList indexPathForRowAtPoint:pnt];
            
            if(!_scrollerIndexPath)
                _scrollerIndexPath=indexPath;
            else if(_scrollerIndexPath.row==indexPath.row)
                return;
            
            _scrollerIndexPath=indexPath;
            
            if(!indexPath)
            {
                [UIView animateWithDuration:0.1f animations:^{
                    scrollerView.alpha=0;
                }];
                
                return;
            }
            
            switch (_viewMode) {
                    
                case SHOP_LIST_VIEW_SHOP_LIST:
                case SHOP_LIST_VIEW_LIST:
                {
                    if(indexPath.row==_shopsList.count)
                    {
                        scrollerText=@"Đang tải thêm dữ liệu";
                    }
                    else
                    {
                        ShopList *shop=_shopsList[indexPath.row];
                        
                        switch (_sort) {
                            case SORT_LIST_DISTANCE:
                                scrollerText=shop.distance;
                                break;
                                
                            case SORT_LIST_LOVE:
                                scrollerText=shop.numOfLove;
                                break;
                                
                            case SORT_LIST_VIEW:
                                scrollerText=shop.numOfView;
                                break;
                                
                            case SORT_LIST_DEFAULT:
                                scrollerText=shop.distance;
                                break;
                        }
                    }
                }
                    break;
                    
                case SHOP_LIST_VIEW_PLACE:
                case SHOP_LIST_VIEW_IDPLACE:
                    
                    switch (indexPath.row) {
                        case 0:
                            scrollerText=_placeList.title;
                            break;
                            
                        default:
                        {
                            if(indexPath.row==_shopsList.count)
                            {
                                scrollerText=@"Đang tải thêm dữ liệu";
                            }
                            else
                            {
                                ShopList *shop=_shopsList[indexPath.row-1];
                                
                                switch (_sort) {
                                    case SORT_LIST_DISTANCE:
                                        scrollerText=shop.distance;
                                        break;
                                        
                                    case SORT_LIST_LOVE:
                                        scrollerText=shop.numOfLove;
                                        break;
                                        
                                    case SORT_LIST_VIEW:
                                        scrollerText=shop.numOfView;
                                        break;
                                        
                                    case SORT_LIST_DEFAULT:
                                        scrollerText=shop.distance;
                                        break;
                                }
                            }
                        }
                            break;
                    }
                    
                    break;
            }
            
            CGSize size=[scrollerText sizeWithFont:scrollerLabel.font];
            
            size.height=scrollerLabel.l_v_h;
            
            scrollerLabel.text=scrollerText;
            
            [UIView animateWithDuration:0.1 animations:^{
                scrollerView.alpha=1;
//                [scrollerBGView l_v_setX:(scrollerBGView.l_v_w-size.width)-scrollerImageView.image.size.width-15];
            } completion:^(BOOL finished) {
                scrollerLabel.text=scrollerText;
            }];
        }
        
        //end scroller
    }
    else if(scrollView==tableList)
    {
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(_isDidUpdateLocation)
        return;
    
    _isDidUpdateLocation=true;
    
    [map setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, MAP_SPAN, MAP_SPAN) animated:false];
}

-(void) scrollPanGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            if(_isZoomedMap)
            {
                CGPoint pnt=[scroll convertPoint:tableList.l_v_o toView:self.view];
                
                float y=tableList.l_v_y+25;
                
                if([self hasRow])
                    y=[tableList rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height*1.5f;
                else
                    y+=44;
                
                if(self.l_v_h-pnt.y>y)
                {
                    [scroll setContentOffset:scroll.contentOffset animated:true];
                    self.view.userInteractionEnabled=false;
                    map.userInteractionEnabled=false;
                    map.scrollEnabled=false;
                    map.zoomEnabled=false;
                    tableList.userInteractionEnabled=true;
                    
                    btnScanBig.alpha=0;
                    btnScanBig.hidden=false;
                    
                    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                        scroll.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
                        [qrCodeView l_v_setY:_qrFrame.origin.y];
                        
                        btnScanBig.alpha=1;
                        btnScanSmall.alpha=0;
                        btnScanBig.frame=_buttonScanBigFrame;
                        btnScanSmall.frame=_buttonScanSmallFrame;
                    } completion:^(BOOL finished) {
                        _isZoomedMap=false;
                        [self makeScrollSize];
                        
                        self.view.userInteractionEnabled=true;
                    }];
                }
            }
            else
            {
                CGPoint pnt=[pan velocityInView:scroll];
                
                if(pnt.y<0)
                    return;
                
                pnt=[scroll convertPoint:tableList.l_v_o toView:self.view];
                
                if(pnt.y>_tableFrame.origin.y+20)
                {
                    self.view.userInteractionEnabled=false;
                    map.userInteractionEnabled=true;
                    map.scrollEnabled=true;
                    map.zoomEnabled=true;
                    tableList.userInteractionEnabled=false;
                    
                    _isZoomedMap=true;
                    
                    float height=[self heightForZoom];
                    _heightZoomedMap=height;
                    
                    btnScanSmall.alpha=0;
                    btnScanSmall.hidden=false;
                    
                    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                        [scroll setContentOffset:CGPointMake(0, -height) animated:false];
                        [qrCodeView l_v_setY:_qrFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
                        
                        btnScanSmall.alpha=1;
                        btnScanBig.alpha=0;
                        btnScanBig.frame=_buttonScanSmallFrame;
                        btnScanSmall.frame=_buttonScanBigFrame;
                        
                    } completion:^(BOOL finished) {
                        [scroll l_cs_setH:scroll.l_v_h-height+1];
                        scroll.contentInset=UIEdgeInsetsMake(height, 0, 0, 0);
                        
                        self.view.userInteractionEnabled=true;
                    }];
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(float) heightForZoom
{
    float height=scroll.l_v_h-(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT);
    
    if([self hasRow])
        height-=[tableList rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height/2+18;
    else
        height-=44;
    
    height-=_tableFrame.origin.y;
    
    return height;
}

-(bool) hasRow
{
    return tableList.numberOfSections>0 && [tableList numberOfRowsInSection:0]>0;
}

-(void) zoomMap
{
    self.view.userInteractionEnabled=false;
    _isZoomedMap=true;
    
    tableList.userInteractionEnabled=false;
    map.userInteractionEnabled=true;
    map.scrollEnabled=true;
    map.zoomEnabled=true;
    
    float height=[self heightForZoom];
    
    CGPoint pnt=CGPointZero;
    pnt.y=-(height);
    [scroll l_cs_setH:scroll.l_v_h-height+1];
    
    _heightZoomedMap=height;
    
    btnScanSmall.alpha=0;
    btnScanSmall.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        scroll.contentInset=UIEdgeInsetsMake(height, 0, 0, 0);
        [qrCodeView l_v_setY:_qrFrame.origin.y+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
        
        btnScanSmall.alpha=1;
        btnScanBig.alpha=0;
        btnScanBig.frame=_buttonScanSmallFrame;
        btnScanSmall.frame=_buttonScanBigFrame;
        
        scrollerView.alpha=true;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
        scrollerView.hidden=true;
    }];
}

-(void) tapBot:(UITapGestureRecognizer*) tap
{
    [self endZoomMap];
}

-(void) endZoomMap
{
    _isZoomedMap=false;
    
    map.userInteractionEnabled=false;
    map.scrollEnabled=false;
    map.zoomEnabled=false;
    tableList.userInteractionEnabled=true;
    
    btnScanBig.alpha=0;
    btnScanBig.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        scroll.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
        [qrCodeView l_v_setY:_qrFrame.origin.y];
        
        btnScanBig.alpha=1;
        btnScanSmall.alpha=0;
        btnScanBig.frame=_buttonScanBigFrame;
        btnScanSmall.frame=_buttonScanSmallFrame;
        
        scrollerView.alpha=1;
    } completion:^(BOOL finished) {
        scrollerView.hidden=true;
        [self makeScrollSize];
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView==scroll)
        [self loadScroller];
}

- (void)dealloc
{
    for(id<MKAnnotation> ann in map.annotations)
    {
        if([ann isKindOfClass:[ShopPinView class]])
        {
            MKAnnotationView *pin = [map viewForAnnotation:ann];
            
            [pin removeObserver:self forKeyPath:@"selected"];
        }
    }
    
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
    
    scroll.delegate=nil;
}

-(void) animationTableReload
{
    if(_isNeedAnimationChangeTable)
    {
        self.view.userInteractionEnabled=false;
        [scroll alphaViewWithColor:COLOR_BACKGROUND_SHOP_SERIES belowView:tableList];
        scroll.alphaView.frame=CGRectMake(tableList.l_v_x, tableList.l_v_y, tableList.l_cs_w, tableList.l_cs_h);
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            tableList.alpha=0.5f;
        } completion:^(BOOL finished) {
            tableList.dataSource=self;
            [tableList reloadData];
            
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                tableList.alpha=1;
            } completion:^(BOOL finished) {
                [scroll removeAlphaView];
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

-(IBAction) btnLocationTouchUpInside:(id)sender
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

@end

@implementation ScrollShopList

@end

@implementation ShopListContentView



@end

@implementation ShopListView



@end