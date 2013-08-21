//
//  ShopInfo.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopInfo.h"

@implementation ShopInfo

-(ShopInfo *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopInfo" owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    return self;
}

-(void)setShop:(Shop *)shop
{
    lblDesc.text=@"";
    lblAddress.text=@"";
    lblContact.text=@"";
    lblWebsite.text=@"";
    
    if(!shop)
        return;
    
    lblDesc.text=shop.desc;
    lblAddress.text=shop.address;
    lblContact.text=shop.contact;
    lblWebsite.text=shop.website;
}

@end
