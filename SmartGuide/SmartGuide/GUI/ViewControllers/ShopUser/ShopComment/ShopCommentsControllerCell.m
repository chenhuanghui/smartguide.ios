//
//  SUUserCommentCell.m
//  SmartGuide
//
//  Created by MacMini on 05/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopCommentsControllerCell.h"
#import "Utility.h"
#import "AlphaView.h"
#import "ShopUserViewController.h"
#import "GUIManager.h"
#import "LoadingMoreCell.h"
#import "HPGrowingTextView.h"
#import "ShopUserCommentCell.h"
#import "Shop.h"
#import "ButtonAgree.h"
#import "DataManager.h"
#import "ShopManager.h"
#import "KeyboardUtility.h"
#import "ImageManager.h"

#define SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y 92.f
#define SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y 120.f

@interface ShopCommentsControllerCell()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,HPGrowingTextViewDelegate>

@end

@implementation ShopCommentsControllerCell

-(void)loadWithShop:(Shop *)shop maxHeight:(float)height
{
    _shop=shop;
    [btnSort setTitle:localizeSortComment([ShopManager shareInstanceWithShop:_shop].sortComments) forState:UIControlStateNormal];
    
    [containComments l_v_setH:height];
    [table reloadData];
    
    [imgvAvatar loadAvatarWithURL:userAvatar()];
}

-(void)reloadData
{
    [table reloadData];
}

-(void)tableDidScroll:(UITableView *)tableUser
{
    NSIndexPath *idx=[tableUser indexPathForCell:self];
    CGRect rect=[tableUser rectForRowAtIndexPath:idx];
    
    float y=tableUser.l_co_y-tableUser.l_v_y-rect.origin.y;
 
    if(y>0)
    {
        [containView l_v_setY:y];
        [table l_co_setY:y-table.contentInset.top];
    }
    else
    {
        [containView l_v_setY:0];
        [table l_co_setY:-table.contentInset.top];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch ([ShopManager shareInstanceWithShop:_shop].sortComments) {
        case SORT_SHOP_COMMENT_TIME:
            return [ShopManager shareInstanceWithShop:_shop].timeComments.count+([ShopManager shareInstanceWithShop:_shop].canLoadMoreCommentTime?1:0);
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            return [ShopManager shareInstanceWithShop:_shop].topAgreedComments.count+([ShopManager shareInstanceWithShop:_shop].canLoadMoreCommentTopAgreed?1:0);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *comments=@[];
    bool canLoadMore=false;
    switch ([ShopManager shareInstanceWithShop:_shop].sortComments) {
        case SORT_SHOP_COMMENT_TIME:
            comments=[ShopManager shareInstanceWithShop:_shop].timeComments;
            canLoadMore=[ShopManager shareInstanceWithShop:_shop].canLoadMoreCommentTime;
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            comments=[ShopManager shareInstanceWithShop:_shop].topAgreedComments;
            canLoadMore=[ShopManager shareInstanceWithShop:_shop].canLoadMoreCommentTopAgreed;
            break;
    }
    
    if(canLoadMore && indexPath.row==comments.count)
        return 80;
    
    return [ShopUserCommentCell heightWithComment:comments[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *comments=@[];
    bool canLoadMore=false;
    bool isLoadingMore=true;
    switch ([ShopManager shareInstanceWithShop:_shop].sortComments) {
        case SORT_SHOP_COMMENT_TIME:
            comments=[ShopManager shareInstanceWithShop:_shop].timeComments;
            canLoadMore=[ShopManager shareInstanceWithShop:_shop].canLoadMoreCommentTime;
            isLoadingMore=[ShopManager shareInstanceWithShop:_shop].isLoadingMoreCommentTime;
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            comments=[ShopManager shareInstanceWithShop:_shop].topAgreedComments;
            canLoadMore=[ShopManager shareInstanceWithShop:_shop].canLoadMoreCommentTopAgreed;
            isLoadingMore=[ShopManager shareInstanceWithShop:_shop].isLoadingMoreCommentTopAgreed;
            break;
    }
    
    if(canLoadMore && indexPath.row==comments.count)
    {
        if(!isLoadingMore)
        {
            [[ShopManager shareInstanceWithShop:_shop] requestComments];
        }

        return [table loadingMoreCell];
    }
    
    ShopUserCommentCell *cell=[tableView shopUserCommentCell];
    [cell loadWithComment:comments[indexPath.row]];
    
    if(indexPath.row==0)
        [cell setCellPosition:CELL_POSITION_TOP];
    else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
        [cell setCellPosition:CELL_POSITION_BOTTOM];
    else
        [cell setCellPosition:CELL_POSITION_MIDDLE];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"ShopCommentsControllerCell";
}

+(float)heightWithShop:(Shop *)shop sort:(enum SORT_SHOP_COMMENT)sort
{
    float height=141;
    
    NSArray *comments=[[ShopManager shareInstanceWithShop:shop] commentWithSort:sort];
    
    for(ShopUserComment *comment in comments)
    {
        height+=[ShopUserCommentCell heightWithComment:comment];
    }
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerShopUserCommentCell];
    [table registerLoadingMoreCell];
    
    _isEditing=true;
    [self switchToNormailModeAnimate:false duration:0];
    
    txt.isScrollable=false;
    txt.contentInset=UIEdgeInsetsZero;
    txt.minNumberOfLines=1;
    txt.maxNumberOfLines=2;
    txt.returnKeyType=UIReturnKeySend;
    txt.enablesReturnKeyAutomatically=true;
    txt.font=FONT_SIZE_NORMAL(12);
    txt.delegate=self;
    txt.internalTextView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    txt.backgroundColor=[UIColor clearColor];
    txt.placeholder=@"Nhập nhận xét của bạn....";
    txt.keyboardType=UIKeyboardTypeDefault;
    txt.internalTextView.autocorrectionType=UITextAutocorrectionTypeNo;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouchView:)];
    [touchView addGestureRecognizer:tap];
    
    [self switchToNormailModeAnimate:false duration:0];
}

-(void) tapTouchView:(UITapGestureRecognizer*) tap
{
    [self endEditing:true];
}

+(float)tableY
{
    return 58;
}

-(void)focus
{
    //    [cmtTyping focus];
}

-(UITableView *)table
{
    return table;
}

-(void)switchToMode:(enum SHOP_COMMENT_MODE)mode animate:(bool)animate duration:(float)duration
{
    switch (mode) {
        case SHOP_COMMENT_MODE_EDIT:
            [self switchToEditingModeAnimate:animate duration:duration];
            break;
            
        case SHOP_COMMENT_MODE_NORMAL:
            [self switchToNormailModeAnimate:animate duration:duration];
            break;
    }
}

-(void) switchToEditingModeAnimate:(bool) animate duration:(float) duration
{
    if(_isEditing)
        return;
    
    _isEditing=true;
    _isAnimating=false;
    
    if(animate)
    {
        _isAnimating=true;
        animationView.alpha=0;
        animationView.hidden=false;
        btnSort.alpha=1;
        btnSort.hidden=false;
        btnSend.alpha=0;
        btnSend.hidden=false;
        [UIView animateWithDuration:duration animations:^{
            
            float h=7;
            [bgView l_v_setH:SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y-SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y+h];
            [typeCommentBot l_v_setY:SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y];
            
            [btnSort l_v_setY:containButtonView.l_v_h+btnSort.l_v_h];
            btnSort.alpha=0;
            
            [btnSend l_v_setY:0];
            btnSend.alpha=1;
            
            animationView.alpha=0.7f;
            
        } completion:^(BOOL finished) {
            btnSort.hidden=true;
            _isAnimating=false;
        }];
    }
    else
    {
        float h=7;
        [bgView l_v_setH:SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y-SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y+h];
        [typeCommentBot l_v_setY:SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y];
        [btnSort l_v_setY:containButtonView.l_v_h+btnSort.l_v_h];
        [btnSend l_v_setY:0];
        btnSend.alpha=1;
        btnSend.hidden=false;
        animationView.alpha=0.7f;
        animationView.hidden=false;
        btnSort.hidden=true;
        btnSort.alpha=0;
    }
    
    touchView.userInteractionEnabled=true;
}

-(void) switchToNormailModeAnimate:(bool) animate duration:(float) duration
{
    if(!_isEditing)
        return;
    
    _isAnimating=false;
    _isEditing=false;
    
    if(animate)
    {
        _isAnimating=true;
        btnSort.alpha=0;
        btnSort.hidden=false;
        btnSend.alpha=1;
        btnSend.hidden=false;
        
        [UIView animateWithDuration:duration animations:^{
            
            [bgView l_v_setH:7];
            [typeCommentBot l_v_setY:SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y];
            
            btnSort.alpha=1;
            [btnSort l_v_setY:19];

            [btnSend l_v_setY:containButtonView.l_v_h+btnSend.l_v_h];
            btnSend.alpha=0;
            
            animationView.alpha=0;
            
        } completion:^(BOOL finished) {
            animationView.hidden=true;
            btnSend.hidden=true;
            _isAnimating=false;
        }];
    }
    else
    {
        [bgView l_v_setH:7];
        [typeCommentBot l_v_setY:SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y];
        
        btnSort.hidden=false;
        btnSort.alpha=1;
        [btnSort l_v_setY:19];

        [btnSend l_v_setY:containButtonView.l_v_h+btnSend.l_v_h];
        btnSend.hidden=true;
        btnSend.alpha=0;
        
        animationView.alpha=0;
        animationView.hidden=true;
    }
    
    touchView.userInteractionEnabled=false;
}

- (IBAction)btnSortTouchUpInside:(id)sender {
    UIActionSheet *sheet=nil;
    
    switch ([ShopManager shareInstanceWithShop:_shop].sortComments) {
        case SORT_SHOP_COMMENT_TIME:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Sắp xếp" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:localizeSortComment(SORT_SHOP_COMMENT_TOP_AGREED), nil];
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            sheet=[[UIActionSheet alloc] initWithTitle:@"Sắp xếp" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:localizeSortComment(SORT_SHOP_COMMENT_TIME), nil];
            break;
    }
    
    [sheet showInView:self];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex)
        return;
    
    enum SORT_SHOP_COMMENT sort=[ShopManager shareInstanceWithShop:_shop].sortComments;
    sort=sort==SORT_SHOP_COMMENT_TIME?SORT_SHOP_COMMENT_TOP_AGREED:SORT_SHOP_COMMENT_TIME;
    
    [btnSort setTitle:localizeSortComment(sort) forState:UIControlStateNormal];
    
    [self.delegate shopCommentsControllerCellChangeSort:self sort:sort];
}

-(void) sendComment
{
    if([txt.text stringByTrimmingWhiteSpace].length>0)
    {
        if(currentUser().enumDataMode==USER_DATA_TRY)
        {
            [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
             {
                 [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_COMMENT_SEND;
                 [[SGData shareInstance].fData setObject:_shop.idShop forKey:@"idShop"];
             } onCancelled:nil onLogined:^(bool isLogined) {
                 if(isLogined)
                     [self.delegate shopCommentsControllerCellUserComment:self comment:txt.text];
             }];
            
            return;
        }
        else if(currentUser().enumDataMode==USER_DATA_CREATING)
        {
            [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
             {
                 [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_COMMENT_SEND;
                 [[SGData shareInstance].fData setObject:_shop.idShop forKey:@"idShop"];
             } onCancelled:nil onLogined:^(bool isLogined) {
                 if(isLogined)
                     [self.delegate shopCommentsControllerCellUserComment:self comment:txt.text];
             }];
            
            return;
        }
        
        [self.delegate shopCommentsControllerCellUserComment:self comment:txt.text];
    }
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    [self sendComment];
}

-(BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView
{
    [self sendComment];
    return true;
}

-(BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView
{
    return true;
}

-(void)clearInput
{
    txt.text=@"";
}

@end

@implementation UserCommentBGMidView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentMode=UIViewContentModeRedraw;
    self.backgroundColor=[UIColor clearColor];
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_typecomment_mid.png"] drawAsPatternInRect:rect];
}

@end

@implementation UITableView(ShopCommentsControllerCell)

-(void)registerShopCommentsControllerCell
{
    [self registerNib:[UINib nibWithNibName:[ShopCommentsControllerCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopCommentsControllerCell reuseIdentifier]];
}

-(ShopCommentsControllerCell *)shopCommentsControllerCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopCommentsControllerCell reuseIdentifier]];
}

@end