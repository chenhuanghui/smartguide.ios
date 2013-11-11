//
//  PromotionDetailNotPartnerCell.m
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailNotPartnerCell.h"

#define NOTPARTNER_CONTENT_FRAME CGRectMake(34, 24, 274, 76)

@implementation PromotionDetailNotPartnerCell

-(void)loadWithTitle:(NSString *)title content:(NSString *)content
{
    lblTitle.text=title;
    txtContent.text=content;
    
    float height = [PromotionDetailNotPartnerCell heightWithContent:content];
    txtContent.frame=CGRectMake(NOTPARTNER_CONTENT_FRAME.origin.x, NOTPARTNER_CONTENT_FRAME.origin.y, NOTPARTNER_CONTENT_FRAME.size.width, height);
}

+(float)heightWithContent:(NSString *)content
{
    CGSize constraint = CGSizeMake(NOTPARTNER_CONTENT_FRAME.size.width, 20000.0f);
    
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, NOTPARTNER_CONTENT_FRAME.size.height);
    
    float labelCommentY=NOTPARTNER_CONTENT_FRAME.origin.y;
    
    return labelCommentY+height;
}

@end
