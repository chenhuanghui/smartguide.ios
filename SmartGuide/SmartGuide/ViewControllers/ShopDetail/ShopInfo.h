//
//  ShopInfo.h
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"

@interface ShopInfo : UIView
{
    __weak IBOutlet UITextView *lblDesc;
    __weak IBOutlet UITextView *lblAddress;
    __weak IBOutlet UILabel *lblContact;
    __weak IBOutlet UITextView *lblWebsite;
    __weak IBOutlet UILabel *lblMieuTa;
    __weak IBOutlet UILabel *lblDiaChi;
    __weak IBOutlet UILabel *lblLienLac;
    __weak IBOutlet UILabel *lblWeb;
}

-(ShopInfo*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

@end
