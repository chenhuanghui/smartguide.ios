//
//  SUKMNewsCell.m
//  SmartGuide
//
//  Created by MacMini on 02/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SUKMNewsCell.h"
#import "ImageManager.h"

@implementation SUKMNewsCell

-(void)loadWithPromotionNews:(PromotionNews *)news
{
    lblTitle.text=news.title;
    lblContent.text=news.content;
    [cover loadImagePromotionNewsWithURL:news.image];
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
    float height=156;
    
    height+=[news.content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(234, 9999)].height;
    
    return height;
}

@end
