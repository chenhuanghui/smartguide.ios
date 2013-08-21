//
//  ShopLocation.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopLocation.h"
#import "RootViewController.h"
#import "UserAnnotationView.h"

@interface ShopLocation()

@property(nonatomic, strong) id<MKAnnotation> source;
@property(nonatomic, strong) id<MKAnnotation> destination;
@property(nonatomic, retain) MKPolyline* routeLine;

@end

@implementation ShopLocation
@synthesize isProcessedData,handler;
@synthesize source,destination,routeLine;

-(ShopLocation *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopLocation" owner:nil options:nil] objectAtIndex:0];
    
    mapContaint.delegate=self;
    
    [self setShop:shop];
    
    return self;
}

-(void) makeMapFullscreen
{
    mapContaint.userInteractionEnabled=false;
    map.userInteractionEnabled=true;
    map.scrollEnabled=true;
    map.zoomEnabled=true;
    
    rootView=[[RootViewController shareInstance] giveARootView];
    rootView.backgroundColor=[UIColor clearColor];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    btn.frame=CGRectMake(7, 10, 23, 20);
    btn.tag=1;
    
    [btn addTarget:self action:@selector(btnBackTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    [rootView addSubview:btn];
    
    [map removeFromSuperview];
    
    [rootView addSubview:map];
    CGPoint pnt=map.center;
    pnt=[self convertPoint:pnt fromView:mapContaint];
    pnt=[rootView convertPoint:pnt fromView:self];
    map.center=pnt;
    
    [UIView animateWithDuration:DURATION_SHOW_MAP animations:^{
//        NSLog(@"%@",NSStringFromCGRect(map.frame));
        map.frame=CGRectMake(0, 37, rootView.frame.size.width, rootView.frame.size.height-37*2);
        rootView.backgroundColor=[UIColor blackColor];
    }];
}

-(void) makeMapNormal
{
    NSLog(@"self %@",self);
    
    [UIView animateWithDuration:DURATION_SHOW_MAP animations:^{

        //vị trí được lấy từ animation show map fullscreen (line 65)
        map.frame=CGRectMake(17, 189, 285, 228);
        rootView.backgroundColor=[UIColor clearColor];
        [rootView viewWithTag:1].alpha=0;
    } completion:^(BOOL finished) {
        [[rootView viewWithTag:1] removeFromSuperview];
        
        [map removeFromSuperview];
        CGRect rect=mapContaint.frame;
        rect.origin=CGPointZero;
        map.frame=rect;
        [mapContaint addSubview:map];

        map.userInteractionEnabled=false;
        map.scrollEnabled=false;
        map.zoomEnabled=false;
        mapContaint.userInteractionEnabled=true;
        
        [[RootViewController shareInstance] removeRootView:rootView];
        rootView=nil;
    }];
}

-(void)viewTouchBegan:(UIView *)touchView touches:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self makeMapFullscreen];
}

-(void)setShop:(Shop *)shop
{
    if(!shop)
        return;
    
    if(map)
    {
        map.userInteractionEnabled=false;
        map.scrollEnabled=false;
        map.zoomEnabled=false;
    }
    
    mapContaint.userInteractionEnabled=true;
    
    _shop=shop;
    shop.showPinType=SHOP_SHOW_NAME;
}

-(void)processFirstDataBackground:(NSMutableArray *)firstData
{
    if(map)
    {
        self.destination=_shop;
        [map addAnnotation:_shop];
        [self calculateDirections];
    }
}

-(void)cancel
{
    
}

-(void)reset
{
    
    [map removeFromSuperview];
    map=nil;
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //    if([view isKindOfClass:[ShopAnnotationView class]])
    //    {
    //        ShopAnnotationView *shopAnn=(ShopAnnotationView*)view;
    //        [shopAnn showShop];
    //
    //        if(!self.destination || self.destination!=shopAnn.shop)
    //        {
    //            self.destination=shopAnn.shop;
    //
    //            [self calculateDirections];
    //        }
    //    }
    //    else if([view isKindOfClass:[UserAnnotationView class]])
    //    {
    //
    //    }
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    //    if([view isKindOfClass:[ShopAnnotationView class]])
    //    {
    //        ShopAnnotationView *shopAnn=(ShopAnnotationView*)view;
    //        shopAnn.delegate=nil;
    //        [shopAnn hideShop];
    //    }
    //    else if([view isKindOfClass:[UserAnnotationView class]])
    //    {
    //
    //    }
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[Shop class]])
    {
        ShopAnnotationView *shopAnn= (ShopAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:[ShopAnnotationView reuseIdentifier]];
        if(!shopAnn)
            shopAnn=[[ShopAnnotationView alloc] initWithShop:annotation];
        else
            [shopAnn setShop:annotation];
        
        [shopAnn showShopName];
        
        return shopAnn;
    }
    else if([annotation isKindOfClass:[User class]] || [annotation isKindOfClass:[MKUserLocation class]])
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
    
    
    //    region=MKCoordinateRegionMakeWithDistance(location, MAP_SPAN, MAP_SPAN);
	[map setRegion:region animated:YES];
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

-(void) operationSuccess:(AFHTTPRequestOperation*) operation responseObject:(id) responseObject
{
    isCalculatingDirection=false;
    @try {
        NSData* data = operation.responseData;
        NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // TODO: better parsing. Regular expression?
        
        NSInteger a = [responseString indexOf:@"points:\"" from:0];
        NSInteger b = [responseString indexOf:@"\",levels:\"" from:a] - 10;
        
        //        NSInteger c = [responseString indexOf:@"tooltipHtml:\"" from:0];
        //        NSInteger d = [responseString indexOf:@"(" from:c];
        //        NSInteger e = [responseString indexOf:@")\"" from:d] - 2;
        
        //        NSString* info = [[responseString substringFrom:d to:e] stringByReplacingOccurrencesOfString:@"\\x26#160;" withString:@""];
        
        NSString* encodedPoints = [responseString substringFrom:a to:b];
        NSArray* steps = [Utility decodePolyLine:[encodedPoints mutableCopy]];
        if (steps && [steps count] > 0) {
            [self setRoutePoints:steps];
            //} else if (!steps) {
            //	[self showError:@"No se pudo calcular la ruta"];
        } else {
            // TODO: show error
        }
    }
    @catch (NSException * e) {
        // TODO: show error
    }
}

-(void) operationFailure:(AFHTTPRequestOperation*) operation error:(NSError*) error
{
    isCalculatingDirection=false;
}

- (void)calculateDirections {
    if(isCalculatingDirection || !self.source || !self.destination)
        return;
    
    [map showLoadingWithTitle:nil];
    
    isCalculatingDirection=true;
    
	CLLocationCoordinate2D f = source.coordinate;
	CLLocationCoordinate2D t = destination.coordinate;
	NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
    
	NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@&hl=%@", saddr, daddr, [[NSLocale currentLocale] localeIdentifier]];
    // by car:
    // urlString = [urlString stringByAppendingFormat:@"&dirflg=w"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    __block AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [map removeLoading];
         [self operationSuccess:operation responseObject:responseObject];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [map  removeLoading];
         [self operationFailure:operation error:error];
     }];
    
    [operation start];
}

-(void) updateMapWithUserLocation:(MKUserLocation*) userLocation
{
    if(![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(updateMap) withObject:nil waitUntilDone:false];
        return;
    }
    
    if(self.destination && ![map.annotations containsObject:self.destination])
        [map addAnnotation:self.destination];
    
    
    if(userLocation && userLocation.coordinate.latitude>0 && userLocation.coordinate.longitude>0)
        self.source=userLocation;
    
    if(self.source)
        [self calculateDirections];
    else
    {
        [map setRegion:MKCoordinateRegionMakeWithDistance(self.destination.coordinate, MAP_SPAN, MAP_SPAN)];
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(!CLLocationCoordinate2DIsValid(userLocation.coordinate) || (userLocation.coordinate.longitude==0 && userLocation.coordinate.latitude==0))
        return;
    
    [DataManager shareInstance].currentUser.location=[userLocation location].coordinate;
    
    [self updateMapWithUserLocation:userLocation];
}

-(void) btnBackTouchUpInside:(UIButton*) btn
{
    [self makeMapNormal];
}

-(UIView *)mapContaint
{
    return mapContaint;
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(!map)
    {
        //neu nhu shopdetail chua load ma vao thi se bi crash do shop nil
        CGRect rect=mapContaint.frame;
        rect.origin=CGPointZero;
        
        map=[[MKMapView alloc] initWithFrame:rect];
        [mapContaint addSubview:map];
        
        map.delegate=self;
        map.showsUserLocation=true;
        
        if(_shop)
        {
            self.destination=_shop;
            [map addAnnotation:_shop];
            [self calculateDirections];
        }
        
        map.userInteractionEnabled=false;
        map.scrollEnabled=false;
        map.zoomEnabled=false;
    }
}

@end