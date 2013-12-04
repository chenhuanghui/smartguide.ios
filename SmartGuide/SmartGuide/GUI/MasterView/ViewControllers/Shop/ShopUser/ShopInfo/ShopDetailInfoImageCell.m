//
//  ShopDetailInfoImageCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoImageCell.h"

#define SHOP_DETAIL_INFO_IMAGE_CELL_FONT [UIFont fontWithName:@"Avenir-Roman" size:12]
#define SHOP_DETAIL_INFO_IMAGE_CELL_CONTENT_WIDTH 153.f
#define SHOP_DETAIL_INFO_IMAGE_CELL_CONTENT_Y 20.f

@implementation ShopDetailInfoImageCell

-(void)loadWithImage:(UIImage *)image withTitle:(NSString *)title withContent:(NSString *)content
{
    imgv.image=image;
    lblTitle.text=title;
    lblContent.text=content;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoImageCell";
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
