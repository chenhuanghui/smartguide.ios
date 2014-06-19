//
//  SGMapView.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>

@class MapView;

@protocol MapViewRouterDelegate <NSObject>

@optional
-(void) mapViewRouterStarted:(MapView*) sgMap;
-(void) mapViewRouterFinished:(MapView*) sgMap error:(NSError*) error;

@end

@protocol MapViewGeoCoderDelegate <NSObject>

@optional
-(void) mapViewGeoCoderStarted:(MapView*) sgMap;
-(void) mapViewGeoCoderFinished:(MapView*) sgMap address:(NSArray*) address error:(NSError*) error;

@end

@interface MapView : MKMapView
{
    __weak MKPolyline *routeLine;
    __weak MKPolyline *userRouteLine;
    
    bool _didAddObs;
    bool _didAddNotification;
    bool _changingMapType;
    
    CLLocationCoordinate2D _lastUserLocation;
}

-(MKPolylineView *)polylineViewWithOverlay:(id<MKOverlay>)overlay fillColor:(UIColor*) fillColor strokeColor:(UIColor*) strokeColor lineWidth:(double) lineWidth;
-(MKPolylineView*) polylineRoute;
-(MKPolylineView*) polylineRouteUser;

-(MKPolyline*) polyRoute;
-(MKPolyline*) polyUser;

-(void) routerFromAnnotation:(id<MKAnnotation>) fromAnno toAnnotation:(id<MKAnnotation>) toAnn;
-(void) routerToUserLocation:(id<MKAnnotation>) fromAnno;
-(void) cancelRouter;

-(void) zoomToLocation:(CLLocationCoordinate2D) location animate:(bool) animate span:(MKCoordinateSpan) span;
-(void) zoomToUserLocation:(bool) animate span:(double) span;
-(void) zoomToCoordinates:(NSArray*) array animate:(bool) animate span:(MKCoordinateSpan) span;
-(void) zoomToFitCoordinates:(NSArray*) array animate:(bool) animate;

//-(void) addressAtCoordinate:(CLLocationCoordinate2D) coordinate withDelegate:(id<MapViewGeoCoderDelegate>) delegate;

@property (nonatomic, weak) id<MapViewRouterDelegate> routerDelegate;
@property (nonatomic, weak) id<MapViewGeoCoderDelegate> geoCoderDelegate;

@end

@class ShopList;

@interface MapView(SupportShop)

-(void) addShopLists:(NSArray*) shops;
-(void) addMoreShopLists:(NSArray*) shops;
-(void) zoomShopList:(ShopList*) shoplist;

@end