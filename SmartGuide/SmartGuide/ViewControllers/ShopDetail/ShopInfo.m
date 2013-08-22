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
    
    CGRect rect=CGRectMake(51, 14, 234, 72);
    if(lblDesc.frame.size.height>lblDesc.contentSize.height)
        rect.size.height=MAX(21, lblDesc.contentSize.height);
    
    lblDesc.frame=rect;
    
    lblAddress.text=shop.address;
    
    rect=CGRectMake(51, lblDesc.frame.origin.y+lblDesc.frame.size.height, 234, 60);
    
    if(lblAddress.frame.size.height>lblAddress.contentSize.height)
        rect.size.height=MAX(21, lblAddress.contentSize.height);
    
    lblAddress.frame=rect;
    
    lblContact.text=shop.contact;
    
    rect=CGRectMake(56, lblAddress.frame.origin.y+lblAddress.frame.size.height, 229, 21);
    lblContact.frame=rect;
    
    lblWebsite.text=shop.website;
    
    rect=CGRectMake(54, lblContact.frame.origin.y+lblContact.frame.size.height, 227, 21);
    lblWebsite.frame=rect;

    rect=lblDiaChi.frame;
    rect.origin.y=lblAddress.frame.origin.y+3;
    lblDiaChi.frame=rect;
    
    rect=lblLienLac.frame;
    rect.origin.y=lblContact.frame.origin.y;
    lblLienLac.frame=rect;
    
    rect=lblWeb.frame;
    rect.origin.y=lblWebsite.frame.origin.y+4;
    lblWeb.frame=rect;
}

@end
