//
//  PromotionDetailCell.m
//  SmartGuide
//
//  Created by XXX on 8/1/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailCell.h"

@implementation PromotionDetailCell

-(void)setSGP:(int)sgp content:(NSString *)content hightlighted:(bool)isHightlighted
{
    lblSgp.text=[NSString stringWithFormat:@"%02d",sgp];
    lblContent.text=content;
    bar.highlighted=isHightlighted;
}

+(NSString *)reuseIdentifier
{
    return @"PromotionDetailCell";
}

+(float)height
{
    return 36;
}

@end
