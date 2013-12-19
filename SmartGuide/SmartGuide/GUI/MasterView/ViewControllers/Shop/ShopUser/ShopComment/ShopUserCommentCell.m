//
//  ShopUserCommentCell.m
//  SmartGuide
//
//  Created by MacMini on 22/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserCommentCell.h"

#define SHOP_USER_COMMENT_FONT [UIFont fontWithName:@"Avenir-Roman" size:11]
#define SHOP_USER_COMMENT_WIDTH 189.f

@implementation ShopUserCommentCell

-(void)loadWithComment:(ShopUserComment *)comment
{
    lblUsername.text=comment.username;
    lblTime.text=comment.time;
    lblComment.text=comment.comment;
    lblNumOfAgree.text=comment.numOfAgree;
    [btnAgree setTitle:@"Đồng ý" agreeStatus:[comment enumAgreeStatus]];
}

+(NSString *)reuseIdentifier
{
    return @"ShopUserCommentCell";
}

+(float)heightWithComment:(NSString *)comment
{
    UIFont *font=SHOP_USER_COMMENT_FONT;
    
    CGSize size=[comment sizeWithFont:font constrainedToSize:CGSizeMake(SHOP_USER_COMMENT_WIDTH, 999999) lineBreakMode:NSLineBreakByTruncatingTail];

    float commentY=25;

    return size.height+commentY+25;
}

+(float)heightSummary
{
    return 70;
}

-(IBAction) btnAgreeTouchUpInside:(id)sender
{
    
}

@end
