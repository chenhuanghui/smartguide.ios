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
#import "GUIManager.h"

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

-(void) agree
{
    
}

-(IBAction) btnAgreeTouchUpInside:(id)sender
{
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
        {
            [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_COMMENT;
            [[SGData shareInstance].fData setObject:_comment.shop.idShop forKey:IDSHOP];
        } onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self agree];
        }];
        return;
    }
    if(currentUser().enumDataMode==USER_DATA_CREATING)
    {
        [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
         {
             [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_COMMENT;
             [[SGData shareInstance].fData setObject:_comment.shop.idShop forKey:IDSHOP];
         }onCancelled:nil onLogined:^(bool isLogined) {
            if(isLogined)
                [self agree];
        }];
        return;
    }
    
    [self agree];
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
