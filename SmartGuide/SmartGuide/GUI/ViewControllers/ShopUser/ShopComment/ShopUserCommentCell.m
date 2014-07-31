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
#import "ASIOperationAgreeComment.h"
#import "ShopUserComment.h"
#import "ButtonAgree.h"
#import "Shop.h"

@interface ShopUserCommentCell()<ASIOperationPostDelegate>
{
    ASIOperationAgreeComment *_operationAgree;
}

@end

@implementation ShopUserCommentCell
@synthesize suggestHeight;

-(void)loadWithComment:(ShopUserComment *)comment cellPos:(enum CELL_POSITION) cellPost
{
    _comment=comment;
    _cellPos=cellPost;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [UIView setAnimationsEnabled:false];
    
    self.contentView.frame=(CGRect){CGPointZero,self.frame.size};
    
    switch (_cellPos) {
        case CELL_POSITION_TOP:
        case CELL_POSITION_MIDDLE:
            lineBot.hidden=false;
            break;
            
        case CELL_POSITION_BOTTOM:
            lineBot.hidden=true;
            break;
    }
    
    lblUsername.text=_comment.username;
    lblUsername.frame=CGRectMake(57, 6, 236, 0);
    [lblUsername sizeToFit];
    
    lblComment.attributedText=[[NSAttributedString alloc] initWithString:_comment.comment attributes:@{NSFontAttributeName:lblComment.font
                                                                                                       , NSParagraphStyleAttributeName:[NSMutableParagraphStyle paraStyleJustified]}];
    lblComment.frame=CGRectMake(57, lblUsername.l_v_y+lblUsername.l_v_h+5, 236, 0);
    [lblComment sizeToFit];
    
    lblTime.text=_comment.time;
    lblTime.frame=CGRectMake(57, lblComment.l_v_y+lblComment.l_v_h+5, 206, 0);
    
    [lblTime sizeToFit];
    
    [lblTime l_v_setW:206];
    
    lblNumOfAgree.frame=lblTime.frame;
    
    [imgvAvatar loadCommentAvatarWithURL:_comment.avatar size:CGSizeMake(44, 44)];
    
    [self makeButtonAgree];
    
    [btnAgree l_v_setY:lblNumOfAgree.l_v_y-btnAgree.l_v_h/2+7];
    
    if(lineBot.hidden)
        suggestHeight=lblTime.l_v_y+lblTime.l_v_h+5;
    else
    {
        [lineBot l_v_setY:lblTime.l_v_y+lblTime.l_v_h+5];
        suggestHeight=lineBot.l_v_y+lineBot.l_v_h;
    }
    
    [UIView setAnimationsEnabled:true];
}

-(void) makeButtonAgree
{
    switch (_comment.enumAgreeStatus) {
        case AGREE_STATUS_AGREED:
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_agree.png"] highlightImage:[UIImage imageNamed:@"button_agree.png"]];
            break;
            
        case AGREE_STATUS_NONE:
            [btnAgree setDefaultImage:[UIImage imageNamed:@"button_agree_hidden.png"] highlightImage:[UIImage imageNamed:@"button_agree_hidden.png"]];
            break;
    }
    
    if([_comment.numOfAgree isEqualToString:[@"0" trim]])
        lblNumOfAgree.text=@"";
    else
        lblNumOfAgree.text=[NSString stringWithFormat:@"%@ lượt",_comment.numOfAgree];
}

+(NSString *)reuseIdentifier
{
    return @"ShopUserCommentCell";
}

+(float)heightWithComment:(ShopUserComment *)comment
{
    float height=65;

    if(comment.commentHeight.floatValue==-1)
        comment.commentHeight=@([comment.comment sizeWithFont:FONT_SIZE_NORMAL(11) constrainedToSize:CGSizeMake(236, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping].height);
    
    height+=comment.commentHeight.floatValue;
    height+=3;
    
    return MAX(65,height);
}

-(void) agree
{
    switch (_comment.enumAgreeStatus) {
        case AGREE_STATUS_AGREED:
            _comment.agreeStatus=@(AGREE_STATUS_NONE);
            _comment.totalAgree=MAX(@(0),@(_comment.totalAgree.integerValue-1));
            break;
            
        case AGREE_STATUS_NONE:
            _comment.agreeStatus=@(AGREE_STATUS_AGREED);
            _comment.totalAgree=@(_comment.totalAgree.integerValue+1);
            break;
    }
    _comment.numOfAgree=[NSNumberFormatter numberFromNSNumber:_comment.totalAgree];
    
    [self makeButtonAgree];
    
    if(_operationAgree)
    {
        [_operationAgree clearDelegatesAndCancel];
        _operationAgree=nil;
    }
    
    _operationAgree=[[ASIOperationAgreeComment alloc] initWithIDComment:_comment.idComment.integerValue userLat:userLat() userLng:userLng() isAgree:_comment.enumAgreeStatus];
    _operationAgree.delegate=self;
    
    [_operationAgree addToQueue];
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
        [self loadWithComment:_comment cellPos:_cellPos];
        
        _operationAgree=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationAgreeComment class]])
    {
        _operationAgree=nil;
    }
}

@end

@implementation UITableView(ShopUserCommentCell)

-(void)registerShopUserCommentCell
{
    [self registerNib:[UINib nibWithNibName:[ShopUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserCommentCell reuseIdentifier]];
}

-(ShopUserCommentCell *)shopUserCommentCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopUserCommentCell reuseIdentifier]];
}

@end