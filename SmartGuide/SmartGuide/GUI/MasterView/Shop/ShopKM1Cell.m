//
//  ShopKM1Cel.m
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopKM1Cell.h"

@implementation ShopKM1Cell

-(void)setLL:(NSString *)text
{
    ll.text=text;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM1Cell";
}

+(float)height
{
    return 37;
}

@end
