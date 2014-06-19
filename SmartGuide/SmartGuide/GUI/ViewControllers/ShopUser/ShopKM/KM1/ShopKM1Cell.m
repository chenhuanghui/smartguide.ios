//
//  ShopKM1Cel.m
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopKM1Cell.h"
#import "KM1Voucher.h"

@implementation ShopKM1Cell

-(void)setVoucher:(NSString *)voucher content:(NSString *)content sgp:(NSString *)sgp isHighlighted:(bool)isHighlighted
{
    lblVoucher.text=voucher;
    lblContent.text=content;
    lblSGP.text=sgp;
    imgvFlag.highlighted=isHighlighted;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM1Cell";
}

+(float)heightWithVoucher:(KM1Voucher*) voucher
{
    float height=38;
    
    if(voucher.nameHeight.floatValue==-1)
        voucher.nameHeight=@([voucher.name sizeWithFont:[UIFont fontWithName:@"Georgia" size:14] constrainedToSize:CGSizeMake(198.f, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=voucher.nameHeight.floatValue;
   
    return height;
}

@end

@implementation ShopKM1ContentView

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_content_head.png"] drawAtPoint:CGPointZero];
    [[UIImage imageNamed:@"bg_content_mid.png"] drawAsPatternInRect:CGRectMake(0, 5, rect.size.width, rect.size.height-10)];
    [[UIImage imageNamed:@"bg_content_bottom.png"] drawAtPoint:CGPointMake(0, rect.size.height-5)];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
}

@end

@implementation UITableView(ShopKM1Cell)

-(void)registerShopKM1Cell
{
    [self registerNib:[UINib nibWithNibName:[ShopKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM1Cell reuseIdentifier]];
}

-(ShopKM1Cell *)shopKM1Cell
{
    return [self dequeueReusableCellWithIdentifier:[ShopKM1Cell reuseIdentifier]];
}

@end