//
//  PlaceListInfoCell.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlaceListInfoCell.h"

@implementation PlaceListInfoCell

-(void)loadWithNumOfShop:(NSString *)numOfShop name:(NSString *)name isTicked:(bool)isTicked
{
    lblNumOfShop.text=numOfShop;
    lblName.text=name;
    imgTick.highlighted=isTicked;
}

-(void)setIsTicked:(bool)isTicked
{
    imgTick.highlighted=isTicked;
}

+(NSString *)reuseIdentifier
{
    return @"PlaceListInfoCell";
}

+(float)height
{
    return 47;
}

@end
