//
//  ShopAnnotationView.h
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ShopPin.h"

@class ShopPin;
@class Shop;
@class ShopDetailPin;

@protocol ShopAnnotationDelegate <NSObject>

-(void) shopAnnotationDetail:(Shop*) shop;

@end

@interface ShopAnnotationView : MKAnnotationView<UIGestureRecognizerDelegate,ShopPinDelegate>
{
    __weak Shop *_shop;
}

-(ShopAnnotationView*) initWithShop:(Shop*) shop;

-(void) setShop:(Shop*) shop;
-(void) showShop;
-(void) hideShop;
-(void) showPin;
-(void) hidePin;
-(void) showShopName;
-(void) hideShopName;
-(Shop*) shop;

@property (nonatomic, strong) ShopPin *pin;
@property (nonatomic, strong) ShopDetailPin *detailPin;
@property (nonatomic, assign) id<ShopAnnotationDelegate> delegate;

+(NSString *)reuseIdentifier;

@end
