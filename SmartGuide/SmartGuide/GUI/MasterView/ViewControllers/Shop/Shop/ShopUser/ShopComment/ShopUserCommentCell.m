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
#import "FacebookManager.h"
#import "Utility.h"

@implementation ShopUserCommentCell

-(void)loadWithComment:(ShopUserComment *)comment
{
    _comment=comment;
    
    [imgvAvatar loadCommentAvatarWithURL:comment.avatar];
    
    lblUsername.text=comment.username;
    lblTime.text=comment.time;
    lblComment.text=comment.comment;
    lblNumOfAgree.text=comment.numOfAgree;
    
    [self makeButtonAgree];
}

-(void) makeButtonAgree
{
    switch (_comment.enumAgreeStatus) {
        case AGREE_STATUS_AGREED:
            btnAgree.tag=AGREE_STATUS_AGREED;
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_liked_comment.png"] highlightImage:[UIImage imageNamed:@"button_like_comment.png"]];
            break;
            
        case AGREE_STATUS_NONE:
            btnAgree.tag=AGREE_STATUS_NONE;
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_like_comment.png"] highlightImage:[UIImage imageNamed:@"button_liked_comment.png"]];
            break;
    }
}

-(void)setCellPosition:(enum CELL_POSITION)cellPos
{
    switch (cellPos) {
        case CELL_POSITION_TOP:
            lineBot.hidden=false;
            lineTop.hidden=false;
            break;
            
        case CELL_POSITION_MIDDLE:
            lineBot.hidden=false;
            lineTop.hidden=true;
            break;
            
        case CELL_POSITION_BOTTOM:
            lineBot.hidden=true;
            lineTop.hidden=true;
            break;
    }
}

+(NSString *)reuseIdentifier
{
    return @"ShopUserCommentCell";
}

+(float)heightWithComment:(ShopUserComment *)comment
{
    if(comment.cellCommentHeight!=-1)
        return comment.cellCommentHeight;
    
    comment.cellCommentHeight=80;
    
    if(comment.commentHeight==-1)
    {
        comment.commentHeight=[comment.comment sizeWithFont:[UIFont fontWithName:@"Avenir-Roman" size:11] constrainedToSize:CGSizeMake(189, 9999) lineBreakMode:NSLineBreakByTruncatingTail].height;
    }
    
    comment.cellCommentHeight+=MAX(0,comment.commentHeight-32);
    
    return comment.cellCommentHeight;
}

-(IBAction) btnAgreeTouchUpInside:(id)sender
{    
    enum AGREE_STATUS isAgree=_comment.enumAgreeStatus==AGREE_STATUS_AGREED?AGREE_STATUS_NONE:AGREE_STATUS_AGREED;
    ASIOperationAgreeComment *ope=[[ASIOperationAgreeComment alloc] initWithIDComment:_comment.idComment.integerValue userLat:userLat() userLng:userLng() isAgree:isAgree];
    ope.delegatePost=self;
    
    [ope startAsynchronous];

    switch (isAgree) {
        case AGREE_STATUS_AGREED:
            
            _comment.agreeStatus=@(AGREE_STATUS_AGREED);
            lblNumOfAgree.text=[NSNumberFormatter numberFromNSNumber:@(_comment.totalAgree.integerValue+1)];
            
            break;
            
        case AGREE_STATUS_NONE:
            
            _comment.agreeStatus=@(AGREE_STATUS_NONE);
            lblNumOfAgree.text=[NSNumberFormatter numberFromNSNumber:@(_comment.totalAgree.integerValue-1)];
            
            break;
    }
    
    [self makeButtonAgree];
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
