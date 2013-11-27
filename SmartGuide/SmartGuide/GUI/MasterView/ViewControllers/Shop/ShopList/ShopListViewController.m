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
    
    UITapGestureRecognizer *tapTop=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTop:)];
    _tapTop=tapTop;
    
    [topView addGestureRecognizer:tapTop];
    
    [tableList reloadData];
    [tableList l_v_setS:tableList.contentSize];
    scroll.contentSize=CGSizeMake(scroll.l_v_w, (topView.l_v_h+topView.l_v_y)+tableList.contentSize.height);
    
    [sortView setIcon:[UIImage imageNamed:@"icon_distance.png"] text:@"Khoảng cách"];
    
    [map setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(10, 106), MAP_SPAN, MAP_SPAN) animated:false];
    
    [self refreshDeltaLat];
    
    CLLocationCoordinate2D referencePosition = [map convertPoint:CGPointMake(0, 0) toCoordinateFromView:map];
    CLLocationCoordinate2D referencePosition2 = [map convertPoint:CGPointMake(0, 100) toCoordinateFromView:map];
    deltaLatFor1px = (referencePosition2.latitude - referencePosition.latitude)/100;
}

-(void) refreshScrollSize
{
    scroll.contentSize=CGSizeMake(scroll.l_v_w, (topFrame.size.height+topFrame.origin.y)+tableList.contentSize.height);
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
        
        CGPoint pnt=scrollView.contentOffset;
        
        if (pnt.y<=0) {
            CGPoint pnt=scrollView.contentOffset;
            
            //we moved y pixels down, how much latitude is that ?
            double deltaLat = pnt.y*deltaLatFor1px;
            //Move the center coordinate accordingly
            CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake(_mapCenter.latitude-deltaLat/2, _mapCenter.longitude);
            map.centerCoordinate = newCenter;
        }
    }
    else if(scrollView==tableList)
    {
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [map setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, MAP_SPAN, MAP_SPAN) animated:false];
    
    [self refreshDeltaLat];
}

-(void) refreshDeltaLat
{
    float alignPoint=0.009f;
    
    _mapCenter=map.centerCoordinate;
    _mapCenter.latitude+=alignPoint;
    map.centerCoordinate=_mapCenter;
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
            if(scroll.contentOffset.y>[ShopListCell height]/2)
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
    _tapTop.enabled=false;
    
    scroll.contentSize=CGSizeMake(self.l_v_w, self.l_v_h+1);
    tableList.userInteractionEnabled=false;
    
    map.scrollEnabled=true;
    map.userInteractionEnabled=true;
    map.zoomEnabled=true;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        float height=botFrame.size.height-[ShopListCell height]/2;
        
        [botView l_v_addY:height];
        [topView l_v_addH:height];
    }];
    
    [scroll.panGestureRecognizer addTarget:self action:@selector(scrollPanGes:)];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBot:)];
    
    _tapBot=tap;
    [scroll.panGestureRecognizer requireGestureRecognizerToFail:tap];
    
    [botView addGestureRecognizer:tap];
}

-(void) tapBot:(UITapGestureRecognizer*) tap
{
    [self endZoomMap];
}

-(void) endZoomMap
{
    [scroll.panGestureRecognizer removeTarget:self action:@selector(scrollPanGes:)];
    
    _tapBot.delegate=nil;
    [_tapBot removeTarget:self action:@selector(tapTable:)];
    [botView removeGestureRecognizer:_tapBot];
    _tapBot=nil;
    
    _isZoomedMap=false;
    _tapTop.enabled=true;

    [self refreshScrollSize];
    [scroll setContentOffset:CGPointZero animated:true];
    tableList.userInteractionEnabled=true;
    
    map.scrollEnabled=false;
    map.userInteractionEnabled=false;
    map.zoomEnabled=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        float height=botFrame.size.height-[ShopListCell height]/2;
        
        [botView l_v_addY:-height];
        [topView l_v_addH:-height];
    } completion:^(BOOL finished) {
    }];
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

@end

@implementation ScrollShopList

@end