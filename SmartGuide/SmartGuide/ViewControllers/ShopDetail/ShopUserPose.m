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
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"
#import "FrontViewController.h"

#define USER_POST_PLACEHOLDER @"Comment"

#define UIIMAGE_FACEBOOK_TICK [UIImage imageNamed:@"facebook_tick.png"]
#define UIIMAGE_FACEBOOK_NONE_TICK [UIImage imageNamed:@"facebook_nonetick.png"]

@implementation ShopUserPose
@synthesize delegate;

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ShopUserPose" owner:nil options:nil] objectAtIndex:0];
    if (self) {
        txt.text=@"";
        [txt setPlaceHolderText:USER_POST_PLACEHOLDER textColor:[UIColor lightTextColor]];
        containView.layer.masksToBounds=true;
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
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle=UIModalPresentationCurrentContext;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    else
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate=self;
    
    [[RootViewController shareInstance].frontViewController presentModalViewController:imagePicker animated:true];
    
    imgv.image=nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    picker.delegate=nil;
    imgv.image=nil;
    
    [[RootViewController shareInstance].frontViewController dismissModalViewControllerAnimated:true];
    
    [delegate shopUserPostCancelled:self];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imgv.image=nil;
    picker.delegate=nil;
    UIImage *img=[info valueForKey:UIImagePickerControllerOriginalImage];
    
    [[RootViewController shareInstance].frontViewController dismissModalViewControllerAnimated:true];

    [self setImage:img shop:_shop];
}

- (IBAction)btnFaceTouchUpInside:(id)sender {
    if([FacebookManager shareInstance].isLogined)
    {
        _isSharedFacebook=!_isSharedFacebook;
        
        [self settingShare];
    }
    else
    {
        btnFace.userInteractionEnabled=false;
        [[FacebookManager shareInstance] login];
    }
}

- (IBAction)btnSendTouchUpInside:(id)sender {
    [self uploadImage];
}

-(void)setImage:(UIImage *)image shop:(Shop *)shop
{
    CGRect rect=imgv.frame;
    rect.size= [Utility scaleUserPoseFromSize:image.size toSize:rect.size];
    
    imgv.image=image;
    
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
    [self endEditing:true];
    
    [self showLoadingWithTitle:nil];
    
    UIImage *image=imgv.image;
    NSData *data=UIImagePNGRepresentation(image);
//    CGSize size=imgv.image.size;

    int idUser=[DataManager shareInstance].currentUser.idUser.integerValue;
    ASIOperationUploadUserGallery *upload=[[ASIOperationUploadUserGallery alloc] initWithIDShop:_shop.idShop.integerValue userID:idUser desc:txt.text photo:data];
    upload.delegatePost=self;
    
    [upload startAsynchronous];
    
    if(_isSharedFacebook)
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
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Lỗi" onOK:nil];
//    [delegate shopUserPostFinished:self userGallery:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>0)
        [textView removePlaceHolderText];
    else
        [textView setPlaceHolderText:USER_POST_PLACEHOLDER textColor:[UIColor lightTextColor]];
}

-(void) settingLayout
{
    if([[FacebookManager shareInstance] isLogined])
    {
        _isSharedFacebook=true;
        [btnSend setTitle:@"Share" forState:UIControlStateNormal];
    }
    else
    {
        _isSharedFacebook=false;
        [btnSend setTitle:@"Gửi" forState:UIControlStateNormal];
    }
    
    [self settingShare];
}

-(void) settingShare
{
    if(_isSharedFacebook)
    {
        [btnFace setImage:UIIMAGE_FACEBOOK_TICK forState:UIControlStateNormal];
        [btnFace setImage:UIIMAGE_FACEBOOK_TICK forState:UIControlStateHighlighted];
        [btnFace setImage:UIIMAGE_FACEBOOK_NONE_TICK forState:UIControlStateSelected];
        [btnSend setTitle:@"Share" forState:UIControlStateNormal];
    }
    else
    {
        [btnFace setImage:UIIMAGE_FACEBOOK_NONE_TICK forState:UIControlStateNormal];
        [btnFace setImage:UIIMAGE_FACEBOOK_NONE_TICK forState:UIControlStateHighlighted];
        [btnFace setImage:UIIMAGE_FACEBOOK_TICK forState:UIControlStateSelected];
        
        [btnSend setTitle:@"Gửi" forState:UIControlStateNormal];
    }
}

@end
