//
//  ShopComment.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopComment.h"
#import "ShopCommentCell.h"
#import "ShopUserComment.h"
#import "RootViewController.h"
#import "UIImageView+AFNetworking.h"

@implementation ShopComment
@synthesize isProcessedData,handler;

-(ShopComment *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShopComment" owner:nil options:nil] objectAtIndex:0];
    
    [self setShop:shop];
    
    [tableComments registerNib:[UINib nibWithNibName:[ShopCommentCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopCommentCell reuseIdentifier]];
    
    CGRect rect=tableComments.frame;
    tableComments.transform=CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(45*4));
    tableComments.frame=rect;
    
    _templateComment=[[TableTemplate alloc] initWithTableView:tableComments withDelegate:self];
    [avatar setSmartGuideImageWithURL:[NSURL URLWithString:[DataManager shareInstance].currentUser.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR_COMMENT success:nil failure:nil];
    
    rect=tableComments.frame;
    rect.origin=CGPointZero;
    rect.size.height=15;
    UIView *vi = [[UIView alloc] initWithFrame:rect];
    vi.backgroundColor=[UIColor clearColor];
    tableComments.tableFooterView=vi;
    
    return self;
}

-(bool)tableTemplateAllowLoadMore:(TableTemplate *)tableTemplate
{
    return true;
}

-(void)tableTemplateLoadNext:(TableTemplate *)tableTemplate wait:(bool *)isWait
{
    [self loadCommentAtPage:_page+1];
    *isWait=true;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopCommentCell reuseIdentifier]];
    ShopUserComment *comment=[_comments objectAtIndex:indexPath.row];
    
    float tableOriginWidth=183;
    [cell setShopComment:comment widthChanged:tableComments.frame.size.width-tableOriginWidth];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //loading
    if(indexPath.row==_comments.count)
        return [ShopCommentCell heightWithContent:@""widthChanged:0];
    
    float tableOriginWidth=183;
    ShopUserComment *comment=[_comments objectAtIndex:indexPath.row];
    return [ShopCommentCell heightWithContent:comment.comment widthChanged:tableView.frame.size.width-tableOriginWidth]+5;
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
}

-(UITableView *)tableComment
{
    return tableComments;
}

-(void)processFirstDataBackground:(NSMutableArray *)firstData
{
    _comments=[[NSMutableArray alloc] initWithArray:firstData];
    [_templateComment setAllowLoadMore:_comments.count==10];
    isProcessedData=true;
    _page=1;
    
    [self removeLoading];
}

-(void)reset
{
    _shop=nil;
    _comments=[NSMutableArray array];
    txtComment.text=@"";
    _page=0;
    
    if(_operationComment)
    {
        [_operationComment cancel];
        _operationComment=nil;
    }
    
    [tableComments reloadData];
}

-(void)cancel
{
    if(_operationComment)
    {
        [_operationComment cancel];
        _operationComment=nil;
    }
}

-(void) loadCommentAtPage:(int) page
{
    _operationComment=nil;
    
    _operationComment=[[ASIOperationShopComment alloc] initWithIDShop:_shop.idShop.integerValue page:page];
    _operationComment.delegatePost=self;
    [_operationComment startAsynchronous];
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationShopComment *cmt=(ASIOperationShopComment*)operation;
    
    if(cmt.comments.count>0)
    {
        [_comments addObjectsFromArray:cmt.comments];
        _page++;
    }
    
    [_templateComment setAllowLoadMore:cmt.comments.count==10];
    [_templateComment endLoadNext];
    
    if(_page==1 && _comments.count>0)
    {
        [tableComments scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
}

-(void) startAnimHide:(float) duration keyboard:(CGRect) keyboard
{
    _isShowedComment=false;
    _isPreparedShowBigComment=false;
    
    [UIView animateWithDuration:duration animations:^{
        //vi tri x,y containComment được lấy khi bắt đầu animation scale (line 182)
        containComment.frame=CGRectMake(17, 189, 287, 228);
        tableComments.frame=CGRectMake(10, 0, 279, 181);
        containInput.frame=CGRectMake(0, 181, 287, 47);
        txtComment.frame=CGRectMake(10, 8, 220, 32);
        containtAvatar.frame=CGRectMake(239, 4, 40, 40);
        arrow.frame=CGRectMake(229, 17, 8, 13);
    } completion:^(BOOL finished) {
        [tableComments reloadData];
        
        CGPoint pnt=containComment.center;
        pnt=[self convertPoint:pnt fromView:containComment.superview];
        [containComment removeFromSuperview];
        [self addSubview:containComment];
        containComment.center=pnt;
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void) startAnimScaleDuration:(float) duration keyboard:(CGRect) keyboard
{
    _isShowedComment=true;
    
    [UIView animateWithDuration:duration animations:^{
        CGRect rect=containComment.frame;
        rect.origin.x=0;
        rect.size.width=[UIScreen mainScreen].bounds.size.width;
        rect.size.height=[UIScreen mainScreen].bounds.size.height-keyboard.size.height;
        rect.origin.y=keyboard.origin.y-rect.size.height;
        rect.size.height-=20;
        containComment.frame=rect;
        
        CGSize size=rect.size;
        
        rect=tableComments.frame;
        rect.origin.x=15;
        rect.origin.y=0;
        rect.size.width=size.width-rect.origin.x*2;
        tableComments.frame=rect;
        
        rect=containInput.frame;
        rect.origin.y=size.height-rect.size.height;
        rect.size.width=size.width;
        containInput.frame=rect;
        
        rect=containtAvatar.frame;
        rect.origin.x=tableComments.frame.origin.x+tableComments.frame.size.width-rect.size.width+3;
        containtAvatar.frame=rect;
        
        rect=txtComment.frame;
        rect.size.width=size.width-rect.origin.x-(size.width-containtAvatar.frame.origin.x)-9;
        txtComment.frame=rect;
        
        rect.origin.x=rect.origin.x+rect.size.width-1;
        rect.origin.y=17;
        rect.size=arrow.frame.size;
        arrow.frame=rect;
    } completion:^(BOOL finished) {
        [tableComments reloadData];
    }];
    
    tapComment=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapComment:)];
    [tableComments addGestureRecognizer:tapComment];
}

-(void) tapComment:(UITapGestureRecognizer*) tap
{
    switch (tap.state) {
        case UIGestureRecognizerStateEnded:
            [containComment endEditing:true];
            break;
            
        default:
            break;
    }
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    float duration=[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect rect=[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self startAnimScaleDuration:duration keyboard:rect];
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    [tableComments removeGestureRecognizer:tapComment];
    tapComment=nil;
    
    float duration=[notification.userInfo floatForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGRect rect=[[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [self startAnimHide:duration keyboard:rect];
}

-(void) willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(!newSuperview)
        return;
    
    if(isProcessedData)
        [tableComments reloadData];
    else
        [self showLoadingWithTitle:nil];
}

-(void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_isPreparedShowBigComment)
        
        return true;
    else
    {
        [self prepareShowBigComment];
        return false;
    }
}

-(void) prepareShowBigComment
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _isPreparedShowBigComment=true;
    
    CGPoint pnt=containComment.center;
    pnt=[self convertPoint:pnt toView:[RootViewController shareInstance].view];
    containComment.center=pnt;
    [[RootViewController shareInstance] moveMyCommentToRootView:containComment];
    
    [txtComment becomeFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return !_isSendingComment;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(_isSendingComment || [textField.text stringByRemoveString:@" ",nil].length==0)
        return false;
    
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    int idShop=_shop.idShop.integerValue;
    
    [self.window showLoadingWithTitle:nil];
    _isSendingComment=true;
    [ASIOperationPostComment postCommentWithIDUser:idUser idShop:idShop content:txtComment.text onCompleted:^(bool finished, ShopUserComment *comment) {
        if(finished)
        {
            [[FacebookManager shareInstance] postText:txtComment.text identity:nil delegate:nil];
            txtComment.text=@"";
            if(_comments.count==0)
                [_comments addObject:comment];
            else
                [_comments insertObject:comment atIndex:0];
            
            [tableComments reloadData];
        }

        [self.window removeLoading];
        _isSendingComment=false;
    }];
    
    return true;
}

@end