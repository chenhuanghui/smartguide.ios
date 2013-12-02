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
@synthesize delegate,catalog,shopController,qrCodeView,isShowedQRView,qrViewFrame;

- (id)init
{
    self = [super initWithNibName:@"ShopListViewController" bundle:nil];
    if (self) {
        
    }
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopListCell reuseIdentifier]];
    
    [cell loadContent];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopListCell height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[GUIManager shareInstance] presentShopUserWithIDShop:0];
}

-(void) storePosition
{
    _tableFrame=tableList.frame;
    _mapFrame=self.map.frame;
    _contentFrame=contentView.frame;
    _scrollFrame=scroll.frame;
    _viewFrame=self.view.frame;
    _qrFrame=qrCodeView.frame;
    _buttonMapFrame=btnMap.frame;
    _buttonSearchLocationFrame=btnSearchLocation.frame;
    _sortFrame=sortView.frame;
}

-(void)sortViewTouchedSort:(ShopListSortView *)_sortView
{
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Tìm kiếm theo" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Khoảng cách", @"Lượt xem", @"Lượt love", nil];
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [sortView setText:[actionSheet buttonTitleAtIndex:buttonIndex]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [contentView insertSubview:self.map belowSubview:tableList];
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
    
    tableList.dataSource=self;
    tableList.delegate=self;
    
    [tableList reloadData];
    
    [self makeScrollSize];
    
    [sortView setIcon:[UIImage imageNamed:@"icon_distance.png"] text:@"Khoảng cách"];
    
    scroller=[[Scroller alloc] init];
    scroller.delegate=self;
    [scroller setIcon:[UIImage imageNamed:@"icon_heartscroll.png"]];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTop:)];
    tap.delegate=self;
    _tapTop=tap;
    
    [self.view addGestureRecognizer:tap];
    
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
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
            CGPoint pnt=[scroll convertPoint:tableList.l_v_o toView:self.view];
            if(pnt.y>_tableFrame.origin.y+[ShopListCell height])
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
    CGSize size=tableList.contentSize;
    size.height=MAX(_tableFrame.size.height,size.height);
    [tableList l_v_setS:size];
    scroll.contentSize=CGSizeMake(scroll.l_v_w, tableList.l_v_y+tableList.l_v_h);
    scroll.contentInset=UIEdgeInsetsMake(0, 0, qrCodeView.l_v_h, 0);
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
        
        if(!_isZoomedMap)
            [self.map l_v_addY:y];
        
        [scroller scrollViewDidScroll:scroll];
        [scroller setText:@"XXX" prefix:@""];
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
            
            if(self.l_v_h-pnt.y>[ShopListCell height]*1.5f)
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
    self.map.userInteractionEnabled=true;
    self.map.scrollEnabled=true;
    self.map.zoomEnabled=true;
    
    if([self.map respondsToSelector:@selector(setRotateEnabled:)])
        self.map.rotateEnabled=true;
    
    float height=_viewFrame.size.height-_qrFrame.size.height+QRCODE_RAY_HEIGHT+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
    height-=[ShopListCell height];
    height-=_tableFrame.origin.y;

    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        
        float y=QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
        [self.qrCodeView l_v_addY:y];

        scroll.contentInset=UIEdgeInsetsMake(0, 0, QRCODE_RAY_HEIGHT, 0);
        scroll.contentSize=scroll.l_v_s;
        
        [tableList l_c_addY:height];
        [btnMap l_c_addY:height];
        [btnSearchLocation l_c_addY:height];
        [sortView l_c_addY:height];
        [self.map l_v_setY:0];
    } completion:^(BOOL finished) {
        scroll.minContentOffsetY=0;
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
    
    float height=_viewFrame.size.height-_qrFrame.size.height+QRCODE_RAY_HEIGHT+QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
    height-=[ShopListCell height];
    height-=_tableFrame.origin.y;
    
    [self makeScrollSize];
    
    [scroll setContentOffset:CGPointZero animated:true];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
    [scroll.panGestureRecognizer removeTarget:self action:@selector(scrollPanGes:)];
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:_tapTop];
    
    _tapBot.delegate=nil;
    [_tapBot removeTarget:self action:@selector(tapTable:)];
    [tableList removeGestureRecognizer:_tapBot];
    _tapBot=nil;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{

        float y=QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
        [self.qrCodeView l_v_addY:-y];
        
        [tableList l_v_setO:_tableFrame.origin];
        [btnMap l_v_setO:_buttonMapFrame.origin];
        [btnSearchLocation l_v_setO:_buttonSearchLocationFrame.origin];
        [sortView l_v_setO:_sortFrame.origin];
        [self.map l_v_setO:_mapFrame.origin];

        [self makeScrollSize];
    } completion:^(BOOL finished) {
        scroll.delegate=self;
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
        [scroller scrollViewWillBeginDragging:scrollView];
}

- (void)dealloc
{
    scroll.delegate=nil;
    scroller=nil;
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
                [[self qrCodeView] l_v_addY:y];
            }];
    }
}

-(void)showQRView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        [self.qrCodeView l_v_setO:CGPointZero];
    }];
}

-(void)hideQRView
{
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        if(_isZoomedMap)
            [self.qrCodeView l_v_setO:CGPointMake(0, self.qrViewFrame.origin.y+(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT))];
        else
            [self.qrCodeView l_v_setO:CGPointMake(0, self.qrViewFrame.origin.y)];
    }];
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