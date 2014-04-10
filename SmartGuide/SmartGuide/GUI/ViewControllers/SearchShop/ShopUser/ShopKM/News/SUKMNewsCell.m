//
//  SUKMNewsCell.m
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SUKMNewsCell.h"
#import "ImageManager.h"
#import "Utility.h"

@implementation SUKMNewsCell

-(void)loadWithPromotionNews:(PromotionNews *)news
{
    lblTitle.text=news.title;
    lblContent.text=news.content;
    [cover loadImagePromotionNewsWithURL:news.image];
    lblDuration.text=news.duration;
    
    [lblContent l_v_setY:133+news.titleHeight];
}

-(void)hideLine
{
    lineStatus.hidden=true;
}

+(NSString *)reuseIdentifier
{
    return @"SUKMNewsCell";
}

+(float)heightWithPromotionNews:(PromotionNews *)news
{
    float height=195;
    
    news.titleHeight=[news.title sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:14] constrainedToSize:CGSizeMake(234, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=news.titleHeight;
    
    news.contentHeight=[news.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(234, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=news.contentHeight;
    
    return height;
}

@end
