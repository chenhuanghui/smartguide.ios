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

#define SU_USER_COMMENT_CELL_EMPTY_HEIGHT 70.f

@implementation SUUserCommentCell
@synthesize delegate;

-(void)loadWithComments:(NSArray *)comments sort:(enum SORT_SHOP_COMMENT)sort maxHeight:(float)height
{
    cmtTyping.sortComment=sort;
    _comments=comments;

    [table reloadData];
    
    if(height!=-1)
        [table l_v_setH:height];
}

-(void)tableDidScroll:(UITableView *)tableUser cellRect:(CGRect)cellRect
{
    float diff=cellRect.origin.y-(tableUser.l_co_y+SHOP_USER_ANIMATION_ALIGN_Y+SHOP_USER_BUTTON_NEXT_HEIGHT);
    if(diff<0)
    {
        [self l_v_setY:cellRect.origin.y-diff];
        [table l_co_setY:-diff];
    }
    else
    {
        [self l_v_setY:cellRect.origin.y];
        [table l_co_setY:0];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return SU_USER_COMMENT_CELL_EMPTY_HEIGHT;
    
    return [ShopUserCommentCell heightWithComment:_comments[indexPath.row-1]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"emptyCell"];
        if(!cell)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"emptyCell"];
            cell.frame=CGRectMake(0, 0, tableView.frame.size.width, SU_USER_COMMENT_CELL_EMPTY_HEIGHT);
            
            cell.backgroundColor=[UIColor whiteColor];
            cell.contentView.backgroundColor=[UIColor whiteColor];
        }
        
        return cell;
    }
    
    ShopUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopUserCommentCell reuseIdentifier]];
    [cell loadWithComment:_comments[indexPath.row-1]];
    
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

+(float)heightWithComments:(NSArray *)comments maxHeight:(float)maxHeight
{
    float height=58+SU_USER_COMMENT_CELL_EMPTY_HEIGHT;
    
    for(ShopUserComment *comment in comments)
        height+=[ShopUserCommentCell heightWithComment:comment];
    
    return MAX(height, maxHeight);
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserCommentCell reuseIdentifier]];
    
    CommentTyping *cmtT=[CommentTyping new];
    cmtT.delegate=self;
    
    cmtT.autoresizingMask=UIViewAutoresizingNone;
    
    cmtTyping=cmtT;
    
    [self.contentView addSubview:cmtT];
}

+(float)tableY
{
    return 58;
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    return;
    if(self.superview)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    if(_tapTable)
    {
        [table removeGestureRecognizer:_tapTable];
    }
    
    [UIView animateWithDuration:[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey] animations:^{
        table.alphaView.alpha=0;
    } completion:^(BOOL finished) {
        [table removeAlphaView];
    }];
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    [table alphaViewWithColor:[UIColor grayColor]];
    table.alphaView.alpha=0;
    table.alphaView.userInteractionEnabled=false;
    [UIView animateWithDuration:[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey] animations:^{
        table.alphaView.alpha=0.3f;
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
    
    _tapTable=tap;
    
    [table addGestureRecognizer:tap];
}

-(void) tapGes:(UITapGestureRecognizer*) tap
{
    [table removeGestureRecognizer:tap];
    //    [self endEditing:true];
}

-(void)commentTypingTouchedSort:(CommentTyping *)cmt
{
    UIActionSheet *sheet=nil;
    
    switch (cmt.sortComment) {
        case SORT_SHOP_COMMENT_TIME:
            sheet=[[UIActionSheet alloc] initWithTitle:@"SORT" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Xếp hạng", nil];
            break;
            
        case SORT_SHOP_COMMENT_TOP_AGREED:
            sheet=[[UIActionSheet alloc] initWithTitle:@"SORT" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Thời gian", nil];
            break;
    }
    
    [sheet showInView:self];
}

-(void)commentTypingTouchedReturn:(CommentTyping *)cmt
{
    [self.delegate userCommentUserComment:self comment:cmtTyping.text isShareFacebook:false];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex)
        return;
    
    cmtTyping.sortComment=cmtTyping.sortComment==SORT_SHOP_COMMENT_TOP_AGREED?SORT_SHOP_COMMENT_TIME:SORT_SHOP_COMMENT_TOP_AGREED;
    
    [self.delegate userCommentChangeSort:self sort:cmtTyping.sortComment];
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
}

@end

@implementation TableUserComment



@end