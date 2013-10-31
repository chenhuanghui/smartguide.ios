//
//  CreateUserView.m
//  SmartGuide
//
//  Created by MacMini on 9/23/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "CreateUserView.h"
#import "ASIOperationUpdateUserInfo.h"
#import "Utility.h"
#import "AlertView.h"
#import "AlphaView.h"
#import "ActivityIndicator.h"

@implementation CreateUserView
@synthesize delegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CreateUserView" owner:nil options:nil] objectAtIndex:0];
    
    self.frame=[UIScreen mainScreen].bounds;
    
    _selectedURL=@"";

    grid=[[AvatarListView alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue frame:[UIScreen mainScreen].bounds];
    grid.avatarDelegate=self;
    
    if (self) {
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [@"   " sizeWithFont:txtUser.font].width, 30)];
        lbl.font=txtUser.font;
        lbl.textColor=[UIColor grayColor];
        lbl.backgroundColor=[UIColor clearColor];
        lbl.text=@"  ";
        txtUser.leftView=lbl;
        txtUser.leftViewMode=UITextFieldViewModeAlways;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    return self;
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    keyboardHeight=[[notification.object valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
    if([txtUser.text stringByRemoveString:@" ",nil].length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập tên tài khoản" onOK:^{
            [txtUser becomeFirstResponder];
        }];
        return;
    }
    
    _isDoneTouched=true;
    if(_isLoadingAvatar)
    {
        [self showLoadingWithTitle:nil];
    }
    else
        [self notifyDone];
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    
    [self endEditing:true];
    
    grid.alpha=0;
    [self addSubview:grid];
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        grid.alpha=1;
    }];
}

-(void)avatarListSelectedEmptySpacing:(AvatarListView *)avatarListView
{
    [self hideAvatarList];
}

-(void) hideAvatarList
{
    grid.userInteractionEnabled=false;
    
    [UIView animateWithDuration:0.2f animations:^{
        grid.alpha=0;
    } completion:^(BOOL finished) {
        [grid removeFromSuperview];
        grid.alpha=1;
        
        grid.userInteractionEnabled=true;
    }];
    
    [txtUser becomeFirstResponder];
}

-(void)avatarListSelectedItem:(AvatarListView *)avatarListView item:(NSString *)url image:(UIImage *)image
{
    [self hideAvatarList];

    _selectedURL=[[NSString alloc] initWithString:url];
    _isLoadingAvatar=false;
    [imgvAvatar setImageWithLoading:[NSURL URLWithString:url] emptyImage:UIIMAGE_LOADING_AVATAR success:Nil failure:nil];
    
    [self notifyDone];
}

-(void) notifyDone
{
    if(!_isLoadingAvatar && _isDoneTouched)
    {
        [self endEditing:true];
        
        if(!_selectedURL)
            _selectedURL=@"";
        
        ASIOperationUpdateUserInfo *operation=[[ASIOperationUpdateUserInfo alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue name:txtUser.text avatar:_selectedURL];
        operation.delegatePost=self;
        
        [operation startAsynchronous];
        
        [self showLoadingWithTitle:nil];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationUpdateUserInfo *ope=(ASIOperationUpdateUserInfo*) operation;
    
    User *user=[DataManager shareInstance].currentUser;
    
    user.name=txtUser.text;
    user.avatar=ope.data;
    user.isConnectedFacebook=@(false);
    
    [[DataManager shareInstance] save];
    
    [self.delegate createUserFinished];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeLoading];
}

-(void)focusEdit
{
    [txtUser becomeFirstResponder];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(!newSuperview)
    {
        grid=nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

CALL_DEALLOC_LOG

@end
