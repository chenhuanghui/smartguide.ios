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
    
    [btnTel setTitle:[@"  " stringByAppendingString:shop.displayTel] forState:UIControlStateNormal];
    
    line.hidden=(_shop.km1!=nil || _shop.km2!=nil || _shop.promotionNew!=nil);
}

+(NSString *)reuseIdentifier
{
    return @"SUInfoCell";
}

+(float)heightWithAddress:(NSString *)address
{
    float height=187;
    
    height+=[address sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(269, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    return height;
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

@implementation SUInfoBG

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
}

-(void)drawRect:(CGRect)rect
{
    UIImage *imgMid=[UIImage imageNamed:@"frame_map_mid.png"];
    UIImage *imgBottom=[UIImage imageNamed:@"frame_map_bottom.png"];
    
    [imgMid drawAsPatternInRect:CGRectMake(0, 0, rect.size.width, rect.size.height-imgBottom.size.height)];
    [imgBottom drawAtPoint:CGPointMake(0, rect.size.height-imgBottom.size.height)];
}

@end