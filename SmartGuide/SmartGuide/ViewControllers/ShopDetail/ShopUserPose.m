//
//  ShopUserPose.m
//  SmartGuide
//
//  Created by XXX on 8/6/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopUserPose.h"
#import "ActivityIndicator.h"
#import "Utility.h"


#define USER_POST_PLACEHOLDER @"Comment"

@implementation ShopUserPose
@synthesize delegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ShopUserPose" owner:nil options:nil] objectAtIndex:0];
    if (self) {
        txt.text=@"";
        [txt setPlaceHolderText:USER_POST_PLACEHOLDER];
        [[FacebookManager shareInstance] isAuthorized];
    }
    return self;
}

-(void) userLoginFB:(NSNotification*) notification
{
    btnFace.userInteractionEnabled=true;
    [self settingLayout];
}

-(void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super removeFromSuperview];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [delegate shopUserPostCancelled:self];
}

- (IBAction)btnFaceTouchUpInside:(id)sender {
    if([FacebookManager shareInstance].isLogined)
    {
        [self performSelector:@selector(changeButtonState) withObject:nil afterDelay:0];
    }
    else
    {
        btnFace.userInteractionEnabled=false;
        [[FacebookManager shareInstance] login];
    }
}

-(void) changeButtonState
{
    btnFace.highlighted=!btnFace.highlighted;
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    [self uploadImage];
}

-(void)setImage:(UIImage *)image shop:(Shop *)shop
{
    imgv.image=image;
    
    CGRect rect=imgv.frame;
    rect.size=[Utility scaleProportionallyFromSize:image.size toSize:rect.size];
    
    imgv.frame=rect;
    imgv.center=CGPointMake(containView.frame.size.width/2, containView.frame.size.height/2);
    
    _shop=shop;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(newSuperview)
    {
        [txt becomeFirstResponder];
        [self settingLayout];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginFB:) name:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS object:nil];
    }
}

-(void) uploadImage
{
    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    ASIOperationUploadUserGallery *upload=[[ASIOperationUploadUserGallery alloc] initWithIDShop:_shop.idShop.integerValue userID:idUser desc:txt.text photo:UIImageJPEGRepresentation(imgv.image, 0)];
    upload.delegatePost=self;
    
    [upload startAsynchronous];
    
    [self showLoadingWithTitle:nil];
    
    if(!btnFace.highlighted)
    {
        [[FacebookManager shareInstance] postImage:imgv.image text:txt.text identity:nil delegate:nil];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    ASIOperationUploadUserGallery *ope=(ASIOperationUploadUserGallery*)operation;
    
    [self removeLoading];
    
    [delegate shopUserPostFinished:self userGallery:ope.userGallery];
}

-(void) ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeLoading];
    
    [delegate shopUserPostFinished:self userGallery:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>0)
        [textView removePlaceHolderText];
    else
        [textView setPlaceHolderText:USER_POST_PLACEHOLDER];
}

-(void) settingLayout
{
    if([[FacebookManager shareInstance] isLogined])
    {
        btnFace.highlighted=false;
        [btnSend setTitle:@"Share" forState:UIControlStateNormal];
    }
    else
    {
        btnFace.highlighted=true;
        [btnSend setTitle:@"Gữi" forState:UIControlStateNormal];
    }
}

@end
