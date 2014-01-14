//
//  PlacelistHeaderCell.m
//  SmartGuide
//
//  Created by MacMini on 14/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "PlacelistHeaderCell.h"

@implementation PlacelistHeaderCell

-(void)setHeader:(NSString *)text
{
    lblHeader.text=text;
}

+(float)height
{
    return 37;
}

+(NSString *)reuseIdentifier
{
    return @"PlacelistHeaderCell";
}

@end
