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

#define SHOP_LIST_SHOW_MAP_HEIGHT 255
#define SHOP_LIST_MAP_ZOOMED_Y -19

@interface ShopListViewController ()

@end

@implementation ShopListViewController
@synthesize delegate,catalog;

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
    _mapFrame=map.frame;
    _mapCenter=map.center;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self storePosition];
    
    if([map respondsToSelector:@selector(setShowsBuildings:)])
        map.showsBuildings=false;
    
    if([map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        map.showsPointsOfInterest=false;
    
    tableList.backgroundColor=COLOR_BACKGROUND_SHOP_SERIES;
    
    [tableList registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];
    
    [tableList reloadData];
    [tableList l_v_setS:tableList.contentSize];
    //
    //    [listView l_v_setH:tableList.l_v_y+tableList.l_v_h];
    //
    
    [self refreshScrollSize];
    
    float y=QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
    [scroll l_v_addH:y];
    
    [sortView setIcon:[UIImage imageNamed:@"icon_distance.png"] text:@"Khoảng cách"];
    
    scroller=[[Scroller alloc] init];
    scroller.delegate=self;
    [scroller setIcon:[UIImage imageNamed:@"icon_heartscroll.png"]];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
}

-(void) panShowMap:(UIPanGestureRecognizer*) pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        {
            CGPoint pnt=[scroll convertPoint:tableList.l_v_o toView:self.view];
            if(pnt.y>self.l_v_h/2)
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

-(void) refreshScrollSize
{
    scroll.contentSize=CGSizeMake(scroll.l_v_w, tableList.l_v_y+tableList.contentSize.height+(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT+6));
}

-(UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return tableList;
}

-(NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    return [NSDate date];
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

        [map l_c_addY:-scroll.offset.y/3];
        return;
        
        [scroller scrollViewDidScroll:scroll];
        
        CGPoint offset=scroller.center;
        
        offset=[[scroller scrollBar] convertPoint:offset toView:scrollView];
        
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

// Dùng để lấy alignPoint
/*
 -(void) move
 {
 if(!self.parentViewController)
 return;
 
 map.centerCoordinate=CLLocationCoordinate2DMake(map.centerCoordinate.latitude+0.001f, map.centerCoordinate.longitude);
 
 NSLog(@"%f %f xxx %f",map.centerCoordinate.latitude,map.centerCoordinate.longitude,map.centerCoordinate.latitude-lll.latitude);
 
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
    map.userInteractionEnabled=true;
    map.scrollEnabled=true;
    map.zoomEnabled=true;
    
    if([map respondsToSelector:@selector(setRotateEnabled:)])
        map.rotateEnabled=true;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{

        float y=QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT;
        scroll.contentSize=CGSizeMake(scroll.l_v_w, scroll.l_v_h+1);
        
        [[GUIManager shareInstance].rootViewController.qrCodeView l_v_addY:y];
        
        [map l_v_setY:-(map.l_v_h-self.l_v_h)];
        [tableList l_c_addY:SHOP_LIST_SHOW_MAP_HEIGHT];
        [btnSearchLocation l_c_addY:SHOP_LIST_SHOW_MAP_HEIGHT];
        [btnMap l_c_addY:SHOP_LIST_SHOW_MAP_HEIGHT];
        [sortView l_c_addY:SHOP_LIST_SHOW_MAP_HEIGHT];
    } completion:^(BOOL finished) {
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
    map.userInteractionEnabled=false;
    map.scrollEnabled=false;
    map.zoomEnabled=false;
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(panShowMap:)];
    [scroll.panGestureRecognizer removeTarget:self action:@selector(scrollPanGes:)];
    
    [scroll setContentOffset:scroll.contentOffset animated:true];
    
    _tapBot.delegate=nil;
    [_tapBot removeTarget:self action:@selector(tapTable:)];
    [tableList removeGestureRecognizer:_tapBot];
    _tapBot=nil;
    
    if([map respondsToSelector:@selector(setRotateEnabled:)])
        map.rotateEnabled=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        
        float y=-(QRCODE_BIG_HEIGHT-QRCODE_SMALL_HEIGHT);
        [[GUIManager shareInstance].rootViewController.qrCodeView l_v_addY:y];
        
        map.frame=_mapFrame;
        [tableList l_c_addY:-SHOP_LIST_SHOW_MAP_HEIGHT];
        [btnSearchLocation l_c_addY:-SHOP_LIST_SHOW_MAP_HEIGHT];
        [btnMap l_c_addY:-SHOP_LIST_SHOW_MAP_HEIGHT];
        [sortView l_c_addY:-SHOP_LIST_SHOW_MAP_HEIGHT];
        
        [self refreshScrollSize];
        
        scroll.delegate=nil;
        scroll.contentOffset=CGPointZero;
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
    return;
    if(scrollView==scroll)
        [scroller scrollViewWillBeginDragging:scrollView];
}

- (void)dealloc
{
    scroll.delegate=nil;
    scroller=nil;
}

@end

@implementation ScrollShopList
@synthesize disableScrollUp,offset;

-(void)setContentOffset:(CGPoint)contentOffset
{
    offset=CGPointMake(self.contentOffset.x-contentOffset.x, self.contentOffset.y-contentOffset.y);
    
    if(disableScrollUp)
    {
        if(contentOffset.y<0)
            contentOffset.y=0;
    }
    
    [super setContentOffset:contentOffset];
}

@end