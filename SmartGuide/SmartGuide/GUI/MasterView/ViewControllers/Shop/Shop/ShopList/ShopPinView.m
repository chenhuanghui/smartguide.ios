//
//  ShopPinView.m
//  SmartGuide
//
//  Created by MacMini on 01/03/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopPinView.h"
#import "Utility.h"

@implementation ShopPinView

-(void)showInfoWithShopUser:(Shop *)shop
{
    if(_pinInfo)
    {
        [_pinInfo setShopUser:shop];
        return;
    }
    
    ShopPinInfoView *pinInfo=[ShopPinInfoView new];
    [pinInfo setShopUser:shop];
    
    [pinInfo l_v_setY:-pinInfo.l_v_h-3];
    [pinInfo l_v_addX:self.l_v_w/2];
    
    [self addSubview:pinInfo];
    
    _pinInfo=pinInfo;
}

- (void)dealloc
{
    [self.delegate shopPinDealloc:self];
    self.delegate=nil;
}


-(void)showInfoWithShop:(ShopList *)shop
{
    _shop=shop;
    if(_pinInfo)
    {
        [_pinInfo setShop:shop];
        return;
    }
    
    ShopPinInfoView *pinInfo=[ShopPinInfoView new];
    [pinInfo setShop:shop];
    
    [pinInfo l_v_setY:-pinInfo.l_v_h-3];
    [pinInfo l_v_addX:self.l_v_w/2];
    
    [self addSubview:pinInfo];
    
    _pinInfo=pinInfo;
}

-(void)hideInfo
{
    if(_pinInfo)
    {
        [_pinInfo removeFromSuperview];
        _pinInfo=nil;
    }
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(self.superview && _pinInfo)
    {
        if([_pinInfo pointInside:[self convertPoint:point toView:_pinInfo] withEvent:event])
        {
            [self.delegate shopPinTouched:self];
            
            return self;
        }
    }
    
    return [super hitTest:point withEvent:event];
}

-(ShopList *)shop
{
    return _shop;
}

@end
