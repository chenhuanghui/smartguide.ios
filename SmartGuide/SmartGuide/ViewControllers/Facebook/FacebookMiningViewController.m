//
//  FacebookMiningViewController.m
//  SmartGuide
//
//  Created by XXX on 7/24/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "FacebookMiningViewController.h"
#import "AlertView.h"
#import "Utility.h"
#import "UIImageView+AFNetworking.h"
#import "FBSession.h"
#import "FBAccessTokenData.h"
#import "RootViewController.h"

@interface FacebookMiningViewController ()
{
    ImageEditor *imgEditor;
}

@end

@implementation FacebookMiningViewController

- (id)init
{
    self = [super initWithNibName:@"FacebookMiningViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:true];
    [[RootViewController shareInstance] setNeedRemoveLoadingScreen];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [@"  " sizeWithFont:txtAccount.font].width, 30)];
    lbl.font=txtAccount.font;
    lbl.textColor=[UIColor grayColor];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.text=@"  ";
    txtAccount.leftView=lbl;
    txtAccount.leftViewMode=UITextFieldViewModeAlways;
}

-(NSArray *)registerNotification
{
    return @[UIApplicationDidBecomeActiveNotification,NOTIFICATION_FACEBOOK_LOGIN_SUCCESS,NOTIFICATION_FACEBOOK_LOGIN_FAILED];
}

-(void)receiveNotification1:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIApplicationDidBecomeActiveNotification])
    {
        if(!btnSkip.hidden)
            [self removeIndicator];
        
        if ([FBSession activeSession].accessTokenData.accessToken.length>0) {
            getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
            getProfile.delegate=self;
            [getProfile start];
            
            [self showIndicatoWithTitle:@"Get profile"];
        }
    }
    else if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS])
    {
        getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
        getProfile.delegate=self;
        [getProfile start];
        
        [self showIndicatoWithTitle:@"Get profile"];
    }
    else if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_FAILED])
    {
        [self removeIndicator];
        [AlertView showAlertOKWithTitle:nil withMessage:@"Login facebook failed" onOK:nil];
    }
}

-(void) loginFacebook
{
    [self showIndicatoWithTitle:@"Wait facebook"];
    [[FacebookManager shareInstance] login];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *ope=(OperationFBGetProfile*)operation;
        
        FBProfile *profile = ope.profile;
        
        User *user=[User userWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue];
        user.avatar=[NSString stringWithStringDefault:ope.profile.avatar];
        
        [imgvAvatar setSmartGuideImageWithURL:[NSURL URLWithString:user.avatar] placeHolderImage:UIIMAGE_LOADING_AVATAR success:nil failure:nil];
        
        [[DataManager shareInstance] save];
        
        [DataManager shareInstance].currentUser=[User userWithIDUser:user.idUser.integerValue];
        
        getProfile=nil;
        
        postProfile=[[ASIOperationFBProfile alloc] initWithFBProfile:profile];
        postProfile.delegatePost=self;
        [postProfile startAsynchronous];
        
        [self showIndicatoWithTitle:@"Upload infomation"];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    postProfile=nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    postProfile=nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self removeIndicator];
    NSLog(@"%@ failed %@",CLASS_NAME,operation.error);
    [AlertView showAlertOKWithTitle:nil withMessage:[NSString stringWithFormat:@"%@",operation.error] onOK:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

- (void)viewDidUnload {
    btnSkip = nil;
    btnFace = nil;
    imgvAvatar = nil;
    infoView = nil;
    faceView = nil;
    txtAccount = nil;
    btnAvatar = nil;
    [super viewDidUnload];
}

- (IBAction)skipTouchUpInside:(id)sender {
    
    infoView.alpha=0;
    infoView.hidden=false;
    
    [UIView animateWithDuration:0.5f animations:^{
        faceView.alpha=0;
        infoView.alpha=1;
    } completion:^(BOOL finished) {
        faceView.hidden=true;
        
        [txtAccount becomeFirstResponder];
    }];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

- (IBAction)loginTouchUpInside:(id)sender {
    [self loginFacebook];
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
    if([txtAccount.text stringByRemoveString:@" ",nil].length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập tên tài khoản" onOK:^{
            [txtAccount becomeFirstResponder];
        }];
        return;
    }
    
    if(![btnAvatar imageForState:UIControlStateNormal])
    {
        [AlertView showAlertOKCancelWithTitle:nil withMessage:@"Nhấn \"Huỷ\" để chọn avatar. Nhấn \"Tiếp tục\" với avatar rỗng" onOK:^{
            [btnAvatar sendActionsForControlEvents:UIControlEventTouchUpInside];
        } onCancel:^{
            [self uploadUserInfo];
        }];
        return;
    }
    
    [self uploadUserInfo];
}

-(void) uploadUserInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    //    FBProfile *profile=[[FBProfile alloc] init];
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Avatar" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Library", nil];
    
    sheet.actionSheetStyle=UIActionSheetStyleDefault;
    sheet.delegate=self;
    
    [sheet showInView:self.view];
    
    return;
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self showCamera:false];
            break;
            
        case 1:
            [self showCamera:true];
            
        default:
            break;
    }
}

-(void) showCamera:(bool) isFromLibrary
{
    [self.view endEditing:true];
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.modalPresentationStyle=UIModalPresentationCurrentContext;
    
    if(isFromLibrary)
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    else
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        else
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate=self;
    
    [self presentModalViewController:imagePicker animated:true];
    
    [btnAvatar setImage:nil forState:UIControlStateNormal];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [btnAvatar setImage:[info valueForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    picker.delegate=nil;
    [picker dismissModalViewControllerAnimated:true];
    return;
    [btnAvatar setImage:nil forState:UIControlStateNormal];
    
    UIImage *img=[info valueForKey:UIImagePickerControllerOriginalImage];
    imgEditor=[[ImageEditor alloc] initWithUIImage:img frame:self.view.frame];
    picker.delegate=nil;
    
    [picker dismissModalViewControllerAnimated:true];
    
    [self.view addSubview:imgEditor];
}

-(void)imageEditorBack
{
    
}

-(void)imageEditorCroped:(UIImage *)image
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:true];
    return true;
}

@end
