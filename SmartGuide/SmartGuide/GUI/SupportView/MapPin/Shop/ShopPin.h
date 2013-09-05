//
//  ShopPin.h
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Shop.h"
#import "FTCoreTextView.h"

@class ShopPin;

@protocol ShopPinDelegate <NSObject>

-(void) shopPin:(ShopPin*) shopPin detailClicked:(id) sender;

@end

@interface ShopPin : UIView<UIGestureRecognizerDelegate>
{
    __weak IBOutlet FTCoreTextView *lblScore;
    __weak Shop *_shop;
    __weak IBOutlet UIButton *btnDetail;
    __weak IBOutlet UILabel *lblKM;
    __weak IBOutlet UITextView *lblContent;
    __weak IBOutlet UILabel *lblPoint;
}

-(ShopPin*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

-(Shop*) shop;
-(UIButton*) buttonDetail;

@property (nonatomic, assign) id<ShopPinDelegate> delegate;

@end
