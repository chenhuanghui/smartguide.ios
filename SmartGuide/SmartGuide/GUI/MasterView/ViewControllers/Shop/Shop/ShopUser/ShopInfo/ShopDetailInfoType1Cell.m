//
//  ShopDetailInfoToolCell.m
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType1Cell.h"

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
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Light" size:12] constrainedToSize:CGSizeMake(215, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    
    return MAX(height,40);
}

@end
