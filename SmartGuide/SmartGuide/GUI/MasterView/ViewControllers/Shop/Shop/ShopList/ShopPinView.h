//
//  ShopPinView.h
//  SmartGuide
//
//  Created by MacMini on 01/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ShopPinInfoView.h"
#import "ShopList.h"

@class ShopPinView;

@protocol ShopPinDelegate <NSObject>

-(void) shopPinTouched:(ShopPinView*) pin;

@end

@interface ShopPinView : MKPinAnnotationView
{
    __weak ShopPinInfoView *_pinInfo;
    __weak ShopList *_shop;
}

-(void) showInfoWithShop:(ShopList*) shop;
-(void) hideInfo;
-(ShopList*) shop;

@property (nonatomic, weak) id<ShopPinDelegate> delegate;

@end