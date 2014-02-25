//
//  SUUserCommentCell.m
//  SmartGuide
//
//  Created by MacMini on 05/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUUserCommentCell.h"
#import "Utility.h"
#import "AlphaView.h"
#import "ShopUserViewController.h"
#import "GUIManager.h"

#define SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y 92.f
#define SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y 120.f

@implementation SUUserCommentCell
@synthesize delegate;

-(void)loadWithShop:(Shop *)shop sort:(enum SORT_SHOP_COMMENT)sort maxHeight:(float)height
{
    //    cmtTyping.sortComment=sort;
    
    _shop=shop;
    _sort=sort;
    [btnSort setTitle:localizeSortComment(_sort) forState:UIControlStateNormal];
    
    switch (sort) {
        case SORT_SHOP_COMMENT_TIME:
            _comments=shop.timeCommentsObjects;
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            _comments=shop.topCommentsObjects;
    }
    
    [table reloadData];
    
    if(height!=-1)
        [table l_v_setH:height];
    
    [imgvAvatar loadAvatarWithURL:userAvatar()];
 
    if(currentUser().allowShareCommentFB.boolValue)
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_Facebook.png"] highlightImage:[UIImage imageNamed:@"button_facebook_hidden.png"]];
    else
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_facebook_hidden.png"] highlightImage:[UIImage imageNamed:@"button_Facebook.png"]];
}

-(void)tableDidScroll:(UITableView *)tableUser cellRect:(CGRect)cellRect buttonNextHeight:(float)buttonHeight
{
    float y=tableUser.l_co_y-tableUser.l_v_y;
    
    if(y>cellRect.origin.y-buttonHeight)
    {
        [self l_v_setY:y+buttonHeight];
        [table l_co_setY:y-cellRect.origin.y-table.contentInset.top+buttonHeight];
    }
    else
    {
        [self l_v_setY:cellRect.origin.y];
        [table l_co_setY:-table.contentInset.top];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopUserCommentCell heightWithComment:_comments[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopUserCommentCell reuseIdentifier]];
    [cell loadWithComment:_comments[indexPath.row]];
    
    if(indexPath.row==0)
        [cell setCellPosition:CELL_POSITION_TOP];
    else if(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)
        [cell setCellPosition:CELL_POSITION_BOTTOM];
    else
        [cell setCellPosition:CELL_POSITION_MIDDLE];
    
    if(indexPath.row==_comments.count)
    {
        if([self.delegate userCommentCanLoadMore:self])
        {
            [self.delegate userCommentLoadMore:self];
        }
    }
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"SUUserCommentCell";
}

+(float)heightWithShop:(Shop *)shop sort:(enum SORT_SHOP_COMMENT)sort
{
    float height=141;
    
    NSArray *comments=[NSArray array];
    
    switch (sort) {
        case SORT_SHOP_COMMENT_TIME:
            comments=shop.timeCommentsObjects;
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            comments=shop.topCommentsObjects;
    }
    
    for(ShopUserComment *comment in comments)
    {
        height+=[ShopUserCommentCell heightWithComment:comment];
    }
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserCommentCell reuseIdentifier]];
    
    [self switchToNormailModeAnimate:false duration:0];
    
    txt.isScrollable=false;
    txt.contentInset=UIEdgeInsetsZero;
    txt.minNumberOfLines=1;
    txt.maxNumberOfLines=2;
    txt.returnKeyType=UIReturnKeyDone;
    txt.enablesReturnKeyAutomatically=true;
    txt.font=[UIFont fontWithName:@"Avenir-Roman" size:12];
    txt.delegate=self;
    txt.internalTextView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 5, 0, 5);
    txt.backgroundColor=[UIColor clearColor];
    txt.placeholder=@"Nhập nhận xét của bạn....";
    txt.keyboardType=UIKeyboardTypeDefault;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouchView:)];
    [touchView addGestureRecognizer:tap];
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

-(void) switchToEditingModeAnimate:(bool) animate duration:(float) duration
{
    NSLog(@"switchToEditingModeAnimate %i",animate);
    
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
        btnShare.alpha=0;
        btnShare.hidden=false;
        [UIView animateWithDuration:duration animations:^{
            
            float h=7;
            [bgView l_v_setH:SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y-SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y+h];
            [typeCommentBot l_v_setY:SU_USER_COMMENT_CELL_BOTTOM_EDIT_Y];
            
            [btnSort l_v_setY:containButtonView.l_v_h+btnSort.l_v_h];
            btnSort.alpha=0;
            
            [btnShare l_v_setY:19];
            btnShare.alpha=1;
            
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
        [btnShare l_v_setY:19];
        btnShare.alpha=1;
        btnShare.hidden=false;
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
    NSLog(@"switchToNormailModeAnimate %i",animate);
    
    _isAnimating=false;
    
    if(animate)
    {
        _isAnimating=true;
        btnSort.alpha=0;
        btnSort.hidden=false;
        btnShare.alpha=1;
        btnShare.hidden=false;
        btnSend.alpha=1;
        btnSend.hidden=false;
        
        [UIView animateWithDuration:duration animations:^{
            
            [bgView l_v_setH:7];
            [typeCommentBot l_v_setY:SU_USER_COMMENT_CELL_BOTTOM_NORMAL_Y];
            
            btnSort.alpha=1;
            [btnSort l_v_setY:19];
            
            [btnShare l_v_setY:containButtonView.l_v_h+btnShare.l_v_h];
            btnShare.alpha=0;
            
            [btnSend l_v_setY:containButtonView.l_v_h+btnSend.l_v_h];
            btnSend.alpha=0;
            
            animationView.alpha=0;
            
        } completion:^(BOOL finished) {
            animationView.hidden=true;
            btnShare.hidden=true;
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
        
        [btnShare l_v_setY:containButtonView.l_v_h+btnShare.l_v_h];
        btnShare.hidden=true;
        btnShare.alpha=0;
        
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
    
    switch (_sort) {
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
    
    _sort=_sort==SORT_SHOP_COMMENT_TIME?SORT_SHOP_COMMENT_TOP_AGREED:SORT_SHOP_COMMENT_TIME;
    
    [btnSort setTitle:localizeSortComment(_sort) forState:UIControlStateNormal];
    
    [self.delegate userCommentChangeSort:self sort:_sort];
}

- (IBAction)btnShareTouchUpInside:(id)sender {
    currentUser().allowShareCommentFB=@(!currentUser().allowShareCommentFB.boolValue);
    [[DataManager shareInstance] save];

    if(currentUser().allowShareCommentFB.boolValue)
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_Facebook.png"] highlightImage:[UIImage imageNamed:@"button_Facebook_hidden.png"]];
    else
        [btnShare setDefaultImage:[UIImage imageNamed:@"button_Facebook_hidden.png"] highlightImage:[UIImage imageNamed:@"button_Facebook.png"]];
    
    if(currentUser().allowShareCommentFB.boolValue)
    {
        btnShare.userInteractionEnabled=false;
        
        if([[FacebookManager shareInstance] isLogined])
        {
            if([[FacebookManager shareInstance] permissionTypeForPostToWall]==FACEBOOK_PERMISSION_DENIED)
            {
                [[FacebookManager shareInstance] requestPermissionPostToWallOnCompleted:^(enum FACEBOOK_PERMISSION_TYPE permissionType) {
                    btnShare.userInteractionEnabled=true;
                }];
            }
            else
                btnShare.userInteractionEnabled=true;
        }
        else
        {
            [[FacebookManager shareInstance] loginOnCompleted:^(enum FACEBOOK_PERMISSION_TYPE permissionType) {
                if(permissionType==FACEBOOK_PERMISSION_GRANTED)
                {
                    [[FacebookManager shareInstance] requestPermissionPostToWallOnCompleted:^(enum FACEBOOK_PERMISSION_TYPE permissionType) {
                        btnShare.userInteractionEnabled=true;
                    }];
                }
                else
                    btnShare.userInteractionEnabled=true;
            }];
        }
    }
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    if([txt.text stringByTrimmingWhiteSpace].length>0)
    {
        if(currentUser().enumDataMode==USER_DATA_TRY)
        {
            [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^
            {
                [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_COMMENT_SEND;
                [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
            } onCancelled:nil onLogined:^(bool isLogined) {
                if(isLogined)
                    [self.delegate userCommentUserComment:self comment:txt.text isShareFacebook:currentUser().allowShareCommentFB.boolValue];
            }];
            
            return;
        }
        else if(currentUser().enumDataMode==USER_DATA_CREATING)
        {
            [[GUIManager shareInstance] showLoginDialogWithMessage:localizeUserProfileRequire() onOK:^
            {
                [SGData shareInstance].fScreen=SCREEN_CODE_SHOP_USER_COMMENT_SEND;
                [[SGData shareInstance].fData setObject:_shop.idShop forKey:IDSHOP];
            } onCancelled:nil onLogined:^(bool isLogined) {
                if(isLogined)
                    [self.delegate userCommentUserComment:self comment:txt.text isShareFacebook:currentUser().allowShareCommentFB.boolValue];
            }];
            
            return;
        }
        
        [self.delegate userCommentUserComment:self comment:txt.text isShareFacebook:currentUser().allowShareCommentFB.boolValue];
    }
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