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

-(ShopUserPose *)initWithViewController:(UIViewController *)viewController shop:(Shop *)shop
{
    self=[[ShopUserPose alloc] init];
    
    _viewController=viewController;
    _shop=shop;
    
    return self;
}

-(void)show
{
    _rootView=[[RootViewController shareInstance] giveARootView];
    _rootView.hidden=true;
    _rootView.backgroundColor=[UIColor whiteColor];
    
    [_rootView addSubview:self];
    
    [self showCamera];
}

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ShopUserPose" owner:nil options:nil] objectAtIndex:0];
    if (self) {
        txt.text=@"";
//        [txt setPlaceHolderText:USER_POST_PLACEHOLDER textColor:[UIColor lightTextColor]];
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
    [self showCamera];
}

-(void) showCamera
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle=UIModalPresentationCurrentContext;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    else
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imagePicker.delegate=self;
    
    [_viewController presentModalViewController:imagePicker animated:true];
    
    imgv.image=nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    picker.delegate=nil;
    [self cancelPose];
}

-(void) cancelPose
{
    imgv.image=nil;

    [_viewController dismissModalViewControllerAnimated:true];
    
    [delegate shopUserPostCancelled:self];
    
    [[RootViewController shareInstance] removeRootView:_rootView];
    [self removeFromSuperview];
    
    self.delegate=nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imgv.image=nil;
    picker.delegate=nil;
    UIImage *img=[info valueForKey:UIImagePickerControllerOriginalImage];

    NSData *data=UIImagePNGRepresentation(img);
    while (data.length>(2048*10)) {
        data=UIImagePNGRepresentation([img resizedImage:CGSizeMake(img.size.width*0.9f, img.size.height*0.9f) interpolationQuality:kCGInterpolationMedium]);
    }
    
    img=[UIImage imageWithData:data];
    
    [self setImage:img shop:_shop];
    
    _rootView.hidden=false;
    
    [txt becomeFirstResponder];
    
    [_viewController dismissModalViewControllerAnimated:true];
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
    
    if(ope.isSuccess)
    {
        [delegate shopUserPostFinished:self userGallery:ope.userGallery];
        
        imgv.image=nil;
        
        [UIView animateWithDuration:0.2f animations:^{
            _rootView.center=CGPointMake(_rootView.center.x, _rootView.center.y-_rootView.frame.size.height);
        } completion:^(BOOL finished) {
            [[RootViewController shareInstance] removeRootView:_rootView];
            [self removeFromSuperview];
            
            self.delegate=nil;
        }];
    }
    else
        [AlertView showAlertOKWithTitle:nil withMessage:@"Up hình thất bại" onOK:nil];
}

-(void) ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    [self removeLoading];
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Lỗi" onOK:nil];
//    [delegate shopUserPostFinished:self userGallery:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
//    if(textView.text.length>0)
//        [textView removePlaceHolderText];
//    else
//        [textView setPlaceHolderText:USER_POST_PLACEHOLDER textColor:[UIColor lightTextColor]];
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
