//
//  ShopListPlaceCell.m
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopListPlaceCell.h"
#import "ImageManager.h"

@implementation ShopListPlaceCell

-(void)loadWithPlace:(Placelist *)place
{
    lblTitle.text=place.title;
    lblContent.text=place.desc;
    [imgvAuthorAvatar loadCommentAvatarWithURL:place.authorAvatar];
    lblNumOfView.text=[NSString stringWithFormat:@"%@ lượt xem", place.numOfView];
    
    [lblAuthorName setText:[NSString stringWithFormat:@"<text>by <author>%@</author></text>",place.authorName]];
}

-(void)loadWithUserHome3:(UserHome3 *)home
{
    lblTitle.text=home.place.title;
    lblContent.text=home.content;
    [imgvAuthorAvatar loadCommentAvatarWithURL:home.place.authorAvatar];
    lblNumOfView.text=[NSString stringWithFormat:@"%@ lượt xem", home.place.numOfView];
    
    [lblAuthorName setText:[NSString stringWithFormat:@"<text>by <author>%@</author></text>",home.place.authorName]];
}

+(float)heightWithContent:(NSString *)content
{
    float height=[content sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:13] constrainedToSize:CGSizeMake(249, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height+10;
    
    if(height>45)
        height=45;
    
    return MAX(80,height+44);
}

+(NSString *)reuseIdentifier
{
    return @"ShopListPlaceCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    NSMutableArray *array=[NSMutableArray array];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor grayColor];
    style.font=[UIFont fontWithName:@"Avenir-Oblique" size:12];
    
    [array addObject:[style copy]];
    
    style=[FTCoreTextStyle styleWithName:@"author"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor redColor];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:12];
    
    [array addObject:[style copy]];
    
    [lblAuthorName addStyles:array];
}

@end
