//
//  ShopDetailInfoDetailCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType2Cell.h"

#define SHOP_DETAIL_INFO_DETAIL_CELL_FONT [UIFont fontWithName:@"Avenir-Roman" size:12]
#define SHOP_DETAIL_INFO_DETAIL_CELL_CONTENT_WIDTH 145.f

@implementation ShopDetailInfoType2Cell

-(void)loadWithInfo2:(Info2 *)info2
{
    lblLeft.text=info2.title;
    lblRight.text=info2.content;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType2Cell";
}

+(float)heightWithContent:(NSString *)content
{
    return MAX([content sizeWithFont:SHOP_DETAIL_INFO_DETAIL_CELL_FONT constrainedToSize:CGSizeMake(SHOP_DETAIL_INFO_DETAIL_CELL_CONTENT_WIDTH, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-10,32);
}

@end