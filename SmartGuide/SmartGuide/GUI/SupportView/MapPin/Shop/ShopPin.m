//
//  ShopPin.m
//  SmartGuide
//
//  Created by XXX on 7/10/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopPin.h"
#import "Utility.h"
#import "FTCoreTextStyle.h"

@implementation ShopPin
@synthesize delegate;

-(ShopPin *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopPin" owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    return self;
}

- (IBAction)btnDetailTouchUpInside:(id)sender {
    
    if([self isRespondSEL:@selector(shopPin:detailClicked:)])
    {
        [delegate shopPin:self detailClicked:sender];
        return;
    }
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
    [lblScore setText:[Utility ftCoreTextFormatScore:@"1" rank:@"/10"]];
    [lblScore addStyles:[Utility ftCoreTextFormatScoreMapStyle]];
    lblKM.text=[NSString stringWithFormat:@"%0.0fKM",_shop.distance.floatValue];
    lblContent.text=_shop.desc;
}

-(Shop *)shop
{
    return _shop;
}

-(UIButton *)buttonDetail
{
    return btnDetail;
}

-(bool) isRespondSEL:(SEL) selector
{
    return delegate && [delegate respondsToSelector:selector];
}

@end
