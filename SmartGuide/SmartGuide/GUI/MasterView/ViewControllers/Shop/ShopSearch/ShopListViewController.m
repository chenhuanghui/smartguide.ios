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

#define SHOP_LIST_SCROLL_SPEED 3.f

@interface ShopListViewController ()

@end

@implementation ShopListViewController
@synthesize delegate,searchController;

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
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            return _shopsList.count;
            
        case SHOP_LIST_VIEW_PLACE:
            return _shopsList.count+1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
        {
            ShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
            cell.delegate=self;
            
            [cell loadWithShopList:_shopsList[indexPath.row]];
            
            if(indexPath.row==_shopsList.count-1)
            {
                if(_canLoadMore)
                {
                    if(!_isLoadingMore)
                    {
                        [self requestShopSearch];
                        _isLoadingMore=true;
                    }
                }
            }
            
            return cell;
        }
            
        case SHOP_LIST_VIEW_PLACE:
            
            switch (indexPath.row) {
                case 0:
                {
                    ShopListPlaceCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListPlaceCell reuseIdentifier]];
                    
                    [cell loadWithPlace:_placeList];
                    
                    return cell;
                }
                    break;
                    
                default:
                {
                    ShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
                    cell.delegate=self;
                    
                    [cell loadWithShopList:_shopsList[indexPath.row-1]];
                    
                    if(indexPath.row==_shopsList.count)
                    {
                        if(_canLoadMore)
                        {
                            if(!_isLoadingMore)
                            {
                                [self requestPlacelistDetail];
                                _isLoadingMore=true;
                            }
                        }
                    }
                    
                    return cell;
                }
                    break;
            }
            
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
        case SHOP_LIST_VIEW_SHOP_LIST:
            return [ShopListCell heightWithContent:[_shopsList[indexPath.row] desc]];
            
        case SHOP_LIST_VIEW_PLACE:
        {
            switch (indexPath.row) {
                case 0:
                    return [ShopListPlaceCell heightWithContent:_placeList.desc];
                    
                default:
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
            shop=_shopsList[indexPath.row];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
        {
            switch (indexPath.row) {
                case 0:
                    
                    break;
                    
                default:
                    shop=_shopsList[indexPath.row-1];
                    break;
            }
        }
            break;
    }
    
    if(shop)
        [[GUIManager shareInstance] presentShopUserWithShopList:shop];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object==scrollBar)
    {
        float new=[change[NSKeyValueChangeNewKey] floatValue];
        
        [UIView animateWithDuration:0.1f animations:^{
            scrollerView.alpha=new;
        }];
    }
}

-(void) loadScroller
{
    if(scrollerView)
        return;
    
    scrollBar=[scroll scrollBar];
    scrollBar.clipsToBounds=false;
    
    [scrollBar addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 315, 29)];
    v.layer.masksToBounds=true;
    v.backgroundColor=[UIColor clearColor];
    v.hidden=_isZoomedMap;
    
    scrollerView=v;
    
    UIView *bg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
    bg.backgroundColor=[UIColor clearColor];
    
    scrollerBGView=bg;
    
    [v addSubview:bg];
    
    UIImageView *slide_head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgslide_head.png"]];
    slide_head.frame=CGRectMake(0, 0, 30, 29);
    slide_head.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    
    [bg addSubview:slide_head];
    
    UIView *slide_mid=[[UIView alloc] initWithFrame:CGRectMake(slide_head.l_v_w, 0, bg.l_v_w-slide_head.l_v_w, bg.l_v_h)];
    slide_mid.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgslide_mid.png"]];
    
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
    
    [scrollerContain addSubview:scrollerView];
    
    [scrollerBGView l_v_setX:scrollerView.l_v_w];
    
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

-(void) storePosition
{
    _tableFrame=tableList.frame;
    _mapFrame=self.map.frame;
    _qrFrame=qrCodeView.frame;
    _buttonMapFrame=btnMap.frame;
    _buttonSearchLocationFrame=btnSearchLocation.frame;
    _sortFrame=sortView.frame;
    _buttonScanBigFrame=btnScanBig.frame;
    _buttonScanSmallFrame=btnScanSmall.frame;
}

-(void)sortViewTouchedSort:(ShopSearchSortView *)_sortView
{
    UIActionSheet *sheet=nil;
    
    switch (_viewMode) {
            
        case SHOP_LIST_VIEW_SHOP_LIST:
            return;
            
        case SHOP_LIST_VIEW_LIST:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Tìm kiếm theo" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Khoảng cách", @"Lượt xem", @"Lượt love", nil];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Tìm kiếm theo" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Khoảng cách", @"Lượt xem", @"Lượt love",@"Mặc định", nil];
            break;
    }
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==3)
        return;
    
    switch (_viewMode) {
            
        case SHOP_LIST_VIEW_SHOP_LIST:
            break;
            
        case SHOP_LIST_VIEW_LIST:
        {
            enum SORT_SHOP_LIST sort;
            
            switch (buttonIndex) {
                case 0:
                    sort=SORT_SHOP_LIST_DISTANCE;
                    break;
                    
                case 1:
                    sort=SORT_SHOP_LIST_VIEW;
                    break;
                    
                case 2:
                    sort=SORT_SHOP_LIST_LOVE;
                    break;
                    
                default:
                    sort=SORT_SHOP_LIST_DISTANCE;
                    break;
            }
            
            if(sort==_sort)
                return;
            
            [self changeSort:sort];
        }
            break;
            
        case SHOP_LIST_VIEW_PLACE:
        {
            enum SORT_PLACE_LIST sort;
            
            switch (buttonIndex) {
                case 0:
                    sort=SORT_PLACE_LIST_DISTANCE;
                    break;
                    
                case 1:
                    sort=SORT_PLACE_LIST_VIEW;
                    break;
                    
                case 2:
                    sort=SORT_PLACE_LIST_LOVE;
                    break;
                    
                default:
                    sort=SORT_PLACE_LIST_DEFAULT;
                    break;
            }
            
            if(sort==_sortPlace)
                return;
            
            [self changeSortPlace:sort];
        }
            break;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    scroll.minimumOffsetY=-1;
    
    txt.leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, txt.l_v_h)];
    txt.leftView.backgroundColor=[UIColor clearColor];
    txt.leftViewMode=UITextFieldViewModeAlways;
    
    self.map.delegate=self;
    [self clearMap];
    
    _isAllowDiffScrollMap=true;
    self.map.autoresizingMask=UIViewAutoresizingNone;
    [scroll insertSubview:self.map belowSubview:tableList];
    self.map.userInteractionEnabled=false;
    self.map.scrollEnabled=false;
    self.map.zoomEnabled=false;
    
    if([self.map respondsToSelector:@selector(setShowsBuildings:)])
        self.map.showsBuildings=false;
    
    if([self.map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        self.map.showsPointsOfInterest=false;
    
    CGRect rect=CGRectZero;
    rect.size.height=self.l_v_h-qrCodeView.l_v_h+QRCODE_RAY_HEIGHT;
    rect.size.width=self.l_v_w;
    rect.origin.y=-tableList.l_v_h/SHOP_LIST_SCROLL_SPEED;
    self.map.frame=rect;
    
    _location.latitude=userLat();
    _location.longitude=userLng();
    
    [self storePosition];
    
    tableList.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    
    [tableList registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];
    [tableList registerNib:[UINib nibWithNibName:[ShopListPlaceCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListPlaceCell reuseIdentifier]];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTop:)];
    tap.delegate=self;
    _tapTop=tap;
    
    [self.view addGestureRecognizer:tap];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    _shopsList=[NSMutableArray array];
    _page=-1;
    
    sortView.delegate=self;
    btnSearchLocation.enabled=_viewMode==SHOP_LIST_VIEW_LIST;
    
    switch (_viewMode) {
        case SHOP_LIST_VIEW_LIST:
            
            txt.text=_keyword;
            
            [sortView setIcon:[UIImage imageNamed:@"icon_distance.png"] text:@"Khoảng cách"];
            _sort=SORT_SHOP_LIST_DISTANCE;
            [self requestShopSearch];
            [self.view showLoading];
            
            break;
            
        case SHOP_LIST_VIEW_SHOP_LIST:
            _canLoadMore=false;
            [self requestShopList];
            [self.view showLoading];
            break;
            
        case SHOP_LIST_VIEW_PLACE:
            
            txt.text=_placeList.title;
            
            _sortPlace=SORT_PLACE_LIST_DEFAULT;
            [sortView setIcon:[UIImage imageNamed:@"icon_distance.png"] text:@"Mặc định"];
            
            tableList.dataSource=self;
            tableList.delegate=self;
            
            [tableList reloadData];
            
            [tableList showLoading];
            [self requestPlacelistDetail];
            break;
    }
    
    [self makeScrollSize];
}

-(void) requestPlacelistDetail
{
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail cancel];
        _operationPlaceListDetail=nil;
    }
    
    _operationPlaceListDetail=[[ASIOperationPlacelistDetail alloc] initWithIDPlacelist:_placeList.idPlacelist.integerValue userLat:_location.latitude userLng:_location.longitude sort:SORT_PLACE_LIST_DEFAULT page:_page+1];
    _operationPlaceListDetail.delegatePost=self;
    
    [_operationPlaceListDetail startAsynchronous];
}

-(void) requestShopList
{
    if(_operationShopList)
    {
        [_operationShopList cancel];
        _operationShopList=nil;
    }
    
    _operationShopList=[[ASIOperationGetShopList alloc] initWithIDShops:_idShops userLat:userLat() userLng:userLng()];
    _operationShopList.delegatePost=self;
    
    [_operationShopList startAsynchronous];
}

-(void) requestShopSearch
{
    if(_operationShopSearch)
    {
        [_operationShopSearch cancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:_sort];
    
    _operationShopSearch.delegatePost=self;
    [_operationShopSearch startAsynchronous];
}

-(void) changeLocation:(CLLocationCoordinate2D) coordinate
{
    [self.view showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    tableList.dataSource=nil;
    _shopsList=[NSMutableArray array];
    _page=-1;
    _location=coordinate;
    
    switch (_sort) {
        case SORT_SHOP_LIST_DISTANCE:
            [sortView setText:@"Khoảng cách"];
            break;
            
        case SORT_SHOP_LIST_VIEW:
            [sortView setText:@"Lượt xem"];
            break;
            
        case SORT_SHOP_LIST_LOVE:
            [sortView setText:@"Lượt love"];
            
    }
    
    [self clearMap];
    
    if(_operationShopSearch)
    {
        [_operationShopSearch cancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:_sort];
    
    _operationShopSearch.delegatePost=self;
    [_operationShopSearch startAsynchronous];
}

-(void) changeSort:(enum SORT_SHOP_LIST) sort
{
    [self.view showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    tableList.dataSource=nil;
    _shopsList=[NSMutableArray array];
    _page=-1;
    _sort=sort;
    
    switch (_sort) {
        case SORT_SHOP_LIST_DISTANCE:
            [sortView setText:@"Khoảng cách"];
            break;
            
        case SORT_SHOP_LIST_VIEW:
            [sortView setText:@"Lượt xem"];
            break;
            
        case SORT_SHOP_LIST_LOVE:
            [sortView setText:@"Lượt love"];
            
    }
    
    [self clearMap];
    
    if(_operationShopSearch)
    {
        [_operationShopSearch cancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:_location.latitude userLng:_location.longitude page:_page+1 sort:sort];
    
    _operationShopSearch.delegatePost=self;
    [_operationShopSearch startAsynchronous];
}

-(void) changeSortPlace:(enum SORT_PLACE_LIST) sort
{
    [self.view showLoading];
    
    [tableList setContentOffset:tableList.contentOffset animated:true];
    
    tableList.dataSource=nil;
    _shopsList=[NSMutableArray array];
    _page=-1;
    _sortPlace=sort;
    
    switch (_sortPlace) {
        case SORT_PLACE_LIST_DISTANCE:
            [sortView setText:@"Khoảng cách"];
            break;
            
        case SORT_PLACE_LIST_VIEW:
            [sortView setText:@"Lượt xem"];
            break;
            
        case SORT_PLACE_LIST_LOVE:
            [sortView setText:@"Lượt love"];
            break;
            
        case SORT_PLACE_LIST_DEFAULT:
            [sortView setText:@"Mặc định"];
            break;
            
    }
    
    [self clearMap];
    
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail cancel];
        _operationPlaceListDetail=nil;
    }
    
    _operationPlaceListDetail=[[ASIOperationPlacelistDetail alloc] initWithIDPlacelist:_placeList.idPlacelist.integerValue userLat:_location.latitude userLng:_location.longitude sort:_sortPlace page:_page+1];
    
    _operationPlaceListDetail.delegatePost=self;
    [_operationPlaceListDetail startAsynchronous];
}

-(void) clearMap
{
    [self.map removeAnnotations:self.map.annotations];
    [self.map removeOverlays:self.map.overlays];
    
    self.map.showsUserLocation=true;
    self.map.showsUserLocation=false;
    self.map.showsUserLocation=true;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self.view removeLoading];
        [tableList removeLoading];
        
        ASIOperationShopSearch *ope=(ASIOperationShopSearch*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopsList];
        
        _page++;
        _canLoadMore=ope.shopsList.count==10;
        _isLoadingMore=false;
        
        tableList.dataSource=self;
        tableList.delegate=self;
        
        [tableList reloadData];
        
        NSMutableArray *coordinates=[NSMutableArray array];
        for(ShopList *shop in ope.shopsList)
        {
            [self.map addAnnotation:shop];
            
            [coordinates addObject:[NSValue valueWithMKCoordinate:shop.coordinate]];
        }
        
        if(!_isZoomedRegionMap)
        {
            _isZoomedRegionMap=true;
            
            if(isVailCLLocationCoordinate2D(self.map.userLocation.coordinate))
                [coordinates addObject:[NSValue valueWithMKCoordinate:self.map.userLocation.coordinate]];
            
            [self.map zoomToCoordinates:coordinates animate:true span:0];
        }
        
        [self makeScrollSize];
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistDetail class]])
    {
        [tableList removeLoading];
        [self.view removeLoading];
        
        ASIOperationPlacelistDetail *ope=(ASIOperationPlacelistDetail*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopsList];
        
        _page++;
        _canLoadMore=ope.shopsList.count==10;
        _isLoadingMore=false;
        
        tableList.dataSource=self;
        tableList.delegate=self;
        
        [tableList reloadData];
        
        NSMutableArray *coordinates=[NSMutableArray array];
        for(ShopList *shop in ope.shopsList)
        {
            [self.map addAnnotation:shop];
            
            [coordinates addObject:[NSValue valueWithMKCoordinate:shop.coordinate]];
        }
        
        if(!_isZoomedRegionMap)
        {
            _isZoomedRegionMap=true;
            
            if(isVailCLLocationCoordinate2D(self.map.userLocation.coordinate))
                [coordinates addObject:[NSValue valueWithMKCoordinate:self.map.userLocation.coordinate]];
            
            [self.map zoomToCoordinates:coordinates animate:true span:0];
        }
        
        [self makeScrollSize];
    }
    else if([operation isKindOfClass:[ASIOperationGetShopList class]])
    {
        [self.view removeLoading];
        
        ASIOperationGetShopList *ope=(ASIOperationGetShopList*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopLists];
        _canLoadMore=false;
        _isLoadingMore=false;
        
        NSMutableArray *coordinates=[NSMutableArray array];
        for(ShopList *shop in _shopsList)
        {
            [self.map addAnnotation:shop];
            
            [coordinates addObject:[NSValue valueWithMKCoordinate:shop.coordinate]];
        }
        
        if(!_isZoomedRegionMap)
        {
            _isZoomedRegionMap=true;
            
            if(isVailCLLocationCoordinate2D(self.map.userLocation.coordinate))
                [coordinates addObject:[NSValue valueWithMKCoordinate:self.map.userLocation.coordinate]];
            
            [self.map zoomToCoordinates:coordinates animate:true span:0];
        }
        
        [self makeScrollSize];
        
        _operationShopList=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self.view removeLoading];
        
        _operationShopSearch=nil;
    }
    else if([operation isKindOfClass:[ASIOperationPlacelistDetail class]])
    {
        [tableList removeLoading];
        [self.view removeLoading];
        
        _operationPlaceListDetail=nil;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer==_tapTop)
    {
        if(_isZoomedMap)
            return false;
        
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
    
    return true;
}

-(void) panShowMap:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            CGPoint pnt=[pan velocityInView:scroll];
            
            if(pnt.y<0)
                return;

            pnt=[scroll convertPoint:tableList.l_v_o toView:self.view];
            
            if(pnt.y>_tableFrame.origin.y+20)
            {
                // do animation delay nên sẽ bị bug ko move sortview
                _isZoomedMap=true;
                _isAllowDiffScrollMap=false;
                _isAnimatingZoom=true;
                self.map.userInteractionEnabled=true;
                self.map.scrollEnabled=true;
                self.map.zoomEnabled=true;
                scrollerView.hidden=true;
                
                [UIView animateWithDuration:DURATION_DEFAULT animations:^{
                    [self zoomMap];
                }];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void) makeScrollSize
{
    scroll.contentSize=CGSizeMake(scroll.l_v_w, _tableFrame.origin.y+MAX(_tableFrame.size.height,tableList.contentSize.height));
    scroll.contentInset=UIEdgeInsetsMake(0, 0, QRCODE_BIG_HEIGHT-QRCODE_RAY_HEIGHT, 0);
    scroll.scrollIndicatorInsets=scroll.contentInset;
}

-(void) tapTop:(UITapGestureRecognizer*) ges
{
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
        float y=scroll.offset.y/SHOP_LIST_SCROLL_SPEED;
        
        if(_isAllowDiffScrollMap)
            [self.map l_v_addY:y];
        
        y=scroll.contentOffset.y;
        
        if(y>=_tableFrame.origin.y && !_isZoomedMap)
        {
            [tableList l_v_setY:scroll.contentOffset.y];
            [tableList setContentOffset:CGPointMake(0, y-_tableFrame.origin.y)];
        }
        else
        {
            if(_isZoomedMap && !_isAnimatingZoom)
            {
                float height=_heightZoomedMap;
                
                [tableList l_v_setY:_tableFrame.origin.y+height];
            }
            else
            {
                [tableList l_v_setY:_tableFrame.origin.y];
                [tableList setContentOffset:CGPointZero];
            }
        }
        
        //begin scroller

        float height=(scroll.l_cs_h+scroll.contentInset.bottom-scroll.l_v_h);
        float percent=(scroll.l_co_y)/height;
        
        y=percent*(scrollerContain.l_v_h);

        y=MAX(36, y);
        y=MIN(scrollerContain.l_v_h-scrollerView.l_v_h-QRCODE_RAY_HEIGHT, y);
        
        [UIView animateWithDuration:0.3f animations:^{
            [scrollerView l_v_setY:y];
        }];
        
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
                [scrollerBGView l_v_setX:(scrollerBGView.l_v_w-size.width)-scrollerImageView.image.size.width-15];
            } completion:^(BOOL finished) {
                scrollerLabel.text=scrollerText;
            }];
        }
        else
        {
            pnt=[scroll convertPoint:pnt toView:tableList];
            
            NSIndexPath *indexPath=[tableList indexPathForRowAtPoint:pnt];
            
            if(!indexPath)
            {
                [UIView animateWithDuration:0.1f animations:^{
                    scrollerView.alpha=0;
                }];
                
                return;
            }
            
            switch (_viewMode) {
                    
                case SHOP_LIST_VIEW_SHOP_LIST:
                    return;
                    
                case SHOP_LIST_VIEW_LIST:
                {
                    ShopList *shop=_shopsList[indexPath.row];
                    
                    switch (_sort) {
                        case SORT_SHOP_LIST_DISTANCE:
                            scrollerText=shop.distance;
                            break;
                            
                        case SORT_SHOP_LIST_LOVE:
                            scrollerText=shop.numOfLove;
                            break;
                            
                        case SORT_SHOP_LIST_VIEW:
                            scrollerText=shop.numOfView;
                            break;
                    }
                }
                    break;
                    
                case SHOP_LIST_VIEW_PLACE:
                    switch (indexPath.row) {
                        case 0:
                            scrollerText=_placeList.title;
                            break;
                            
                        default:
                        {
                            ShopList *shop=_shopsList[indexPath.row-1];
                            
                            switch (_sortPlace) {
                                case SORT_PLACE_LIST_DISTANCE:
                                    scrollerText=shop.distance;
                                    break;
                                    
                                case SORT_PLACE_LIST_LOVE:
                                    scrollerText=shop.numOfLove;
                                    break;
                                    
                                case SORT_PLACE_LIST_VIEW:
                                    scrollerText=shop.numOfView;
                                    break;
                                    
                                case SORT_PLACE_LIST_DEFAULT:
                                    scrollerText=shop.numOfLove;
                                    break;
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
                [scrollerBGView l_v_setX:(scrollerBGView.l_v_w-size.width)-scrollerImageView.image.size.width-15];
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
    
    [self.map setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, MAP_SPAN, MAP_SPAN) animated:false];
}

// Dùng để lấy alignPoint
/*
 -(void) move
 {
 if(!self.parentViewController)
 return;
 
 self.map.centerCoordinate=CLLocationCoordinate2DMake(self.map.centerCoordinate.latitude+0.001f, self.map.centerCoordinate.longitude);
 
 NSLog(@"%f %f xxx %f",self.map.centerCoordinate.latitude,self.map.centerCoordinate.longitude,self.map.centerCoordinate.latitude-lll.latitude);
 
 [self performSelector:@selector(move) withObject:nil afterDelay:0.5];
 }
 */

-(void) scrollPanGes:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint pnt=[scroll convertPoint:tableList.l_v_o toView:self.view];
            
            if(self.l_v_h-pnt.y>[tableList rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height*1.5f)
            {
                _isZoomedMap=false;
                self.map.userInteractionEnabled=false;
                self.map.scrollEnabled=false;
                self.map.zoomEnabled=false;
                scroll.minimumOffsetY=-1;
                
                [self endZoomMap];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void) zoomMap
{
    _isZoomedMap=true;
    _isAllowDiffScrollMap=false;
    _isAnimatingZoom=true;
    self.map.userInteractionEnabled=true;
    self.map.scrollEnabled=true;
    self.map.zoomEnabled=true;
    scrollerView.hidden=true;
    
    [tableList alphaViewWithColor:[UIColor clearColor]];
    
    if([self.map respondsToSelector:@selector(setRotateEnabled:)])
        self.map.rotateEnabled=true;
    
    float height=scroll.l_v_h-(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT);//-_qrFrame.size.height+QRCODE_RAY_HEIGHT+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
    height-=[tableList rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].size.height/2+18;
    height-=_tableFrame.origin.y;
    
    _heightZoomedMap=height;
    
    btnScanSmall.alpha=0;
    btnScanSmall.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        
        btnScanSmall.alpha=1;
        btnScanBig.alpha=0;
        btnScanBig.frame=_buttonScanSmallFrame;
        btnScanSmall.frame=_buttonScanBigFrame;

        scroll.contentInset=UIEdgeInsetsMake(0, 0, QRCODE_RAY_HEIGHT, 0);
        scroll.contentSize=scroll.l_v_s;
        
        [qrCodeView l_v_addY:QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT];
        
        [tableList l_c_addY:height];
        [btnMap l_c_addY:height];
        [sortView l_c_addY:height];
        [self.map l_v_setY:0];
        scroll.minimumOffsetY=0;
        
        [btnSearchLocation l_v_setY:25];
    } completion:^(BOOL finished) {
        _isAllowDiffScrollMap=true;
        _isAnimatingZoom=false;
        
        btnScanBig.hidden=false;
    }];
    
    [scroll.panGestureRecognizer removeTarget:self action:@selector(panShowMap:)];
    [scroll.panGestureRecognizer addTarget:self action:@selector(scrollPanGes:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBot:)];
    
    _tapBot=tap;
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    [tableList addGestureRecognizer:tap];
}

-(void) tapBot:(UITapGestureRecognizer*) tap
{
    [self endZoomMap];
}

-(void) endZoomMap
{
    _isZoomedMap=false;
    self.map.userInteractionEnabled=false;
    self.map.scrollEnabled=false;
    self.map.zoomEnabled=false;
    scroll.minimumOffsetY=-1;
    
    if([self.map respondsToSelector:@selector(setRotateEnabled:)])
        self.map.rotateEnabled=false;
    
    [self makeScrollSize];
    
    [scroll setContentOffset:CGPointZero animated:true];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
    [scroll.panGestureRecognizer removeTarget:self action:@selector(scrollPanGes:)];
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:_tapTop];
    
    _tapBot.delegate=nil;
    [_tapBot removeTarget:self action:@selector(tapTable:)];
    [tableList removeGestureRecognizer:_tapBot];
    _tapBot=nil;
    
    btnScanBig.alpha=0;
    btnScanBig.hidden=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        
        btnScanBig.alpha=1;
        btnScanSmall.alpha=0;
        btnScanBig.frame=_buttonScanBigFrame;
        btnScanSmall.frame=_buttonScanSmallFrame;
        
        qrCodeView.frame=_qrFrame;
        
        [tableList l_v_setO:_tableFrame.origin];
        [btnMap l_v_setO:_buttonMapFrame.origin];
        [btnSearchLocation l_v_setO:_buttonSearchLocationFrame.origin];
        [sortView l_v_setO:_sortFrame.origin];
        [self.map l_v_setO:_mapFrame.origin];
        
        [self makeScrollSize];
    } completion:^(BOOL finished) {
        scroll.delegate=self;
        scrollerView.hidden=false;
        
        btnScanSmall.hidden=true;
        [tableList removeAlphaView];
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
        //[scroller scrollViewWillBeginDragging:scrollView];
}

- (void)dealloc
{
    if(_operationPlaceListDetail)
    {
        [_operationPlaceListDetail cancel];
        _operationPlaceListDetail=nil;
    }
    
    if(_operationShopSearch)
    {
        [_operationShopSearch cancel];
        _operationShopSearch=nil;
    }
    
    scroll.delegate=nil;
    [scrollBar removeObserver:self forKeyPath:@"alpha"];
}

-(bool)isZoomedMap
{
    return _isZoomedMap;
}

-(void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    
    if(!parent)
    {
        if(_isZoomedMap)
            [UIView animateWithDuration:DURATION_DEFAULT animations:^{
//                float y=-(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT);

            }];
    }
}

-(void)showQRView
{

}

-(void)hideQRView
{

}

-(MapList*)map
{
    return [MapList shareInstance];
}

-(IBAction) btnLocationTouchUpInside:(id)sender
{
    [self changeLocation:self.map.centerCoordinate];
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    float count=2;
    
    for(UIView *v in views)
    {
        if([v isKindOfClass:[MKPinAnnotationView class]])
        {
            [v l_v_addY:-50];
            
            [UIView animateWithDuration:0.15f*count animations:^{
                [v l_v_addY:50];
            }];
            
            count+=0.5f;
        }
    }
}

-(IBAction) btnBackTouchUpInside:(id)sender
{
    if(_operationShopSearch)
    {
        [_operationShopSearch cancel];
        _operationShopSearch=nil;
    }
    
    [self.delegate shopListControllerTouchedBack:self];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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
    
    self.map.mapType=MKMapTypeHybrid;
    self.map.mapType=MKMapTypeStandard;
}

@end

@implementation ScrollShopList

@end

@implementation ShopListContentView



@end

@implementation ShopListView



@end