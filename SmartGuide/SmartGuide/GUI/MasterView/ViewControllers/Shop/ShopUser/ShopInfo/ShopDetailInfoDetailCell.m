//
//  ShopDetailInfoDetailCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoDetailCell.h"

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
    return 40;
}

@end
