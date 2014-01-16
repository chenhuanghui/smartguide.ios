//
//  ShopDetailInfoType4Cell.m
//  SmartGuide
//
//  Created by MacMini on 23/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopDetailInfoType4Cell.h"

@implementation ShopDetailInfoType4Cell

-(void)loadWithInfo4:(Info4 *)info4
{
    lblTitle.text=info4.title;
    lblDate.text=info4.date;
    lblContent.text=info4.content;
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoType4Cell";
}

+(float)heightWithContent:(NSString *)content
{
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:12] constrainedToSize:CGSizeMake(243, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+15;
    
    height+=40;
    
    return MAX(70,height);
}

@end
