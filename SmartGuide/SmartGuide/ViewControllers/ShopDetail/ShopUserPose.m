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

@interface ImagePickerController : UIImagePickerController

@end

@implementation ImagePickerController

-(BOOL)wantsFullScreenLayout
{
    return false;
}

@end

@implementation ShopUserPose
@synthesize delegate;

-(ShopUserPose *)initWithViewController:(UIViewController *)viewController shop:(Shop *)shop
{
    self=[[ShopUserPose alloc] init];
    
    _viewController=viewController;
    _shop=shop;
    txt.delegate=self;
    
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
        _isUploadTokenFB=true;
    }
    return self;
}

-(void) userLoginFB:(NSNotification*) notification
{
    btnFace.userInteractionEnabled=true;
    [self settingLayout];
    
    _isUploadTokenFB=false;
    
    ASIOperationUploadFBToken *operation=[[ASIOperationUploadFBToken alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue fbToken:[FBSession activeSession].accessTokenData.accessToken];
    operation.delegatePost=self;
    
    [operation startAsynchronous];
}

-(void)removeFromSuperview
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super removeFromSuperview];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    [self endEditing:true];
    [self showCamera];
}

-(void) showCamera
{
    ImagePickerController *imagePicker=[[ImagePickerController alloc] init];
    imagePicker.wantsFullScreenLayout=false;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    else
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate=self;
    
    CGRect rect=imagePicker.view.frame;
    rect.origin.y=rect.size.height;
    imagePicker.view.frame=rect;
    
    [_viewController addChildViewController:imagePicker];
    [_viewController.view addSubview:imagePicker.view];
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rectAnim=imagePicker.view.frame;
        rectAnim.origin.y=OBJ_IOS(0, 20);
        rectAnim.size.height-=OBJ_IOS(0, 20);
        imagePicker.view.frame=rectAnim;
    }];
    
    imgv.image=nil;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self cancelPose];
    
    [self hideImagePicker:picker];
}

-(void) hideImagePicker:(UIImagePickerController*) picker
{
    picker.delegate=nil;
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        CGRect rect=picker.view.frame;
        rect.origin.y=rect.size.height;
        picker.view.frame=rect;
    } completion:^(BOOL finished) {
        [picker.view removeFromSuperview];
        [picker removeFromParentViewController];
    }];
}

-(void) cancelPose
{
    imgv.image=nil;
    
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
    
    if(img.size.width>img.size.height)
        img=[img resizedImage:CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width) interpolationQuality:kCGInterpolationHigh];
    else
        img=[img resizedImage:[UIScreen mainScreen].bounds.size interpolationQuality:kCGInterpolationHigh];
    
    [self setImage:img shop:_shop];
    
    _rootView.hidden=false;
    
    [txt becomeFirstResponder];
    
    [self hideImagePicker:picker];
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
    _isUserTouchedSend=true;
    [self notifySend];
}

-(void) notifySend
{
    [containView showLoadingWithTitle:nil];
    
    if(_isUploadTokenFB && _isUserTouchedSend)
    {
        [self uploadImage];
    }
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
    
    ASIOperationUploadUserGallery *upload=[[ASIOperationUploadUserGallery alloc] initWithIDShop:_shop.idShop.integerValue userID:idUser desc:txt.text photo:data shareFacebook:_isSharedFacebook];
    upload.delegatePost=self;
    
    [upload startAsynchronous];
    
    bool allowPostFacebook=false;
    
    if(_isSharedFacebook && allowPostFacebook)
    {
        [[FacebookManager shareInstance] postImage:imgv.image text:txt.text identity:nil delegate:nil];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadUserGallery class]])
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
            [AlertView showAlertOKWithTitle:nil withMessage:@"Đăng ảnh không thành công" onOK:nil];
    }
    else if([operation isKindOfClass:[ASIOperationUploadFBToken class]])
    {
        _isUploadTokenFB=true;
        [self notifySend];
    }
    
    //    upload=nil;
}

-(void) ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUploadUserGallery class]])
    {
        [self removeLoading];
        
        [AlertView showAlertOKWithTitle:nil withMessage:@"Đăng ảnh không thành công" onOK:nil];
    }
    else if([operation isKindOfClass:[ASIOperationUploadFBToken class]])
    {
        _isUploadTokenFB=true;
        [self notifySend];
    }
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
        [btnSend setTitle:@"Gởi" forState:UIControlStateNormal];
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
        
        [btnSend setTitle:@"Gởi" forState:UIControlStateNormal];
    }
}

-(BOOL)textView1:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [btnSend sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        return false;
    }
    
    return true;
}

@end
