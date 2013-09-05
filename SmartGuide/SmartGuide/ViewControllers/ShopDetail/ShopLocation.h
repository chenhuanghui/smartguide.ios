//
//  ShopLocation.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopDetailViewController.h"
#import "TouchView.h"
#import "LocationManager.h"

@interface ShopLocation : UIView<ShopViewHandle,TouchViewDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate>
{
    __weak IBOutlet TouchView *mapContaint;
    __weak Shop *_shop;
    MKMapView *map;
    bool isCalculatingDirection;
    UIView *rootView;
}

-(ShopLocation*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

-(UIView*) mapContaint;

- (IBAction)btnFullscreenTouchUpInside:(id)sender;

@end