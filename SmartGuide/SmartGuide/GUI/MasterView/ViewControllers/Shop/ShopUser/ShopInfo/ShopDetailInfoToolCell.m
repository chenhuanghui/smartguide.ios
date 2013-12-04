//
//  ShopDetailInfoToolCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoToolCell.h"
#define SHOP_DETAIL_INFO_TOOL_CELL_FONT [UIFont fontWithName:@"Avenir-Light" size:12]
#define SHOP_DETAIL_INFO_TOOL_CELL_CONTENT_WIDTH 200.f

@implementation ShopDetailInfoToolCell

-(void)loadWithContent:(NSString *)content withState:(bool)isTicked
{
    lblContent.text=content;
    btnTick.enabled=isTicked;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoToolCell";
}

+(float)heightWithContent:(NSString *)content
{
    return [content sizeWithFont:SHOP_DETAIL_INFO_TOOL_CELL_FONT constrainedToSize:CGSizeMake(SHOP_DETAIL_INFO_TOOL_CELL_CONTENT_WIDTH, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+10;
}

@end
