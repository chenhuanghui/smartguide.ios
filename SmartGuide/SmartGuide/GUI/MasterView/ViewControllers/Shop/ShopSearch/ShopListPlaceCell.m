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
    lblAuthorName.text=place.authorName;
    lblNumOfView.text=place.numOfView;
}

+(float)heightWithContent:(NSString *)content
{
    return 80;
}

+(NSString *)reuseIdentifier
{
    return @"ShopListPlaceCell";
}

@end
