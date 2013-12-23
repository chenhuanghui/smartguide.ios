//
//  ShopDetailInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoCell.h"

#define DETAIL_INFO_CELL_MAX_HEIGHT_NORMAL 215

@implementation ShopDetailInfoCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop height:(float)height mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    lblShopName.text=shop.shopName;
    lblShopType.text=shop.shopType;
    lblFullAddress.text=[NSString stringWithFormat:@"%@, %@", shop.address, shop.city];
    lblIntro.text=shop.desc;
    
    if(mode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL)
    {
        float contentY=148;
        float height=[shop.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:12] constrainedToSize:CGSizeMake(242, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+15;
        
        height+=contentY;
        
        btnMore.hidden=height<=DETAIL_INFO_CELL_MAX_HEIGHT_NORMAL;
    }
}

-(void)loadWithShopList:(ShopList *)shop height:(float)height mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    lblShopName.text=shop.shopName;
    lblShopType.text=shop.shopTypeDisplay;
    lblFullAddress.text=shop.address;
    lblIntro.text=shop.desc;
    
    if(mode==SHOP_DETAIL_INFO_DESCRIPTION_NORMAL)
    {
        float contentY=148;
        float height=[shop.desc sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:12] constrainedToSize:CGSizeMake(242, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+15;
        
        height+=contentY;
        
        btnMore.hidden=height<=DETAIL_INFO_CELL_MAX_HEIGHT_NORMAL;
    }
}

-(IBAction) btnMoreTouchUpInside:(id)sender
{
    [self.delegate detailInfoCellTouchedMore:self];
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoCell";
}

+(float)heightWithContent:(NSString *)content mode:(enum SHOP_DETAIL_INFO_DESCRIPTION_MODE)mode
{
    float contentY=148;
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:12] constrainedToSize:CGSizeMake(242, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+15;
    
    height+=contentY;
    
    switch (mode) {
        case SHOP_DETAIL_INFO_DESCRIPTION_NORMAL:
            
            if(height>DETAIL_INFO_CELL_MAX_HEIGHT_NORMAL)
                height=DETAIL_INFO_CELL_MAX_HEIGHT_NORMAL;
            
            break;
            
        case SHOP_DETAIL_INFO_DESCRIPTION_FULL:
            break;
    }
    
    if(height<185)
        height=185;

    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    bg.drawBottomLine=true;
}

@end
