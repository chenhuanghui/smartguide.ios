//
//  ShopInfo.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopInfo.h"
#import "Utility.h"
#import "ActivityIndicator.h"

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
        return;
    
    _shop=shop;
    
    if(!web)
    {
        CGRect rect=self.frame;
        rect.origin=CGPointZero;
        web=[[UIWebView alloc] initWithFrame:rect];
        web.backgroundColor=self.backgroundColor;
        [web setDataDetectorTypes:UIDataDetectorTypeLink|UIDataDetectorTypePhoneNumber];

        [self addSubview:web];
    }
    
    web.scrollView.bounces=false;
    
    web.delegate=self;
    
    [web loadHTMLString:[self formatInfoWithDesc:[NSString stringWithFormat:@"%@%@%@",_shop.desc,_shop.desc,_shop.desc] address:_shop.address contact:_shop.contact web:_shop.website] baseURL:nil];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return false;
    }
    
    return true;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView sizeThatFits:CGSizeZero];
}

-(NSString*) formatInfoWithDesc:(NSString*) desc address:(NSString*) address contact:(NSString*) contact web:(NSString*) website
{
    NSString *html=[NSString stringWithFormat:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:og=\"http://ogp.me/ns#\"xmlns:fb=\"https://www.facebook.com/2008/fbml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><meta http-equiv=\"REFRESH\" content=\"1800\" /><title>ABC</title></head><body><table style=\"font-family:Helvetica\"><tr><td valign=\"top\"><font size=\"2.2px\"><b>Miêu tả:</b></font></td><td style=\"vertical-align:top;text-align:justify\"><font size=\"2.2px\">%@</font></td></tr><tr height=\"10\"><td></td></tr><tr><td valign=\"top\"><font size=\"2.2px\"><b>Địa chỉ:</b></font></td><td><font size=\"2.2px\">%@</font></td></tr><tr height=\"10\"><td></td></tr><tr><td valign=\"top\"><font size=\"2.2px\"><b>Liên lạc:</b></font></td><td><font size=\"2.2px\">%@</font></td></tr><tr height=\"10\"><td></td></tr><tr><td valign=\"top\"><font size=\"2.2px\"><b>Website:</b></font></td><td><font size=\"2.2px\">%@</font></td></tr></table></body></html>",desc,address,contact,website];
    
    return html;
}

-(void)removeFromSuperview
{
    [web removeFromSuperview];
    web=nil;
    
    [super removeFromSuperview];
}

- (IBAction)btnContactTouchUpInside:(id)sender {
    
    //    [btnContact setTitleColor:[btnContact titleColorForState:UIControlStateNormal] forState:UIControlStateSelected];
    
    //    NSString *text=[btnContact titleForState:UIControlStateNormal];
    
    //    if([text stringByRemoveString:@" ",nil].length==0)
    return;
    
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",text]]];
}

@end
