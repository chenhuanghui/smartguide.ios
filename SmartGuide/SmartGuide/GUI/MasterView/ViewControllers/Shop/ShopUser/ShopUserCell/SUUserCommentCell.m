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

#define SU_USER_COMMENT_CELL_EMPTY_HEIGHT 70.f

@implementation SUUserCommentCell

-(void)loadWithShop:(Shop *)shop maxHeight:(float)maxHeight
{
    _shop=shop;

    [table reloadData];
    [table l_v_setH:maxHeight];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self endEditing:true];
}

-(void)tableDidScrollWithContentOffSetY:(float)contentOffSetY cellContentY:(float)y
{
    if(contentOffSetY>=y)
    {
        [self l_v_setY:contentOffSetY];
        [table l_co_setY:contentOffSetY-y];
    }
    else
    {
        [table l_co_setY:0];
    }
    return;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shop.userCommentsObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.userCommentsObjects.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return SU_USER_COMMENT_CELL_EMPTY_HEIGHT;
    
    return [ShopUserCommentCell heightWithComment:[_shop.userCommentsObjects[indexPath.row-1] comment]];
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
    
    [cell loadWithComment:_shop.userCommentsObjects[indexPath.row-1]];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"SUUserCommentCell";
}

+(float)heightWithShop:(Shop *)shop
{
    float height=58+SU_USER_COMMENT_CELL_EMPTY_HEIGHT;
    
    for(ShopUserComment *comment in shop.userCommentsObjects)
        height+=[ShopUserCommentCell heightWithComment:comment.comment];
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopUserCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserCommentCell reuseIdentifier]];
    
    CommentTyping *cmtT=[CommentTyping new];
    
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
    [self endEditing:true];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:true];
}

@end

@implementation TableUserComment



@end