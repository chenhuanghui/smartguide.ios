//
//  ShopInfo.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopInfo.h"
#import "Utility.h"

@implementation ShopInfo

-(ShopInfo *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"ShopInfo") owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    return self;
}

-(void)setShop:(Shop *)shop
{
    if(!shop)
    {
        lblDesc.text=@"";
        lblAddress.text=@"";
        [btnContact setTitle:@"" forState:UIControlStateNormal];
        [lblWebsite setTitle:@"" forState:UIControlStateNormal];
        
        _shop=nil;
        return;
    }
    else
    {
        if(_shop && _shop.idShop.integerValue==shop.idShop.integerValue)
            return;
    }
    
    _shop=shop;
    
    lblDesc.text=@"";
    lblAddress.text=@"";
    [btnContact setTitle:@"" forState:UIControlStateNormal];
    [lblWebsite setTitle:@"" forState:UIControlStateNormal];
    
    if(!shop)
        return;

    lblDesc.text=_shop.desc;
    
    lblDesc.contentSize=CGSizeMake(lblDesc.contentSize.width, [lblDesc.text sizeWithFont:lblDesc.font constrainedToSize:CGSizeMake(lblDesc.contentSize.width, 9999) lineBreakMode:NSLineBreakByWordWrapping].height+10);
    
    CGRect rect=CGRECT_PHONE(CGRectMake(51, 14, 234, 109), CGRectMake(51, 14, 234, 195));
    lblDesc.frame=rect;
    if(lblDesc.frame.size.height>lblDesc.contentSize.height)
        rect.size.height=MAX(21, lblDesc.contentSize.height);
    
    lblDesc.frame=rect;
    
    lblAddress.text=shop.address;
    
    lblAddress.contentSize=CGSizeMake(lblAddress.contentSize.width, [lblAddress.text sizeWithFont:lblAddress.font constrainedToSize:CGSizeMake(lblAddress.contentSize.width, 9999) lineBreakMode:NSLineBreakByWordWrapping].height+10);
    
    rect=CGRectMake(51, lblDesc.frame.origin.y+lblDesc.frame.size.height-2, 234, 60);
    
    if(lblAddress.frame.size.height>lblAddress.contentSize.height)
        rect.size.height=MAX(21, lblAddress.contentSize.height-2);
    
    lblAddress.frame=rect;
    
    [btnContact setTitle:shop.contact forState:UIControlStateNormal];
    
    rect=CGRectMake(56, lblAddress.frame.origin.y+lblAddress.frame.size.height, 229, 21);
    btnContact.frame=rect;
    
    [lblWebsite setTitle:shop.website forState:UIControlStateNormal];
    
    rect=CGRectMake(54, btnContact.frame.origin.y+btnContact.frame.size.height, 227, 21);
    lblWebsite.frame=rect;

    rect=lblDiaChi.frame;
    rect.origin.y=lblAddress.frame.origin.y+3;
    lblDiaChi.frame=rect;
    
    rect=lblLienLac.frame;
    rect.origin.y=btnContact.frame.origin.y;
    lblLienLac.frame=rect;
    
    rect=lblWeb.frame;
    rect.origin.y=lblWebsite.frame.origin.y+4;
    lblWeb.frame=rect;
}

- (IBAction)btnContactTouchUpInside:(id)sender {
    NSString *text=[btnContact titleForState:UIControlStateNormal];
    
    text=[text stringByRemoveString:@" ",nil];
    if(text.length==0)
        return;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",text]]];
}

-(void)btnWebsiteTouchUpInside:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[lblWebsite titleForState:UIControlStateNormal]]];
}

@end
