//
//  SGMapView.h
//  SmartGuide
//
//  Created by MacMini on 17/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "OperationRouterMap.h"
#import "OperationGeoCoder.h"

@class SGMapView;

@protocol SGMapViewRouterDelegate <NSObject>

@optional
-(void) mapViewRouterStarted:(SGMapView*) sgMap;
-(void) mapViewRouterFinished:(SGMapView*) sgMap error:(NSError*) error;

@end

@protocol SGMapViewGeoCoderDelegate <NSObject>

@optional
-(void) mapViewGeoCoderStarted:(SGMapView*) sgMap;
-(void) mapViewGeoCoderFinished:(SGMapView*) sgMap address:(NSArray*) address error:(NSError*) error;

@end

@interface SGMapView : MKMapView<OperationURLDelegate>
{
    OperationRouterMap *_operationRouter;
    OperationRouterMap *_operationRouterUserLocation;
    OperationGeoCoder *_operationGeoCoder;
    __weak MKPolyline *routeLine;
    __weak MKPolyline *userRouteLine;
    
    bool _didAddObs;
    bool _didAddNotification;
    bool _changingMapType;
}

-(MKPolylineView *)polylineViewWithOverlay:(id<MKOverlay>)overlay fillColor:(UIColor*) fillColor strokeColor:(UIColor*) strokeColor lineWidth:(double) lineWidth;
-(MKPolylineView*) polylineRoute;
-(MKPolylineView*) polylineRouteUser;

-(MKPolyline*) polyRoute;
-(MKPolyline*) polyUser;

-(void) routerFromAnnotation:(id<MKAnnotation>) fromAnno toAnnotation:(id<MKAnnotation>) toAnn;
-(void) routerToUserLocation:(id<MKAnnotation>) fromAnno;
-(void) cancelRouter;

-(void) zoomToLocation:(CLLocationCoordinate2D) location animate:(bool) animate span:(double) span;
-(void) zoomToUserLocation:(bool) animate span:(double) span;
-(void) zoomToCoordinates:(NSArray*) array animate:(bool) animate span:(double) span;

-(void) addressAtCoordinate:(CLLocationCoordinate2D) coordinate withDelegate:(id<SGMapViewGeoCoderDelegate>) delegate;

@property (nonatomic, weak) id<SGMapViewRouterDelegate> routerDelegate;
@property (nonatomic, weak) id<SGMapViewGeoCoderDelegate> geoCoderDelegate;

@end
