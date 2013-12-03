//
//  ShopUserCommentCell.m
//  SmartGuide
//
//  Created by MacMini on 22/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserCommentCell.h"

#define SHOP_USER_COMMENT_FONT [UIFont fontWithName:@"Futura-Medium" size:10]
#define SHOP_USER_COMMENT_WIDTH 189.f

@implementation ShopUserCommentCell

-(void)loadWithComment:(NSString *)comment
{
    
}

+(NSString *)reuseIdentifier
{
    return @"ShopUserCommentCell";
}

+(float)heightWithComment:(NSString *)comment
{
    UIFont *font=SHOP_USER_COMMENT_FONT;
    
    CGSize size=[comment sizeWithFont:font constrainedToSize:CGSizeMake(SHOP_USER_COMMENT_WIDTH, 999999) lineBreakMode:NSLineBreakByTruncatingTail];
    
    return size.height+10;
}

+(float)heightSummary
{
    return 70;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
//    borderView.layer.cornerRadius=8;
//    borderView.layer.masksToBounds=true;
}

@end
