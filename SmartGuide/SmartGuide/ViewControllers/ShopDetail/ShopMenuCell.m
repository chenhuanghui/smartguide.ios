//
//  ShopMenuCell.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopMenuCell.h"

@implementation ShopMenuCell

-(void)setName:(NSString *)name setPrice:(NSString *)price
{
    lblName.text=name;
    lblPrice.text=[NSString stringWithFormat:@"%@ vnđ",price];
}

+(NSString *)reuseIdentifier
{
    return @"ShopMenuCell";
}

+(float)heightWithContent:(NSString*)content
{
    return 31;
}

@end
