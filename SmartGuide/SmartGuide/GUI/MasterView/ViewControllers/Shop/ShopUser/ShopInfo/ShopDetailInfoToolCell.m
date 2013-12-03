//
//  ShopDetailInfoToolCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoToolCell.h"
#define SHOP_DETAIL_INFO_TOOL_CELL_FONT nil

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
    return 40;
}

@end
