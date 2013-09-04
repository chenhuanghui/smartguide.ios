//
//  ShopInfo.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"

@interface ShopInfo : UIView<UIWebViewDelegate>
{
    UIWebView *web;
    __weak Shop *_shop;
}

-(ShopInfo*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

- (IBAction)btnContactTouchUpInside:(id)sender;

@end
