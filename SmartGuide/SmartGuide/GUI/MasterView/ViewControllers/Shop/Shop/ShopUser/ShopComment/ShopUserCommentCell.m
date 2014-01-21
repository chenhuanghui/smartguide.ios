//
//  ShopUserCommentCell.m
//  SmartGuide
//
//  Created by MacMini on 22/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserCommentCell.h"
#import "LoadingView.h"
#import "ImageManager.h"

#define SHOP_USER_COMMENT_FONT [UIFont fontWithName:@"Avenir-Roman" size:11]
#define SHOP_USER_COMMENT_WIDTH 189.f

@implementation ShopUserCommentCell

-(void)loadWithComment:(ShopUserComment *)comment
{
    _comment=comment;
    
    [imgvAvatar loadCommentAvatarWithURL:comment.avatar];
    
    lblUsername.text=comment.username;
    lblTime.text=comment.time;
    lblComment.text=comment.comment;
    lblNumOfAgree.text=comment.numOfAgree;
    
    switch (comment.enumAgreeStatus) {
        case AGREE_STATUS_AGREED:
            btnAgree.tag=AGREE_STATUS_AGREED;
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_agree.png"] highlightImage:[UIImage imageNamed:@"button_agree_hidden.png"]];
            break;
     
        case AGREE_STATUS_NONE:
            btnAgree.tag=AGREE_STATUS_NONE;
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_agree_hidden.png"] highlightImage:[UIImage imageNamed:@"button_agree.png"]];
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopUserCommentCell";
}

+(float)heightWithComment:(ShopUserComment *)comment
{
    UIFont *font=SHOP_USER_COMMENT_FONT;
    
    CGSize size=[comment.comment sizeWithFont:font constrainedToSize:CGSizeMake(SHOP_USER_COMMENT_WIDTH, 999999) lineBreakMode:NSLineBreakByTruncatingTail];

    float commentY=25;

    return size.height+commentY+25;
}

+(float)heightSummary
{
    return 70;
}

-(IBAction) btnAgreeTouchUpInside:(id)sender
{    
    enum AGREE_STATUS isAgree=_comment.enumAgreeStatus==AGREE_STATUS_AGREED?AGREE_STATUS_NONE:AGREE_STATUS_AGREED;
    ASIOperationAgreeComment *ope=[[ASIOperationAgreeComment alloc] initWithIDComment:_comment.idComment.integerValue userLat:userLat() userLng:userLng() isAgree:isAgree];
    ope.delegatePost=self;
    
    [ope startAsynchronous];
    
    switch (isAgree) {
        case AGREE_STATUS_AGREED:
            btnAgree.tag=AGREE_STATUS_AGREED;
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_agree.png"] highlightImage:[UIImage imageNamed:@"button_agree_hidden.png"]];
            break;
            
        case AGREE_STATUS_NONE:
            btnAgree.tag=AGREE_STATUS_NONE;
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_agree_hidden.png"] highlightImage:[UIImage imageNamed:@"button_agree.png"]];
            break;
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationAgreeComment class]])
    {
        [self loadWithComment:_comment];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    
}

@end
