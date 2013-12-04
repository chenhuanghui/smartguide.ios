//
//  ShopDetailInfoDetailCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoDetailCell.h"

#define SHOP_DETAIL_INFO_DETAIL_CELL_FONT [UIFont fontWithName:@"Avenir-Roman" size:12]
#define SHOP_DETAIL_INFO_DETAIL_CELL_CONTENT_WIDTH 125.f

@implementation ShopDetailInfoDetailCell

-(void)loadWithName:(NSString *)name withContent:(NSString *)content
{
    lblLeft.text=name;
    lblRight.text=content;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoDetailCell";
}

+(float)heightWithContent:(NSString *)content
{
        return [content sizeWithFont:SHOP_DETAIL_INFO_DETAIL_CELL_FONT constrainedToSize:CGSizeMake(SHOP_DETAIL_INFO_DETAIL_CELL_CONTENT_WIDTH, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+10;
}

@end
