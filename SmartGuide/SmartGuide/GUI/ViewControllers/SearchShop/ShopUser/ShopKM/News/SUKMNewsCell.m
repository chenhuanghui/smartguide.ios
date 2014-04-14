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
    
    [cover l_v_setH:news.newsSize.height];
    
    [lblTitle l_v_setY:20+news.newsSize.height];
    [lblTitle l_v_setH:news.titleHeight];
    
    [lblContent l_v_setY:lblTitle.l_v_y+lblTitle.l_v_h+20];
    [lblContent l_v_setH:news.contentHeight];
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
    float height=90;
    
    news.titleHeight=[news.title sizeWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:14] constrainedToSize:CGSizeMake(234, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=news.titleHeight;
    
    news.contentHeight=[news.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(234, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    height+=news.contentHeight;
    
    height+=news.newsSize.height;
    
    return height;
}

@end
