//
//  ShopMapViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopMapViewController.h"
#import "ShopPinView.h"

@interface ShopMapViewController ()<MapViewGeoCoderDelegate,ShopPinDelegate, MKMapViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation ShopMapViewController

-(ShopMapViewController *)initWithShop:(Shop *)shop
{
    self = [super initWithNibName:@"ShopMapViewController" bundle:nil];
    if (self) {
        // Custom initialization
        
        _shop=shop;
    }
    return self;
}

-(void)shopPinDealloc:(ShopPinView *)pin
{
    [pin removeObserver:self forKeyPath:@"selected"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        map.showsPointsOfInterest=false;
    if([map respondsToSelector:@selector(setShowsBuildings:)])
        map.showsBuildings=false;
    
    [map addAnnotation:_shop];
    
    if(isVailCLLocationCoordinate2D(map.userLocation.coordinate))
    {
        if(!_didRouterUserLocation)
        {
            _didRouterUserLocation=true;
            
            [map routerToUserLocation:_shop];
        }
        
        [map showAnnotations:@[_shop,map.userLocation] animated:false];
    }
    else
    {
        [map zoomToLocation:_shop.coordinate animate:false span:MKCoordinateSpanMake(MAP_SPAN, MAP_SPAN)];
    }
}

-(NSArray *)registerNotifications
{
    return @[UIApplicationDidBecomeActiveNotification];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
        _didRouterUserLocation=false;
    }
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay==map.polyRoute)
        return [map polylineRoute];
    else if(overlay==map.polyUser)
        return [map polylineRouteUser];
    
    return nil;
}

-(void)dealloc
{
    map.delegate=nil;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[Shop class]])
    {
        ShopPinView *pin=(ShopPinView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"shopPin"];
        
        if(!pin)
        {
            pin=[[ShopPinView alloc] initWithAnnotation:_shop reuseIdentifier:@"shopPin"];
            pin.animatesDrop=false;
        }
        
        pin.delegate=self;
        pin.image=[[ImageManager sharedInstance] shopPinWithType:_shop.enumShopType];
        
        [pin addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
        [pin showInfoWithShopUser:_shop];
        
        return pin;
    }
    
    return nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([object isKindOfClass:[ShopPinView class]])
    {
        ShopPinView *pin=object;
        
        if(!pin.selected)
            [pin setSelected:true];
        
        [pin showInfoWithShopUser:_shop];
    }
}

-(void)shopPinTouched:(ShopPinView *)pin
{
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(isVailCLLocationCoordinate2D(userLocation.coordinate))
    {
        if(!_didRouterUserLocation)
        {
            _didRouterUserLocation=true;
            
            [map routerToUserLocation:_shop];
            
            [map showAnnotations:@[_shop,map.userLocation] animated:true];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end