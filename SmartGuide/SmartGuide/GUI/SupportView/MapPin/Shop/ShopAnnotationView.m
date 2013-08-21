//
//  ShopAnnotationView.m
//  SmartGuide
//
//  Created by XXX on 7/12/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopAnnotationView.h"
#import "ShopPin.h"
#import "ShopDetailPin.h"
#import "Constant.h"
#import "Utility.h"
#import "Group.h"

@interface ShopAnnotationView()

@end

@implementation ShopAnnotationView
@synthesize pin,detailPin,delegate;

-(ShopAnnotationView *)initWithShop:(Shop *)shop
{
    self=[super initWithAnnotation:shop reuseIdentifier:[ShopAnnotationView reuseIdentifier]];
    
    self.image=[[Group groupWithIDGroup:shop.idGroup.integerValue] iconPin];
    
    _shop=shop;
    if(shop.showPinType==SHOP_SHOW_DETAIL)
        self.pin=[[ShopPin alloc] initWithShop:shop];
    else
        self.detailPin=[[ShopDetailPin alloc] initWithName:nil];
    
    return self;
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
    if(shop.showPinType==SHOP_SHOW_DETAIL)
        [self.pin setShop:shop];
    else
        [self.detailPin setName:shop.name];
}

-(void)shopPin:(ShopPin *)shopPin detailClicked:(id)sender
{
    if(delegate)
        [delegate shopAnnotationDetail:_shop];
}

-(void)showShop
{
    if(_shop.showPinType==SHOP_SHOW_NAME)
        [self showShopName];
    else
        [self showPin];
}

-(void)hideShop
{
    if(_shop.showPinType==SHOP_SHOW_NAME)
        [self hideShopName];
    else
        [self hidePin];
}

-(void)showPin
{
    self.pin.frame=[Utility centerPinWithFrameAnnotation:self.frame framePin:self.pin.frame];
    self.pin.delegate=self;
    
    [self addSubview:self.pin];
}

-(void)hidePin
{
    self.pin.delegate=nil;
    if(self.pin.superview)
        [self.pin removeFromSuperview];
}

-(void)showShopName
{
    self.detailPin.frame=[Utility centerPinWithFrameAnnotation:self.frame framePin:self.detailPin.frame];
    [self.detailPin setName:_shop.name];
    
    [self addSubview:self.detailPin];
}

-(void)hideShopName
{
    if(self.detailPin.superview)
        [self.detailPin removeFromSuperview];
}

-(NSString *)reuseIdentifier
{
    return [ShopAnnotationView reuseIdentifier];
}

+(NSString *)reuseIdentifier
{
    return @"ShopAnnotationView";
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.pin.superview)
    {
        UIView *result = [self.pin hitTest:[pin convertPoint:point fromView:self] withEvent:event];
        
        return result;

    }
    else
        return [super hitTest:point withEvent:event];
    }

-(Shop *)shop
{
    return _shop;
}

@end
