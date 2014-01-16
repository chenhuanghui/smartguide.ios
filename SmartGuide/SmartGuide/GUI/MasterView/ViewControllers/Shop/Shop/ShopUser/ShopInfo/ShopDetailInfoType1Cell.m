//
//  ShopDetailInfoToolCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType1Cell.h"
#define SHOP_DETAIL_INFO_TOOL_CELL_FONT [UIFont fontWithName:@"Avenir-Light" size:12]
#define SHOP_DETAIL_INFO_TOOL_CELL_CONTENT_WIDTH 200.f

@implementation ShopDetailInfoType1Cell

-(void) loadWithInfo1:(Info1 *)info1
{
    lblContent.text=info1.content;
    btnTick.enabled=info1.isTicked==DETAIL_INFO_TICKED;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType1Cell";
}

+(float)heightWithContent:(NSString *)content
{
    float height=[content sizeWithFont:SHOP_DETAIL_INFO_TOOL_CELL_FONT constrainedToSize:CGSizeMake(SHOP_DETAIL_INFO_TOOL_CELL_CONTENT_WIDTH, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+10;
    
    return MAX(height,40);
}

@end
