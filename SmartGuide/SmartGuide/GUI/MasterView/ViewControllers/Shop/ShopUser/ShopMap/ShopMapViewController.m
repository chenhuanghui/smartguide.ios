//
//  ShopMapViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopMapViewController.h"
#import "DDAnnotationView.h"

@interface ShopMapViewController ()<SGMapViewGeoCoderDelegate>

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([map respondsToSelector:@selector(setShowsPointsOfInterest:)])
        map.showsPointsOfInterest=false;
    if([map respondsToSelector:@selector(setShowsBuildings:)])
        map.showsBuildings=false;
    
    [map addAnnotation:_shop];
    
    [map zoomToLocation:_shop.coordinate animate:false span:MAP_SPAN];
    
    if(isVailCLLocationCoordinate2D(map.userLocation.coordinate))
    {
        if(!_didRouterUserLocation)
        {
            _didRouterUserLocation=true;
            
            [map routerToUserLocation:_shop];
        }
    }
}

-(void) addTapAnnAtPoint:(CGPoint) pnt
{
    CLLocationCoordinate2D touchMapCoordinate =
    [map convertPoint:pnt toCoordinateFromView:map];
    
    if(_tapAnn)
    {
        [map removeAnnotation:_tapAnn];
        _tapAnn=nil;
    }
    
    TapAnnoun *annot = [TapAnnoun new];
    annot.coordinate = touchMapCoordinate;
    [map addAnnotation:annot];
    
    _tapAnn=annot;
    
    [map routerFromAnnotation:annot toAnnotation:_shop];
    
    [map addressAtCoordinate:[annot coordinate] withDelegate:self];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if(overlay==map.polyRoute)
        return [map polylineRoute];
    else if(overlay==map.polyUser)
    {
        return [map polylineRouteUser];
    }
    
    return nil;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[TapAnnoun class]])
    {
        return [DDAnnotationView annotationViewWithAnnotation:_shop reuseIdentifier:nil mapView:map];
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(isVailCLLocationCoordinate2D(userLocation.coordinate))
    {
        if(!_didRouterUserLocation)
        {
            _didRouterUserLocation=true;
            
            [map routerToUserLocation:_shop];
        }
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if(newState==MKAnnotationViewDragStateEnding)
    {
        [map routerFromAnnotation:view.annotation toAnnotation:_shop];
        [map addressAtCoordinate:[view.annotation coordinate] withDelegate:self];
    }
}

-(void)mapViewGeoCoderFinished:(SGMapView *)sgMap address:(NSArray *)address error:(NSError *)error
{
    if(address.count>0)
    {
        _tapAnn.title=address[0];
    }
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for(id<MKAnnotation> ann in views)
    {
        if([ann isKindOfClass:[DDAnnotationView class]])
        {
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) btnLocationTouchUpInside:(id)sender
{
}

-(IBAction) btnPinDragInside:(id)sender withEvent:(UIEvent*) event
{
    btnPinInvs.hidden=false;
    
    UITouch *touch=[[event allTouches] anyObject];
    
    [btnPinDrag setCenter:[touch locationInView:self.view]];
}

-(IBAction) btnPinTouchDown:(id)sender withEvent:(UIEvent*) event
{
    
}

-(IBAction) btnPinTouchUpInside:(id)sender withEvent:(UIEvent*) event
{
    UITouch *touch=[[event allTouches] anyObject];
    btnPinDrag.hidden=true;
    
    [self addTapAnnAtPoint:[touch locationInView:map]];
}

@end

@implementation TapAnnoun
@synthesize title, coordinate, subtitle;

- (id)init
{
    self = [super init];
    if (self) {
        _title=@"Custom location";
    }
    return self;
}

-(NSString *)title
{
    return _title;
}

-(NSString *)subtitle
{
    return @"";
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate=newCoordinate;
}

-(CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

-(void)setTitle:(NSString *)xtitle
{
    _title=[xtitle copy];
}

@end