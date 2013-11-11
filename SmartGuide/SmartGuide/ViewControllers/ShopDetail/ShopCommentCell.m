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
#define COMMENT_CONTENT_FRAME CGRectMake(45,27,230,28)
#define COMMENT_SHOP_FRAME CGRectMake(45,12,185,21)

@implementation ShopCommentCell

-(void)setShopComment:(ShopUserComment *) userComment widthChanged:(float)changedWidth isZoomed:(bool)isZoomed
{
    name.text=userComment.user;
    comment.text=userComment.comment;
    lblShopName.text=userComment.shopName;
    
    CGSize constraint = CGSizeMake(COMMENT_CONTENT_FRAME.size.width+changedWidth, 20000.0f);
    
    if(isZoomed)
        time.text=userComment.fulltime;
    else
        time.text=userComment.time;
    
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:userComment.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR_COMMENT success:nil failure:nil];
    
    CGSize size = [userComment.comment sizeWithFont:[UIFont systemFontOfSize:COMMENT_FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    [comment setFrame:CGRectMake(COMMENT_CONTENT_FRAME.origin.x, COMMENT_CONTENT_FRAME.origin.y, COMMENT_CONTENT_FRAME.size.width+changedWidth, MAX(size.height, COMMENT_CONTENT_FRAME.size.height))];
    [lblShopName setFrame:CGRectMake(COMMENT_SHOP_FRAME.origin.x, COMMENT_SHOP_FRAME.origin.y, COMMENT_SHOP_FRAME.size.width+changedWidth, COMMENT_SHOP_FRAME.size.height)];
}

+(float)heightWithContent:(NSString *)content widthChanged:(float)changedWidth isZoomed:(bool)isZoomed
{
    CGSize constraint = CGSizeMake(COMMENT_CONTENT_FRAME.size.width+changedWidth, 20000.0f);
    
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:COMMENT_FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, COMMENT_CONTENT_FRAME.size.height);
    
    float labelCommentY=COMMENT_CONTENT_FRAME.origin.y;
    
    float y=height+labelCommentY;
    
    if(y>55)
        y+=5;
    
    return MAX(55, y);
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
