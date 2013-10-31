//
//  SGMapViewController.h
//  SmartGuide
//
//  Created by MacMini on 26/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MapKit/MapKit.h>

@protocol SGMapViewDelegate <NSObject>

-(void) SGMapViewSelectedShop;

@end

@interface SGMapViewController : UIViewController<MKMapViewDelegate>
{
    __strong IBOutlet MKMapView *mapShops;
    __weak IBOutlet UIView *ray;
    __weak IBOutlet UIView *borderMap;
    __weak IBOutlet UIView *containMap;
}

-(void) addMap;
-(void) removeMap;
@property (nonatomic, assign) id<SGMapViewDelegate> delegate;

@end
