//
//  NewFeedPromotionCell.m
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NewFeedPromotionCell.h"
#import "ImageManager.h"

@implementation NewFeedPromotionCell

-(void)loadWithHome1:(UserHome1 *)home
{
    [imgv loadShopLogoWithURL:home.logo];
    lbl.text=home.content;
}

+(float)heightWithHome1:(UserHome1 *)home
{
    UIFont *font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    float height=60;
    height+=[home.content sizeWithFont:font constrainedToSize:CGSizeMake(202, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height-10;
    
    return height;
}

+(NSString *)reuseIdentifier
{
    return @"NewFeedPromotionCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    bg.layer.cornerRadius=2;
    bg.layer.masksToBounds=true;
}

@end
