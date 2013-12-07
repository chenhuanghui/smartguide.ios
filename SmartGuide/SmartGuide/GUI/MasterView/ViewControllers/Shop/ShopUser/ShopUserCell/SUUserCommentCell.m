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

-(void)loadWithComments:(NSArray *)comments maxHeight:(float)maxHeight
{
    _comments=[comments mutableCopy];
    table.dataSource=self;
    table.delegate=self;
    
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
    return _comments.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return SU_USER_COMMENT_CELL_EMPTY_HEIGHT;
    
    int row=indexPath.row-1;
    return [ShopUserCommentCell heightWithComment:_comments[row]];
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
    
    int row=indexPath.row-1;
    ShopUserCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopUserCommentCell reuseIdentifier]];
    
    [cell loadWithComment:_comments[row]];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"SUUserCommentCell";
}

+(float)heightWithComments:(NSArray *)comments
{
    float height=58+SU_USER_COMMENT_CELL_EMPTY_HEIGHT;
    
    for(NSString *str in comments)
        height+=[ShopUserCommentCell heightWithComment:str];
    
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