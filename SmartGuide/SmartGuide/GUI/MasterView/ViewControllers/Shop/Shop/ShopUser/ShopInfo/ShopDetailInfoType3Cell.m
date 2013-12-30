//
//  ShopDetailInfoImageCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType3Cell.h"
#import "ImageManager.h"

#define SHOP_DETAIL_INFO_IMAGE_CELL_FONT [UIFont fontWithName:@"Avenir-Roman" size:12]
#define SHOP_DETAIL_INFO_IMAGE_CELL_CONTENT_WIDTH 186.f
#define SHOP_DETAIL_INFO_IMAGE_CELL_CONTENT_Y 20.f

@implementation ShopDetailInfoType3Cell

-(void)loadWithInfo3:(Info3 *)info3 isLastCell:(bool)isLastCell
{
    [imgv loadImageInfo3WithURL:info3.image];
    lblTitle.text=info3.title;
    lblContent.text=info3.content;
    bg.drawBottomLine=isLastCell;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType3Cell";
}

+(float) heightWithContent:(NSString*) content
{
    float height=[content sizeWithFont:SHOP_DETAIL_INFO_IMAGE_CELL_FONT constrainedToSize:CGSizeMake(SHOP_DETAIL_INFO_IMAGE_CELL_CONTENT_WIDTH, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=SHOP_DETAIL_INFO_IMAGE_CELL_CONTENT_Y;
    
    if(height-10>86)
        height+=10;
    
    return MAX(86,height);
}

@end
