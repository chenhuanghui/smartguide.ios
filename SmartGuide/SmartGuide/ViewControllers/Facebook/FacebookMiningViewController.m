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
}

@property (nonatomic, strong) FBProfile *profile;

@end

@implementation FacebookMiningViewController
@synthesize profile;

- (id)init
{
    self = [super initWithNibName:NIB_PHONE(@"FacebookMiningViewController") bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    borderAvatar.layer.masksToBounds=true;
    borderAvatar.layer.cornerRadius=8;
    
    [self.navigationController setNavigationBarHidden:true];
    [[RootViewController shareInstance] setNeedRemoveLoadingScreen];
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, [@"  " sizeWithFont:txtUser.font].width, 30)];
    lbl.font=txtUser.font;
    lbl.textColor=[UIColor grayColor];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.text=@"  ";
    txtUser.leftView=lbl;
    txtUser.leftViewMode=UITextFieldViewModeAlways;
}

-(NSArray *)registerNotification
{
    return @[NOTIFICATION_FACEBOOK_LOGIN_SUCCESS];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS])
    {
        [Flurry trackUserWaitFacebook];
        
        getProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[FBSession activeSession].accessTokenData.accessToken];
        getProfile.delegate=self;
        [getProfile start];
        
        [self.view showLoadingWithTitle:nil];
    }
}

-(void) loginFacebook
{
    [Flurry trackUserClickFacebook];
    [[FacebookManager shareInstance] login];
}

-(void) postCheckinAppWithName:(NSString*) name
{
    [[FacebookManager shareInstance] postURL:[NSURL URLWithString:@"http://smartguide.vn"] title:@"SmartGuide - Trải nghiệm ngay nhận quà liền tay" text:[NSString stringWithFormat:@"Chúc mừng bạn %@ đã tham gia cộng đồng #SmartGuide. Chúc bạn có những trải nghiệm hoàn toàn thú vị cùng #SmartGuide",name]];
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *ope=(OperationFBGetProfile*)operation;
        
        self.profile = [ope.profile copy];

        getProfile=nil;
        
//        postProfile=[[ASIOperationFBProfile alloc] initWithFBProfile:self.profile];
//        postProfile.delegatePost=self;
//        [postProfile startAsynchronous];
        
        [self.view showLoadingWithTitle:nil];
        
        [self postCheckinAppWithName:self.profile.name];
    }
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        postProfile=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationFBProfile class]])
    {
        postProfile=nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
    }
    else
    {
        [self.view removeLoading];
        [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:@"Tạo thông tin đăng nhập thất bại" onOK:nil];
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    [self.view removeLoading];
    NSLog(@"%@ failed %@",CLASS_NAME,operation.error);
    [AlertView showAlertOKWithTitle:nil withMessage:[NSString stringWithFormat:@"%@",operation.error] onOK:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FACEBOOK_UPLOAD_PROFILE_FINISHED object:nil];
}

- (void)viewDidUnload {
    //    btnSkip = nil;
    btnFace = nil;
    //    imgvAvatar = nil;
    //    infoView = nil;
    faceView = nil;
    //    txtAccount = nil;
    //    btnAvatar = nil;
    infoView = nil;
    txtUser = nil;
    btnAvatar = nil;
    borderAvatar = nil;
    [super viewDidUnload];
}

- (IBAction)loginTouchUpInside:(id)sender {
    [self loginFacebook];
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
    if([txtUser.text stringByRemoveString:@" ",nil].length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:@"Vui lòng nhập tên tài khoản" onOK:^{
            [txtUser becomeFirstResponder];
        }];
        return;
    }
    
    if(![btnAvatar imageForState:UIControlStateNormal])
    {
        [AlertView showAlertOKWithTitle:@"Thông báo" withMessage:@"Vui lòng chọn avatar" onOK:^{
            double delayInSeconds = 0.5f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [btnAvatar sendActionsForControlEvents:UIControlEventTouchUpInside];
            });
        }];
        return;
    }
    
    [self uploadUserInfo];
}

-(void) uploadUserInfo
{
    NSData *data=nil;
    
    if(_isUserChangedAvatar)
        data=UIImagePNGRepresentation([btnAvatar imageForState:UIControlStateNormal]);
    
    ASIOperationUpdateUserInfo *ope=[[ASIOperationUpdateUserInfo alloc] initWithIDUser:[DataManager shareInstance].currentUser.idUser.integerValue name:txtUser.text avatar:data];
    ope.delegatePost=self;
    
    [ope startAsynchronous];
    
    [self.view showLoadingWithTitle:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
    imagePicker.allowsEditing=true;
    
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
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img=[info valueForKey:UIImagePickerControllerEditedImage];
    
    //    if(img.size.width>img.size.height)
    //    {
    //        img=[img resizedImage:CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width) interpolationQuality:kCGInterpolationHigh];
    //    }
    //    else
    //        img=[img resizedImage:[UIScreen mainScreen].bounds.size interpolationQuality:kCGInterpolationHigh];
    
    picker.delegate=nil;
    [picker dismissModalViewControllerAnimated:true];
    
    _isUserChangedAvatar=true;
    
    [btnAvatar setImage:img forState:UIControlStateNormal];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:true];
    return true;
}

- (IBAction)btnSkipTouchUpInside:(id)sender {
    
    [Flurry trackUserSkipFacebook];
    
    UIButton *btn=sender;
    
    btn.userInteractionEnabled=false;
    
    infoView.alpha=0;
    infoView.hidden=false;
    
    [UIView animateWithDuration:0.3f animations:^{
        faceView.alpha=0;
        infoView.alpha=1;
    } completion:^(BOOL finished) {
        faceView.hidden=true;
        
        [txtUser becomeFirstResponder];
    }];
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    
    [self.view endEditing:true];
    
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"Avatar" delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Thư viện", nil];
    
    sheet.actionSheetStyle=UIActionSheetStyleDefault;
    sheet.delegate=self;
    
    [sheet showInView:self.view];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}

@end
