//
//  DirectionShopViewController.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "DirectionObjectViewController.h"
#import "Utility.h"
#import "AFHTTPRequestOperation.h"
#import "ShopAnnotationView.h"
#import "UserAnnotationView.h"
#import "DataManager.h"
#import "LocationManager.h"
#import "NSBKeyframeAnimation.h"

@interface DirectionObjectViewController ()

@property(nonatomic, strong) id<MKAnnotation> source;
@property(nonatomic, strong) id<MKAnnotation> destination;
@property(nonatomic, strong) MKPolyline* routeLine;

@end

@implementation DirectionObjectViewController

@synthesize routeLine;
@synthesize source;
@synthesize destination;
@synthesize delegate;

-(DirectionObjectViewController *)initDirectionObject
{
    self=[super init];
    
    return self;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if([view isKindOfClass:[ShopAnnotationView class]])
    {
        ShopAnnotationView *shopAnn=(ShopAnnotationView*)view;
        shopAnn.delegate=self;
        [shopAnn showShop];
        
        if(!self.destination || self.destination!=shopAnn.shop)
        {
            self.destination=shopAnn.shop;
            
            [self calculateDirections];
        }
    }
    else if([view isKindOfClass:[UserAnnotationView class]])
    {
        
    }
}

-(void)shopAnnotationDetail:(Shop *)shop
{
    if(delegate)
    {
        for(MKAnnotationView *ann in map.selectedAnnotations)
        {
            if([ann isKindOfClass:[ShopAnnotationView class]])
            {
                [((ShopAnnotationView*)ann) hideShop];
            }
        }
        
        [delegate directionObjectDetail:shop];
    }
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if([view isKindOfClass:[ShopAnnotationView class]])
    {
        ShopAnnotationView *shopAnn=(ShopAnnotationView*)view;
        [shopAnn hidePin];
    }
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[Shop class]])
    {
        ShopAnnotationView *shopAnn= (ShopAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:[ShopAnnotationView reuseIdentifier]];
        if(!shopAnn)
            shopAnn=[[ShopAnnotationView alloc] initWithShop:annotation];
        else
            [shopAnn setShop:annotation];
        
        return shopAnn;
    }
    
    if([annotation isKindOfClass:[User class]] || [annotation isKindOfClass:[MKUserLocation class]])
    {
        if([annotation isKindOfClass:[MKUserLocation class]])
        {
            [DataManager shareInstance].currentUser.location=[annotation coordinate];
        }
        
        UserAnnotationView *userAnn=(UserAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:[UserAnnotationView reuseIdentifier]];
        if(!userAnn)
            userAnn=[[UserAnnotationView alloc] initWithUserLocation:annotation];
        else
            [userAnn setUserLocation:annotation];
        
        if(!self.source)
        {
            self.source=annotation;
            [self calculateDirections];
        }
        
        return userAnn;
    }
    
    return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay {
	MKPolylineView* routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
	routeLineView.fillColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.5f];
	routeLineView.strokeColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.5f];
	routeLineView.lineWidth = 4;
	return routeLineView;
}

#pragma mark -
#pragma mark Directions

- (void) setRoutePoints:(NSArray*)locations {
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * locations.count);
	NSUInteger i, count = [locations count];
	for (i = 0; i < count; i++) {
		CLLocation* obj = [locations objectAtIndex:i];
		MKMapPoint point = MKMapPointForCoordinate(obj.coordinate);
		pointArr[i] = point;
	}
    
	if (routeLine) {
		[map removeOverlay:routeLine];
	}
    
	self.routeLine = [MKPolyline polylineWithPoints:pointArr count:locations.count];
	free(pointArr);
    
	[map addOverlay:routeLine];
    
	CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
    
	for (int i = 0; i < locations.count; i++) {
		CLLocation *currentLocation = [locations objectAtIndex:i];
		if(currentLocation.coordinate.latitude > maxLat) {
			maxLat = currentLocation.coordinate.latitude;
		}
		if(currentLocation.coordinate.latitude < minLat) {
			minLat = currentLocation.coordinate.latitude;
		}
		if(currentLocation.coordinate.longitude > maxLon) {
			maxLon = currentLocation.coordinate.longitude;
		}
		if(currentLocation.coordinate.longitude < minLon) {
			minLon = currentLocation.coordinate.longitude;
		}
	}
    
	MKCoordinateRegion region;
    //    CLLocationCoordinate2D location=CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
    
    //[self zoomMap:region];
}

- (void)drawRoute:(NSMutableDictionary *)response
{
	NSMutableArray* coordinates = [response objectForKey:@"coordinates"];
    
	NSMutableArray* aux = [[NSMutableArray alloc] initWithCapacity:[coordinates count]];
	for (NSMutableDictionary* dict in coordinates)
	{
		NSNumber* lat = [dict objectForKey:@"lat"];
		NSNumber* lon = [dict objectForKey:@"lon"];
        
		CLLocation* location = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]];
		[aux addObject:location];
	}
    
	[self setRoutePoints:aux];
}

- (void)calculateDirections {
    if(isCalculatingDirection || !self.source || !self.destination)
        return;
    
    if(operationRouter)
    {
        [operationRouter cancel];
        operationRouter=nil;
    }
    
    isCalculatingDirection=true;
    
    operationRouter = [[OperationRouterMap alloc] initWithSource:source.coordinate  destination:destination.coordinate localeIdentifier:[[NSLocale currentLocale] localeIdentifier]];
    operationRouter.delegate=self;
    
    [operationRouter start];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    isCalculatingDirection=false;
    
    NSMutableArray *steps=((OperationRouterMap*)operation).steps;
    if (steps && [steps count] > 0) {
        [self setRoutePoints:steps];
    } else {
        // TODO: show error
    }
    
    operationRouter=nil;
}

-(void)operationURLFailed:(OperationURL *)operation
{
    isCalculatingDirection=false;
    operationRouter=nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    map=[MapView shareInstance];
    map.delegate=self;
    map.showsUserLocation=true;

    CGRect rect=self.view.frame;
    rect.origin=CGPointZero;
    map.frame=rect;
    [self.view addSubview:map];
}

-(void) willAppear
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackingLocationPermission:) name:NOTIFICATION_LOCATION_AUTHORIZE_CHANGED object:nil];
    
    [[LocationManager shareInstance] startTrackingLocationAuthorize];
    [self trackingLocationPermission:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void) trackingLocationPermission:(NSNotification*) notification
{
    if(![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(trackingLocationPermission:) withObject:nil waitUntilDone:false];
        return;
    }
    if(![LocationManager shareInstance].isLocationServicesEnabled)
    {
        [self.view showLoadingWithTitle:localizeLocationServicesDisabled()];
    }
    else
    {
        if([LocationManager shareInstance].isAuthorizeLocation)
        {
            //            [[GUIManager shareInstance] hideNotificationWithIdentity:self];
            map.showsUserLocation=false;
            map.showsUserLocation=true;
        }
        else
        {
            //            [[GUIManager shareInstance] showWarningNotificationWithIcon:nil content:localizeLocationAuthorationDenied() identity:self closedWhenTouch:true];
        }
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(!isVailCLLocationCoordinate2D(userLocation.coordinate))
        return;
    
    if(!isVailCLLocationCoordinate2D([DataManager shareInstance].currentUser.location) || !_isZoomedUserLocation)
    {
        _isZoomedUserLocation=true;
        [self zoomMap:MKCoordinateRegionMakeWithDistance(userLocation.coordinate, MAP_SPAN, MAP_SPAN) animated:true];
    }
    
    [DataManager shareInstance].currentUser.location=[userLocation location].coordinate;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    return;
    float loop=0.3f;
    
    for(UIView *aV in views)
    {
        if([aV isKindOfClass:[UserAnnotationView class]])
            continue;
        
        if(loop>1.f)
            loop=1.f;
        
        CGRect endFrame = aV.frame;
        
        NSBKeyframeAnimation *animation=[NSBKeyframeAnimation animationWithKeyPath:@"position.y" duration:loop startValue:endFrame.origin.y-130 endValue:endFrame.origin.y function:NSBKeyframeAnimationFunctionEaseInOutQuad];
        
        [aV.layer setValue:@(endFrame.origin.y) forKeyPath:@"position.y"];
        [aV.layer addAnimation:animation forKey:@"position.y"];
        
        loop+=0.1f;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[LocationManager shareInstance] stopTrackingLocationAuthorize];
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationPortrait==interfaceOrientation;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma marik - Bussiness login

-(void)setFrame:(CGRect)rect
{
    self.view.frame=rect;
    
    rect.origin=CGPointZero;
    map.frame=rect;
}

-(void) loadWithShops:(NSArray *)shops
{
    _isZoomedUserLocation=false;
    map.delegate=self;
    
    [map removeAnnotations:map.annotations];
    map.showsUserLocation=false;
    map.showsUserLocation=true;
    
    if (routeLine) {
		[map removeOverlay:routeLine];
        self.routeLine=nil;
	}
    
    [map removeOverlays:map.overlays];
    
    CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
    
    for(Shop *shop in shops)
    {
        shop.showPinType=SHOP_SHOW_DETAIL;
        [self addShopToMap:shop];
        
        CLLocationCoordinate2D currentLocation=shop.coordinate;
        if(currentLocation.latitude>maxLat)
            maxLat=currentLocation.latitude;
        if(currentLocation.latitude<minLat)
            minLat=currentLocation.latitude;
        if(currentLocation.longitude>maxLon)
            maxLon=currentLocation.longitude;
        if(currentLocation.longitude<minLon)
            minLon=currentLocation.longitude;
    }
    
	MKCoordinateRegion region;
    //    CLLocationCoordinate2D location=CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
    
    [self zoomMap:region animated:false];
}

-(void) zoomMap:(MKCoordinateRegion) region animated:(bool) animate
{
    if(isVailCLLocationCoordinate2D(map.userLocation.coordinate))
        region.center=map.userLocation.coordinate;
    
    double miles = MAP_SPAN*0.000621371f;
    double scalingFactor = ABS( (cos(2 * M_PI * region.center.latitude / 360.0) ));

    region.span=MKCoordinateSpanMake(miles/69, miles/(scalingFactor*69));
    
	[map setRegion:region animated:animate];
}

-(void)addShops:(NSArray *)shops
{
    for(Shop *shop in shops)
    {
        [self addShopToMap:shop];
    }
}

-(void) addShopToMap:(Shop*) shop
{
    [map addAnnotation:shop];
}

-(void) routerToShop:(Shop*) shop
{
    self.destination=shop;
    
    [self calculateDirections];
}

-(MapView *)mapView
{
    return map;
}

-(void)removeShops:(NSArray *)shops
{
    if(shops.count==0)
        return;
    
    [map removeAnnotations:shops];
    
    if(self.destination && [shops containsObject:self.destination])
    {
        if(self.routeLine)
        {
            [map removeOverlay:self.routeLine];
            self.routeLine=nil;
        }
    }
}

@end

@implementation DirectionView



@end