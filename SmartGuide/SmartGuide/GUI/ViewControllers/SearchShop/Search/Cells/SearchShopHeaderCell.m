//
//  SearchShopHeaderCell.m
//  SmartGuide
//
//  Created by MacMini on 10/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SearchShopHeaderCell.h"

@implementation SearchShopHeaderCell

-(void)setHeaderText:(NSString *)text
{
    lbl.text=text;
}

+(NSString *)reuseIdentifier
{
    return @"SearchShopHeaderCell";
}

+(float)height
{
    return 30;
}

@end
