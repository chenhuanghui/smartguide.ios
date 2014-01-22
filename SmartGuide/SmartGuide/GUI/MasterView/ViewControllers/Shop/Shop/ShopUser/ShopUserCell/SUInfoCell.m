//
//  SUInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUInfoCell.h"
#import "Utility.h"

@implementation SUInfoCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
    
    lblAddress.text=shop.address;
    lblCity.text=shop.city;
    
    [btnTel setTitle:[@"  " stringByAppendingString:shop.displayTel] forState:UIControlStateNormal];
    
    line.hidden=(_shop.km1!=nil || _shop.km2!=nil || _shop.promotionNew!=nil);
}

+(NSString *)reuseIdentifier
{
    return @"SUInfoCell";
}

+(float)height
{
    return 212;
}

-(IBAction) btnMapTouchUpInside:(id)sender
{
    [self.delegate infoCellTouchedMap:self];
}

-(IBAction) btnMakeCallTouchUpInside:(id)sender
{
    makePhoneCall(_shop.tel);
}

@end
