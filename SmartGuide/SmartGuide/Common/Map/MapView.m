//
//  SGMapView.m
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "MapView.h"
#import "Constant.h"
#import "Utility.h"
#import "ShopList.h"
#import "LocationManager.h"
#import "OperationRouterMap.h"
#import "OperationGeoCoder.h"

@interface MapView()<ASIOperationPostDelegate>
{
    OperationRouterMap *_operationRouter;
    OperationRouterMap *_operationRouterUserLocation;
    OperationGeoCoder *_operationGeoCoder;
}

@end

@implementation MapView
@synthesize routerDelegate,geoCoderDelegate;

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(!_didAddNotification)
    {
        _didAddNotification=true;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

        _lastUserLocation=self.userLocation.coordinate;
        [self performSelectorInBackground:@selector(userLocationChanged) withObject:nil];
    }
}

-(void) userLocationChanged
{
    if(_lastUserLocation.latitude!=self.userLocation.coordinate.latitude && _lastUserLocation.longitude!=self.userLocation.coordinate.longitude)
    {
        NSLog(@"userLocationChanged");
        
        _lastUserLocation=self.userLocation.coordinate;
        [[LocationManager shareInstance] updateLocation:self.userLocation.coordinate];
    }
    
    __weak MapView *wSelf=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(wSelf)
            [wSelf userLocationChanged];
    });
}

-(void) receiveMemoryWarning:(NSNotification*) notification
{
    if(_changingMapType)
        return;
    
    _changingMapType=true;
    self.mapType=MKMapTypeHybrid;
    self.mapType=MKMapTypeStandard;
    _changingMapType=false;
}

-(void)dealloc
{
    if(_operationGeoCoder)
    {
        [_operationGeoCoder clearDelegatesAndCancel];
        _operationGeoCoder=nil;
    }
    
    if(_operationRouter)
    {
        [_operationRouter clearDelegatesAndCancel];
        _operationRouter=nil;
    }
    
    if(_operationRouterUserLocation)
    {
        [_operationRouterUserLocation clearDelegatesAndCancel];
        _operationRouterUserLocation=nil;
    }
    
    if(_didAddNotification)
    {
        _didAddNotification=false;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(userLocationChanged) object:nil];
    
    self.delegate=nil;
    
    DEALLOC_LOG
}

-(void)zoomToLocation:(CLLocationCoordinate2D)location animate:(bool)animate span:(MKCoordinateSpan) span
{
    if(!isVailCLLocationCoordinate2D(location))
        return;
    
    [self setRegion:MKCoordinateRegionMakeWithDistance(location, span.latitudeDelta, span.longitudeDelta) animated:animate];
}

-(void)zoomToUserLocation:(bool)animate span:(double)span
{
    if(!isVailCLLocationCoordinate2D(self.userLocation.coordinate))
        return;
    
    [self setRegion:MKCoordinateRegionMakeWithDistance(self.userLocation.location.coordinate, span, span) animated:animate];
}

-(void)zoomToFitCoordinates:(NSArray *)array animate:(bool)animate
{
    MKMapRect zoomRect = MKMapRectNull;
    for (NSValue *coordinate in array)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate([coordinate MKCoordinateValue]);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    [self setVisibleMapRect:zoomRect animated:animate];
}

-(void)zoomToCoordinates:(NSArray *)array animate:(bool)animate span:(MKCoordinateSpan)span
{
    if(array.count==0)
        return;
    
    CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
    
    for(NSValue *value in array)
    {
        CLLocationCoordinate2D coordinate=[value MKCoordinateValue];
        
        CLLocationCoordinate2D currentLocation=coordinate;
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
    
    double miles = (span.latitudeDelta+span.longitudeDelta)/2 * 0.000621371f;
    double scalingFactor = ABS( (cos(2 * M_PI * region.center.latitude / 360.0) ));
    
    region.span=MKCoordinateSpanMake(miles/69, miles/(scalingFactor*69));
    
	[self setRegion:region animated:animate];
}

-(void)routerFromAnnotation:(id<MKAnnotation>)fromAnno toAnnotation:(id<MKAnnotation>)toAnn
{
    [self cancelRouter];
    
    _operationRouter=[[OperationRouterMap alloc] initWithSource:[fromAnno coordinate] destination:[toAnn coordinate] localeIdentifier:@"vn-vi"];
    _operationRouter.delegate=self;
    
    [_operationRouter addToQueue];
}

-(void)routerToUserLocation:(id<MKAnnotation>)fromAnno
{
    [self cancelUserRouter];
    
    if(!isVailCLLocationCoordinate2D(self.userLocation.coordinate))
        return;
    
    _operationRouterUserLocation=[[OperationRouterMap alloc] initWithSource:self.userLocation.coordinate destination:[fromAnno coordinate] localeIdentifier:@"vn-vi"];
    _operationRouterUserLocation.delegate=self;
    
    [_operationRouterUserLocation addToQueue];
}

-(void)cancelUserRouter
{
    if(_operationRouterUserLocation)
    {
        [_operationRouterUserLocation clearDelegatesAndCancel];
        _operationRouterUserLocation=nil;
    }
}

-(void)cancelRouter
{
    if(_operationRouter)
    {
        [_operationRouter clearDelegatesAndCancel];
        _operationRouter=nil;
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationRouterMap class]])
    {
        NSMutableArray *steps=((OperationRouterMap*)operation).steps;
        if (steps && [steps count] > 0)
        {
            if(operation==_operationRouter)
            {
                if (routeLine) {
                    [self removeOverlay:routeLine];
                    routeLine=nil;
                }
                
                routeLine=[self setRoutePoints:steps];
            }
            else if(operation==_operationRouterUserLocation)
            {
                if(userRouteLine)
                {
                    [self removeOverlay:userRouteLine];
                    userRouteLine=nil;
                }
                
                userRouteLine=[self setRoutePoints:steps];
                
                if(userRouteLine)
                {
                    [self addOverlay:userRouteLine];
                }
            }
        }
        else
        {
            // TODO: show error
            
            if(self.routerDelegate && [self.routerDelegate respondsToSelector:@selector(mapViewRouterFinished:error:)])
            {
                [self.routerDelegate mapViewRouterFinished:self error:[NSError errorWithDomain:@"Steps empty" code:-1 userInfo:nil]];
            }
        }
        
        _operationRouter=nil;
    }
    else if([operation isKindOfClass:[OperationGeoCoder class]])
    {
        OperationGeoCoder *geo=(OperationGeoCoder*)operation;
        
        if(self.geoCoderDelegate && [self.geoCoderDelegate respondsToSelector:@selector(mapViewGeoCoderFinished:address:error:)])
        {
            [self.geoCoderDelegate mapViewGeoCoderFinished:self address:[geo.address mutableCopy] error:geo.error];
        }
        
        _operationGeoCoder=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[OperationRouterMap class]])
    {
        if(self.routerDelegate && [self.routerDelegate respondsToSelector:@selector(mapViewRouterFinished:error:)])
        {
            [self.routerDelegate mapViewRouterFinished:self error:operation.error];
        }
        
        _operationRouter=nil;
    }
    else if([operation isKindOfClass:[OperationGeoCoder class]])
    {
        if(self.geoCoderDelegate && [self.geoCoderDelegate respondsToSelector:@selector(mapViewGeoCoderFinished:address:error:)])
        {
            [self.geoCoderDelegate mapViewGeoCoderFinished:self address:[NSArray array] error:operation.error];
        }
        
        _operationGeoCoder=nil;
    }
}

- (MKPolyline*) setRoutePoints:(NSArray*)locations {
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * locations.count);
	NSUInteger i, count = [locations count];
	for (i = 0; i < count; i++) {
		CLLocation* obj = [locations objectAtIndex:i];
		MKMapPoint point = MKMapPointForCoordinate(obj.coordinate);
		pointArr[i] = point;
	}
    
	MKPolyline *line = [MKPolyline polylineWithPoints:pointArr count:locations.count];
    
	free(pointArr);
    
	[self addOverlay:line];
    
    if(self.routerDelegate && [self.routerDelegate respondsToSelector:@selector(mapViewRouterFinished:error:)])
    {
        [self.routerDelegate mapViewRouterFinished:self error:nil];
    }
    
    return line;
}

-(MKPolylineView *)polylineViewWithOverlay:(id<MKOverlay>)overlay fillColor:(UIColor*) fillColor strokeColor:(UIColor*) strokeColor lineWidth:(double) lineWidth
{
    MKPolylineView* routeLineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    routeLineView.fillColor = fillColor;
    routeLineView.strokeColor = strokeColor;
    routeLineView.lineWidth = lineWidth;
    return routeLineView;
}

-(MKPolylineView *)polylineRoute
{
    if(!routeLine)
        return nil;
    
    return [self polylineViewWithOverlay:routeLine fillColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5f] strokeColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.5f] lineWidth:4];
}

-(MKPolylineView *)polylineRouteUser
{
    if(!userRouteLine)
        return nil;
    
    return [self polylineViewWithOverlay:userRouteLine fillColor:[UIColor colorWithRed:75.f/255 green:121.f/255 blue:213.f/255 alpha:0.6f] strokeColor:[UIColor colorWithRed:75.f/255 green:121.f/255 blue:213.f/255 alpha:0.6f] lineWidth:8];
}

-(void)addressAtCoordinate:(CLLocationCoordinate2D)coordinate withDelegate:(id<MapViewGeoCoderDelegate>)geoDelegate
{
    if(_operationGeoCoder)
    {
        [_operationGeoCoder clearDelegatesAndCancel];
        _operationGeoCoder=nil;
    }
    
    self.geoCoderDelegate=geoDelegate;
    
    _operationGeoCoder=[[OperationGeoCoder alloc] initWithLat:coordinate.latitude lng:coordinate.longitude language:GEOCODER_LANGUAGE_VN];
    _operationGeoCoder.delegate=self;
    
    [_operationGeoCoder addToQueue];
    
    if(self.geoCoderDelegate && [self.geoCoderDelegate respondsToSelector:@selector(mapViewGeoCoderStarted:)])
        [self.geoCoderDelegate mapViewGeoCoderStarted:self];
}

-(MKPolyline *)polyRoute
{
    return routeLine;
}

-(MKPolyline *)polyUser
{
    return userRouteLine;
}

@end

@implementation MapView(SupportShop)

-(void)addShopLists:(NSArray *)shops
{
    NSMutableArray *array=[NSMutableArray array];
    
    for(id<MKAnnotation> ann in self.annotations)
    {
        if([ann isKindOfClass:[ShopList class]])
        {
            [array addObject:ann];
        }
    }
    
    if(array.count>0)
        [self removeAnnotations:array];
    
    [self addMoreShopLists:shops zoom:true];
}

-(void)addMoreShopLists:(NSArray *)shops zoom:(bool) isZoomed
{
    NSMutableArray *coordinates=[NSMutableArray array];
    for(ShopList *shop in shops)
    {
        [self addAnnotation:shop];
        
        [coordinates addObject:[NSValue valueWithMKCoordinate:shop.coordinate]];
    }
    
    if(isVailCLLocationCoordinate2D(self.userLocation.coordinate))
        [coordinates addObject:[NSValue valueWithMKCoordinate:self.userLocation.coordinate]];
    
    if(isZoomed)
        [self showAnnotations:shops animated:true];
}

-(void)showAnnotations:(NSArray *)annotations animated:(BOOL)animated
{
    if(NSFoundationVersionNumber>NSFoundationVersionNumber_iOS_6_1)
        [super showAnnotations:annotations animated:animated];
    else
    {
        NSMutableArray *array=[NSMutableArray array];
        for(id<MKAnnotation> ann in annotations)
        {
            [array addObject:[NSValue valueWithMKCoordinate:[ann coordinate]]];
        }
        [self zoomToFitCoordinates:array animate:animated];
    }
}

-(void)addMoreShopLists:(NSArray *)shops
{
    [self addMoreShopLists:shops zoom:false];
}

-(void)zoomShopList:(ShopList *)shoplist
{
    if(!isVailCLLocationCoordinate2D([shoplist coordinate]))
        return;
    
    [self setRegion:MKCoordinateRegionMake(shoplist.coordinate, self.region.span) animated:true];
    
    //    [self zoomToLocation:[shoplist coordinate] animate:true span:self.region.spasn];
}

@end