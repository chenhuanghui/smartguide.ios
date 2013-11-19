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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [tableList registerNib:[UINib nibWithNibName:[ShopListCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopListCell reuseIdentifier]];
    
    topFrame=topView.frame;
    botFrame=botView.frame;
    _searchFrame=txtSearch.frame;
    
    _scrollOffset=CGPointMake(0, 241);
    scroll.contentOffset=_scrollOffset;
    scroll.contentSize=CGSizeMake(scroll.frame.size.width, scroll.frame.size.height*2);
    
    UITapGestureRecognizer *tapTop=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTop:)];
    _tapTop=tapTop;
    
    [topView addGestureRecognizer:tapTop];
    
//    _timeScroller=[[ACTimeScroller alloc] initWithDelegate:self];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rect=CGRectZero;
    
    if(scrollView==scroll)
    {
        rect=_searchFrame;
        rect.origin.y+=scroll.contentOffset.y-_scrollOffset.y;
        txtSearch.frame=rect;
    }
    else if(scrollView==tableList)
    {
        [_timeScroller scrollViewDidScroll];
        
        CGFloat y = scrollView.contentOffset.y;
        // did we drag ?
        if (y<0) {
            //we moved y pixels down, how much latitude is that ?
            double deltaLat = y*deltaLatFor1px;
            //Move the center coordinate accordingly
            CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake(_mapCenter.latitude-deltaLat/2, _mapCenter.longitude);
            map.centerCoordinate = newCenter;
            
            scroll.contentOffset=CGPointMake(scroll.contentOffset.x, _scrollOffset.y+y);
        }
        else if(y>0)
        {
            scroll.contentOffset=_scrollOffset;
        }
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [map setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, MAP_SPAN, MAP_SPAN) animated:false];
    
    float alignPoint=0.0125;
    
    _mapCenter=map.centerCoordinate;
    _mapCenter.latitude+=alignPoint;
    map.centerCoordinate=_mapCenter;
    
    CLLocationCoordinate2D referencePosition = [map convertPoint:CGPointMake(0, 0) toCoordinateFromView:map];
    CLLocationCoordinate2D referencePosition2 = [map convertPoint:CGPointMake(0, 100) toCoordinateFromView:map];
    deltaLatFor1px = (referencePosition2.latitude - referencePosition.latitude)/100;
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

-(void) zoomMap
{
    _tapTop.enabled=false;
    _isZoomedMap=true;
    
    self.view.userInteractionEnabled=false;
    
    scroll.scrollEnabled=true;
    
    map.scrollEnabled=true;
    map.userInteractionEnabled=true;
    map.zoomEnabled=true;
    
    tableList.userInteractionEnabled=false;
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            [scroll setContentOffset:CGPointMake(0, 0) animated:false];
        } completion:^(BOOL finished) {
            scroll.contentInset=UIEdgeInsetsMake(0, 0, -contentView.frame.size.height/2+1, 0);
            self.view.userInteractionEnabled=true;
        }];

    });
    
    NSLog(@"zoomMap %@",@"");
}

-(void) endZoomMap
{
    NSLog(@"endZoomMap");
    
    _tapTop.enabled=true;
    _isZoomedMap=false;
    
    self.view.userInteractionEnabled=false;
    
    scroll.scrollEnabled=false;
    
    map.scrollEnabled=false;
    map.userInteractionEnabled=false;
    map.zoomEnabled=false;
    
    tableList.userInteractionEnabled=true;
    
    double delayInSeconds = 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [UIView animateWithDuration:0.3 animations:^{
            [scroll setContentOffset:_scrollOffset];
        } completion:^(BOOL finished) {
            self.view.userInteractionEnabled=true;
            scroll.contentInset=UIEdgeInsetsZero;
        }];
    });
}

- (IBAction)btnMapTouchUpInside:(id)sender {
    if(_isZoomedMap)
        [self endZoomMap];
    else
        [self zoomMap];
}

- (void)dealloc
{
    scroll.delegate=nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewWillBeginDragging];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewDidEndDecelerating];
}

@end

@implementation ScrollShopList

@end