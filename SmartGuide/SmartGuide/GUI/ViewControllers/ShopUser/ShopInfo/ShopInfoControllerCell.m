//
//  SUInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopInfoControllerCell.h"
#import "Utility.h"

@implementation ShopInfoControllerCell

-(void)loadWithShop:(Shop *)shop
{
    _shop=shop;
    
    lblAddress.text=shop.address;
    
    [btnTel setTitle:[@"  " stringByAppendingString:shop.displayTel] forState:UIControlStateNormal];
    
    line.hidden=(_shop.km1!=nil || _shop.km2!=nil || _shop.promotionNew!=nil);
}

+(NSString *)reuseIdentifier
{
    return @"ShopInfoControllerCell";
}

+(float)heightWithShop:(Shop *)shop
{
    float height=187;
    
    if(shop.addressHeight.floatValue==-1)
        shop.addressHeight=@([shop.address sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(269, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height);
    
    height+=shop.addressHeight.floatValue;
    
    return height;
}

-(IBAction) btnMapTouchUpInside:(id)sender
{
    [self.delegate shopInfoControllerCellTouchedMap:self];
}

-(IBAction) btnMakeCallTouchUpInside:(id)sender
{
    makePhoneCall(_shop.tel);
}

@end

@implementation ShopInfoControllerCellBackground

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

@implementation UICollectionView(ShopInfoControllerCell)

-(void)registerShopInfoControllerCell
{
    [self registerNib:[UINib nibWithNibName:[ShopInfoControllerCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[ShopInfoControllerCell reuseIdentifier]];
}

-(ShopInfoControllerCell *)shopInfoControllerCellWithIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[ShopInfoControllerCell reuseIdentifier] forIndexPath:indexPath];
}

@end