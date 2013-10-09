//
//  ShopCommentCell.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopCommentCell.h"
#import "Utility.h"
#import "UIImageView+AFNetworking.h"
#import "Constant.h"

#define COMMENT_FONT_SIZE 10
#define COMMENT_WIDTH 275.f
#define COMMENT_Y 15

@implementation ShopCommentCell

-(void)setShopComment:(ShopUserComment *) userComment widthChanged:(float)changedWidth isZoomed:(bool)isZoomed
{
    name.text=userComment.user;
    
    CGSize constraint = CGSizeMake(COMMENT_WIDTH+changedWidth, 20000.0f);
    
    CGSize size = [userComment.comment sizeWithFont:[UIFont systemFontOfSize:COMMENT_FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    if(isZoomed)
        time.text=userComment.fulltime;
    else
        time.text=userComment.time;
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:userComment.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR_COMMENT success:nil failure:nil];
    
    comment.text=userComment.comment;
    [comment setFrame:CGRectMake(45, 15, COMMENT_WIDTH+changedWidth, MAX(size.height, 21))];
}

+(float)heightWithContent:(NSString *)content widthChanged:(float)changedWidth
{
    CGSize constraint = CGSizeMake(COMMENT_WIDTH+changedWidth, 20000.0f);
    
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:COMMENT_FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, 45);
    
    float labelCommentY=15;
    return height+labelCommentY;
}

+(NSString *)reuseIdentifier
{
    return @"ShopCommentCell";
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self=[super awakeAfterUsingCoder:aDecoder];
    
    self.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*4));
    
    return self;
}

@end
