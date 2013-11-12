//
//  PromotionDetailNotPartnerCell.m
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailNotPartnerCell.h"

#define NOTPARTNER_CONTENT_FRAME CGRectMake(33, 14, 255, 76)

@implementation PromotionDetailNotPartnerCell

-(void)loadWithTitle:(NSString *)title content:(NSString *)content
{
    lblTitle.text=title;
    txtContent.text=content;
    
    CGSize constraint = CGSizeMake(NOTPARTNER_CONTENT_FRAME.size.width, 20000.0f);
    
    float height = [content sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping].height+15;
    txtContent.frame=CGRectMake(NOTPARTNER_CONTENT_FRAME.origin.x, NOTPARTNER_CONTENT_FRAME.origin.y, NOTPARTNER_CONTENT_FRAME.size.width, height);
    
    CGRect rect=lblLine.frame;
    rect.origin.y=txtContent.frame.origin.y+txtContent.frame.size.height+3;
    lblLine.frame=rect;
}

-(void)setLineVisible:(bool)visible
{
    lblLine.hidden=!visible;
}

+(float)heightWithContent:(NSString *)content
{
    CGSize constraint = CGSizeMake(NOTPARTNER_CONTENT_FRAME.size.width, 20000.0f);
    
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = size.height;
    
    float labelCommentY=NOTPARTNER_CONTENT_FRAME.origin.y;
    
    return labelCommentY+height+20;
}

+(NSString *)reuseIdentifier
{
    return @"PromotionDetailNotPartnerCell";
}

@end

@implementation LLabel

-(void)drawTextInRect:(CGRect)rect
{
    rect.origin.y=0;
    [super drawTextInRect:rect];
}

@end