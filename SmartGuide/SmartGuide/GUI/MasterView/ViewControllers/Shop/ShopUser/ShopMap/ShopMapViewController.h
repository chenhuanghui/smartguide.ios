//
//  ShopMapViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGMapView.h"
#import "Shop.h"

@class TapAnnoun;

@interface ShopMapViewController : SGViewController<MKMapViewDelegate,UIGestureRecognizerDelegate>
{
    __weak IBOutlet SGMapView *map;
    
    __weak Shop* _shop;
    
    __weak TapAnnoun *_tapAnn;
    
    __weak IBOutlet UIButton *btnPinDrag;
    __weak IBOutlet UIButton *btnPinInvs;
    bool _didRouterUserLocation;
}

-(ShopMapViewController*) initWithShop:(Shop*) shop;

@end

@interface TapAnnoun : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
}

-(void) setTitle:(NSString*) title;

@end