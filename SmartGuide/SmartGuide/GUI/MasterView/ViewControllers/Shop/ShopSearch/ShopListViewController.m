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
    
    return self;
}

-(ShopListViewController *)initWithPlaceList
{
    self=[super initWithNibName:@"ShopListViewController" bundle:nil];
    
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
    return _shopsList.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shopsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
    cell.delegate=self;
    
    [cell loadWithShopList:_shopsList[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopListCell heightWithContent:[_shopsList[indexPath.row] desc]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    return;
    if(scrollerView)
        return;
    
    scrollBar=[scroll scrollBar];
    scrollBar.clipsToBounds=false;
    
    [scrollBar addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
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
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(-1, 0, 320, 29)];
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
    //[scroll insertSubview:scrollerView aboveSubview:scrollBar];
    
    [scrollerBGView l_v_setX:scrollerView.l_v_w];
    
}

-(void)shopListCellTouched:(ShopListCell *)cell
{
    if(_isZoomedMap)
    {
        [self endZoomMap];
        return;
    }
    
//    [self.map removeFromSuperview];
    [[GUIManager shareInstance] presentShopUserWithIDShop:0];
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
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Tìm kiếm theo" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Khoảng cách", @"Lượt xem", @"Lượt love", nil];
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==3)
        return;
    
    [sortView setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _isAllowDiffScrollMap=true;
    self.map.autoresizingMask=UIViewAutoresizingNone;
    [scroll insertSubview:self.map belowSubview:tableList];
    self.map.userInteractionEnabled=false;
    self.map.scrollEnabled=false;
    self.map.zoomEnabled=false;
    
    CGRect rect=CGRectZero;
    rect.size.height=self.l_v_h-qrCodeView.l_v_h+QRCODE_RAY_HEIGHT;
    rect.size.width=self.l_v_w;
    rect.origin.y=-tableList.l_v_h/SHOP_LIST_SCROLL_SPEED;
    self.map.frame=rect;
    
    sortView.delegate=self;
    
    [self storePosition];
    
    scroll.minContentOffsetY=-1;
    scroll.shopListController=self;
    
    if([self.map respondsToSelector:@selector(setShowsBuildings:)])
        self.map.showsBuildings=false;
    
    if([self.map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        self.map.showsPointsOfInterest=false;
    
    tableList.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    
    [tableList registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];

    [sortView setIcon:[UIImage imageNamed:@"icon_distance.png"] text:@"Khoảng cách"];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTop:)];
    tap.delegate=self;
    _tapTop=tap;
    
    [self.view addGestureRecognizer:tap];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    [self makeScrollSize];
    
    _shopsList=[NSMutableArray array];
    
    _page=-1;
    _sort=SORT_SHOP_LIST_DISTANCE;
    [self requestShopSearch];
    
    [self.view showLoading];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void) requestShopSearch
{
    if(_operationShopSearch)
    {
        [_operationShopSearch cancel];
        _operationShopSearch=nil;
    }
    
    _operationShopSearch=[[ASIOperationShopSearch alloc] initWithKeywords:_keyword userLat:userLat() userLng:userLng() page:_page+1 sort:_sort];
    
    _operationShopSearch.delegatePost=self;
    [_operationShopSearch startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self.view removeLoading];
        
        ASIOperationShopSearch *ope=(ASIOperationShopSearch*) operation;
        
        [_shopsList addObjectsFromArray:ope.shopsList];
        
        _page++;
        _canLoadMore=ope.shopsList.count==10;
        
        tableList.dataSource=self;
        tableList.delegate=self;
        
        [tableList reloadData];
        
        [self makeScrollSize];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationShopSearch class]])
    {
        [self.view removeLoading];
        
        _operationShopSearch=nil;
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
    scroll.contentSize=CGSizeMake(scroll.l_v_w, tableList.l_v_y+MAX(_tableFrame.size.height,tableList.contentSize.height));
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

-(void)scrollViewSetContentOffset:(CGPoint)contentOffset
{
    /*
     return;
     if(y>-_tableFrame.origin.y)
     {
     y=_mapFrame.origin.y+contentOffset.y-_mapFrame.origin.y;
     }
     
     [self.map l_v_setY:y];
     
     y=_tableFrame.origin.y-contentOffset.y;
     
     if(y>_qrFrame.origin.y/2)
     {
     y=_tableFrame.origin.y+scroll.contentOffset.y+(_qrFrame.origin.y-_tableFrame.origin.y);
     }
     
     [tableList l_v_setY:y];
     
     NSLog(@"%f",y);
     
     return;
     if(scroll.contentOffset.y-self.map.l_v_y<=0)
     {
     [self.map l_v_setY:-scroll.contentOffset.y];
     }
     else
     [self.map l_v_setY:scroll.contentOffset.y+self.map.l_v_y];
     
     NSLog(@"%f",scroll.contentOffset.y+tableList.l_v_h);
     
     return;
     [scroller scrollViewDidScroll:scroll];
     
     CGPoint offset=scroller.center;
     
     offset=[[scroller scrollBar] convertPoint:offset toView:scroll];
     offset=[scroll convertPoint:offset toView:tableList];
     
     NSIndexPath *indexPath=[tableList indexPathForRowAtPoint:offset];
     
     if(indexPath)
     {
     if(!_lastScrollerIndexPath || _lastScrollerIndexPath.row!=indexPath.row)
     {
     NSNumber *num=@[@(9),@(99),@(999),@(9999)][random_int(0, 4)];
     
     [scroller setText:[NSString stringWithFormat:@"%i km",num.integerValue] prefix:@"km"];
     
     _lastScrollerIndexPath=indexPath;
     }
     }
     */
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
        
        [scrollerView l_v_setY:y];
        
//        [scrollerView l_v_setY:scrollView.contentOffset.y];
//        [scrollerView l_v_addY:-scroll.offset.y];
        
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
                [scrollerBGView l_v_setX:(scrollerBGView.l_v_w-size.width)-scrollerImageView.image.size.width-8];
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
            
            scrollerText=[NSString stringWithFormat:@"Row %i",indexPath.row];
            
            CGSize size=[scrollerText sizeWithFont:scrollerLabel.font];
            
            size.height=scrollerLabel.l_v_h;
            
            scrollerLabel.text=scrollerText;
            
            [UIView animateWithDuration:0.1 animations:^{
                scrollerView.alpha=1;
                [scrollerBGView l_v_setX:(scrollerBGView.l_v_w-size.width)-scrollerImageView.image.size.width-8];
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
                [self endZoomMap];
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
        scroll.minContentOffsetY=0;
        
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
    scroll.minContentOffsetY=-1;
    
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
                float y=-(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT);

            }];
    }
}

-(void)showQRView
{

}

-(void)hideQRView
{

}

-(MKMapView*)map
{
    return [MapList shareInstance];
}

@end

@implementation ScrollShopList
@synthesize disableScrollUp,offset,shopListController,minContentOffsetY;

-(void)setContentOffset:(CGPoint)contentOffset
{
    if(minContentOffsetY!=-1)
    {
        if(contentOffset.y<minContentOffsetY)
            contentOffset.y=minContentOffsetY;
    }
    
    offset=CGPointMake(contentOffset.x-self.contentOffset.x, contentOffset.y-self.contentOffset.y);
    
    [super setContentOffset:contentOffset];
}

@end

@implementation ShopListContentView



@end

@implementation ShopListView



@end