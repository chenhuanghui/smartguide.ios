//
//  ShopListCell.m
//  SmartGuide
//
//  Created by MacMini on 15/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListCell.h"

@implementation ShopListCell

-(void)loadContent
{
    imgvVoucher.hidden=rand()%2==0;
    imgvSGP.hidden=!imgvVoucher.hidden;
}

+(NSString *)reuseIdentifier
{
    return @"ShopListCell";
}

+(float)height
{
    return 55;
}

@end
