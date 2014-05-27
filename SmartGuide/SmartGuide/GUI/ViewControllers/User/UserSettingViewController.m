//
//  SGUserSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "UserSettingViewController.h"
#import "DataManager.h"
#import "TokenManager.h"
#import "GUIManager.h"
#import "FacebookManager.h"
#import "GooglePlusManager.h"
#import "UserUploadAvatarManager.h"
#import "CityViewController.h"
#import "CityManager.h"

@interface UserSettingViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,AvatarControllerDelegate,ASIOperationPostDelegate,OperationURLDelegate,GPPSignInDelegate,CityControllerDelegate>

@end

@implementation UserSettingViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"UserSettingViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
    
    [contentView addSubview:_navi.view];
    [_navi l_v_setH:contentView.l_v_h];
    _navi.view.autoresizingMask=UIViewAutoresizingAll();
    
    _avatars=[NSMutableArray new];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    [dict setObject:[UIFont fontWithName:@"Georgia-Italic" size:13] forKey:NSFontAttributeName];
    [dict setObject:[UIColor color255WithRed:53 green:158 blue:239 alpha:255] forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *attStr=[[NSAttributedString alloc] initWithString:@"Điều khoản sử dụng" attributes:dict];
    [btnTerms setAttributedTitle:attStr forState:UIControlStateNormal];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppearOnce
{
    if(self.isNavigationButton)
        [btnSetting setImage:[UIImage imageNamed:@"button_navigation.png"] forState:UIControlStateNormal];
    else
        [btnSetting setImage:[UIImage imageNamed:@"button_backarrow.png"] forState:UIControlStateNormal];
}

-(void) loadData
{
    [imgvAvatar loadUserAvatar:currentUser() onCompleted:^(UIImage *avatar, UIImage *avatarBlurr) {
        if(avatarBlurr)
            [imgvBGAvatar setImage:avatar];
    }];
    
    [txtName setText:currentUser().name];
    [lblDOB setText:currentUser().birthday];
    [lblGender setText:localizeGender(currentUser().gender.integerValue)];
    _selectedGender=currentUser().gender.integerValue;
    _selectedAvatar=currentUser().avatar;
    lblCity.text=CITY_NAME(currentUser().idCity.integerValue);
    
    NSString *bd=[currentUser().birthday copy];
    bd=[bd stringByRemoveString:@"/",@"-",@" ",nil];
    
    if(bd.length>0)
        _selectedDate=[bd toDateWithFormat:@"ddMMyyyy"];
    
    btnFB.hidden=currentUser().enumSocialType!=SOCIAL_NONE;
    btnGP.hidden=currentUser().enumSocialType!=SOCIAL_NONE;
    
    btnCover.hidden=currentUser().enumDataMode!=USER_DATA_TRY;
    
    [scroll contentSizeToFit];
}

-(bool) validateAllowEdit
{
    switch (currentUser().enumDataMode) {
        case USER_DATA_FULL:
        case USER_DATA_CREATING:
            return true;
            
        case USER_DATA_TRY:
        {
            [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^{
                [SGData shareInstance].fScreen=SCREEN_CODE_USER_SETTING;
            } onCancelled:nil onLogined:^(bool isLogined) {
                if(isLogined)
                {
                    imgvAvatar.image=nil;
                    imgvBGAvatar.image=nil;
                    [[DataManager shareInstance].managedObjectContext refreshObject:currentUser() mergeChanges:false];
                    [self loadData];
                }
            }];
        }
            return false;
    }
}

-(UIViewController *)avatarControllerPresentViewController
{
    return [GUIManager shareInstance].rootViewController.contentNavigation;
}

-(NSArray *)registerNotifications
{
    return @[NOTIFICATION_FACEBOOK_LOGIN_SUCCESS,NOTIFICATION_FACEBOOK_LOGIN_FAILED];
}

-(void)receiveNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:NOTIFICATION_FACEBOOK_LOGIN_SUCCESS])
    {
        [self.view showLoading];
        
        _operationFBGetProfile=[[OperationFBGetProfile alloc] initWithAccessToken:[[FBSession activeSession] accessTokenData].accessToken];
        _operationFBGetProfile.delegate=self;
        
        [_operationFBGetProfile start];
    }
}

-(void)operationURLFinished:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        OperationFBGetProfile *ope=(OperationFBGetProfile*) operation;
        
        if(ope.jsonData.length>0)
        {
            _operationUploadSocialProfile=[[ASIOperationUploadSocialProfile alloc] initWithProfile:[ope.jsonData copy] socialType:SOCIAL_FACEBOOK accessToken:[FBSession activeSession].accessTokenData.accessToken];
            _operationUploadSocialProfile.delegatePost=self;
            
            [_operationUploadSocialProfile startAsynchronous];
        }
        else
            [self.view removeLoading];
        
        _operationFBGetProfile=nil;
    }
    else if([operation isKindOfClass:[OperationGPGetUserProfile class]])
    {
        OperationGPGetUserProfile *ope=(OperationGPGetUserProfile*) operation;
        
        if(ope.jsonData.length>0)
        {
            _operationUploadSocialProfile=[[ASIOperationUploadSocialProfile alloc] initWithProfile:[ope.jsonData copy] socialType:SOCIAL_GOOGLEPLUS accessToken:[GooglePlusManager shareInstance].authentication.accessToken];
            _operationUploadSocialProfile.delegatePost=self;
            
            [_operationUploadSocialProfile startAsynchronous];
        }
        else
            [self.view removeLoading];
        
        _operationGPGetUserProfile=nil;
    }
}

-(void)operationURLFailed:(OperationURL *)operation
{
    if([operation isKindOfClass:[OperationFBGetProfile class]])
    {
        [self.view removeLoading];
        
        _operationFBGetProfile=nil;
    }
    else if([operation isKindOfClass:[OperationGPGetUserProfile class]])
    {
        [self.view removeLoading];
        
        _operationGPGetUserProfile=nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
    
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [self.delegate userSettingControllerTouchedBack:self];
        [self loadData];
        return;
    }
    
    [self.view endEditing:true];
    [self finishUpdate];
}

-(bool) validateInput
{
    [self endEditing];
    
    if(_selectedAvatar.length==0 && _avatarImage==nil)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:localizeAvatarEmpty() onOK:^{
            [self showAvatars];
        }];
        
        return false;
    }
    
    if(currentUser().name.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:localizeNameEmpty() onOK:^{
            [txtName becomeFirstResponder];
        }];
        
        return false;
    }
    
    if(currentUser().birthday.length==0)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:localizeDOBEmpty() onOK:^{
            [self showDOBPicker];
        }];
        
        return false;
    }
    
    if(currentUser().enumGender==GENDER_NONE)
    {
        [AlertView showAlertOKWithTitle:nil withMessage:localizeGenderEmpty() onOK:^{
            [self showGenderPicker];
        }];
        
        return false;
    }
    
    return true;
}

-(void) endEditing
{
    currentUser().name=txtName.text;
    currentUser().birthday=lblDOB.text;
    currentUser().gender=@(_selectedGender);
}

-(bool) hasChange
{
    if(_selectedAvatar.length>0 && currentUser().avatar.length>0 && ![_selectedAvatar isEqualToString:currentUser().avatar])
        return true;
    else if(_selectedAvatar.length==0 && _avatarImage)
        return true;
    
    return [currentUser() hasChanges];
}

-(void) finishUpdate
{
    [self endEditing];
    
    if(![self validateInput])
        return;
    
    if([self hasChange])
    {
        if(![self validateInput])
            return;
        
        if(_selectedAvatar.length>0)
            _avatarImage=nil;
        
        NSData *avatarBinary=nil;
        if(_avatarImage)
            avatarBinary=UIImageJPEGRepresentation(_avatarImage, 1);
        
        if(avatarBinary)
            [[UserUploadAvatarManager shareInstance] uploadAvatar:avatarBinary userLat:userLat() userLng:userLng()];
        else
            [[UserUploadAvatarManager shareInstance] cancelUpload];
        
        _operationUpdateUserProfile=[[ASIOperationUpdateUserProfile alloc] initWithName:currentUser().name avatar:_selectedAvatar gender:currentUser().enumGender socialType:currentUser().enumSocialType birthday:currentUser().birthday idCity:currentUser().idCity.integerValue];
        _operationUpdateUserProfile.delegatePost=self;
        
        [_operationUpdateUserProfile startAsynchronous];
        
        [self.view showLoading];
    }
    else
    {
        [SGData shareInstance].fScreen=[UserSettingViewController screenCode];
        [self.delegate userSettingControllerFinished:self];
        [self loadData];
    }
}

+(NSString *)screenCode
{
    return SCREEN_CODE_USER_SETTING;
}

-(void)ASIOperaionPostFinished:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUpdateUserProfile class]])
    {
        [self.view removeLoading];
        
        ASIOperationUpdateUserProfile *ope=(ASIOperationUpdateUserProfile*) operation;
        
        if(ope.status==1)
        {
            [[CityManager shareInstance] setIdCitySearch:currentUser().idCity];
            [SGData shareInstance].fScreen=[UserSettingViewController screenCode];
            [self.delegate userSettingControllerFinished:self];
            [self loadData];
        }
        
        _operationUpdateUserProfile=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        [[GUIManager shareInstance] logout];
    }
    else if([operation isKindOfClass:[ASIOperationUploadSocialProfile class]])
    {
        [self.view removeLoading];
        
        ASIOperationUploadSocialProfile *ope=(ASIOperationUploadSocialProfile*) operation;
        
        int status=ope.status;
        
        if(ope.message.length>0)
        {
            [AlertView showAlertOKWithTitle:nil withMessage:ope.message onOK:^{
                if(status==1)
                {
                    [self.delegate userSettingControllerFinished:self];
                    [self loadData];
                }
            }];
        }
        else
        {
            if(status==1)
            {
                [self.delegate userSettingControllerFinished:self];
                [self loadData];
            }
        }
        
        _operationUploadSocialProfile=nil;
    }
}

-(void)ASIOperaionPostFailed:(ASIOperationPost *)operation
{
    if([operation isKindOfClass:[ASIOperationUpdateUserProfile class]])
    {
        [self.view removeLoading];
        _operationUpdateUserProfile=nil;
        
        [[TokenManager shareInstance] setAccessToken:_accessToken];
    }
    else if([operation isKindOfClass:[ASIOperationUploadSocialProfile class]])
    {
        [self.view removeLoading];
        
        _operationUploadSocialProfile=nil;
    }
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    
    [currentUser() revert];
    [SGData shareInstance].fScreen=[UserSettingViewController screenCode];
    [self.delegate userSettingControllerTouchedBack:self];
    [self loadData];
    return;
    
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [self.delegate userSettingControllerTouchedBack:self];
        [self loadData];
        return;
    }
    
    [self.view endEditing:true];
    [self endEditing];
    
    if([self hasChange])
    {
        [AlertView showAlertOKCancelWithTitle:nil withMessage:@"Lưu thay đổi?" onOK:^{
            
            if(![self validateInput])
                return;
            
            [self finishUpdate];
        } onCancel:^{
            [currentUser() revert];
            [SGData shareInstance].fScreen=[UserSettingViewController screenCode];
            [self.delegate userSettingControllerTouchedBack:self];
            [self loadData];
        }];
    }
    else
    {
        [SGData shareInstance].fScreen=[UserSettingViewController screenCode];
        [self.delegate userSettingControllerTouchedBack:self];
        [self loadData];
    }
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    if([self validateAllowEdit])
        [self showAvatars];
}

-(void) showAvatars
{
    AvatarViewController *vc=[[AvatarViewController alloc] initWithAvatars:_avatars avatarImage:_avatarImage];
    vc.delegate=self;
    
    [vc setSelectedAvatar:_selectedAvatar];
    
    _avatarController=vc;
    [_navi pushViewController:vc animated:true];
    
    backView.alpha=0;
    backView.hidden=false;
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        titleView.alpha=0;
        [titleView l_v_setX:-320];
        backView.alpha=1;
        [backView l_v_setX:0];
    } completion:^(BOOL finished) {
        titleView.hidden=true;
    }];
}

-(void)avatarControllerTouched:(AvatarViewController *)controller avatar:(NSString *)avatar avatarImage:(UIImage *)avatarImage
{
    if(avatarImage)
    {
        _avatarImage=avatarImage;
        [imgvAvatar setImage:_avatarImage];
        [imgvBGAvatar setImage:[[_avatarImage blur] convertToGrayscale]];
    }
    else if(avatar.length>0)
    {
        [imgvBGAvatar setImage:nil];
        [imgvAvatar loadAvatarWithURL:avatar completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image)
                [imgvBGAvatar setImage:[[image blur] convertToGrayscale]];
        }];
    }
    
    _selectedAvatar=[NSString stringWithStringDefault:avatar];
    _avatars=[[controller avatars] copy];
    
    [self popNavi];
}

- (IBAction)btnEditDOBTouchUpInside:(id)sender {
    
    if([self validateAllowEdit])
        [self showDOBPicker];
}

- (IBAction)btnEditGenderTouchUpInside:(id)sender {
    if([self validateAllowEdit])
        [self showGenderPicker];
}

- (IBAction)btnEditCityTouchUpInside:(id)sender
{
    if(![self validateAllowEdit])
        return;
    
    CityViewController *vc=[[CityViewController alloc] initWithSelectedIDCity:userIDCity()];
    vc.delegate=self;
    
    [_navi pushViewController:vc animated:true];
}

-(void)cityControllerDidTouchedCity:(CityViewController *)controller idCity:(int)idCity name:(NSString *)name
{
    if(idCity==userIDCity())
        return;
    
    currentUser().idCity=@(idCity);
    lblCity.text=name;
}

- (IBAction)btnLogoutTouchUpInside:(id)sender {
    
    if(currentUser().enumDataMode==USER_DATA_TRY)
    {
        [self.delegate userSettingControllerTouchedBack:self];
        return;
    }
    
    _accessToken=[[TokenManager shareInstance].accessToken copy];
    [[TokenManager shareInstance] setAccessToken:DEFAULT_USER_ACCESS_TOKEN];
    
    _operationUserProfile=[[ASIOperationUserProfile alloc] initOperation];
    _operationUserProfile.delegatePost=self;
    
    [_operationUserProfile startAsynchronous];
    
    [self.view showLoading];
}

-(void) enabledButtons:(bool) enable
{
    btnSetting.userInteractionEnabled=enable;
    btnDone.userInteractionEnabled=enable;
    btnAvatar.userInteractionEnabled=enable;
    txtName.userInteractionEnabled=enable;
    btnLogout.userInteractionEnabled=enable;
    btnEditDOB.userInteractionEnabled=enable;
    btnEditGender.userInteractionEnabled=enable;
    btnTerms.userInteractionEnabled=enable;
}

-(void) showDOBPicker
{
    [self enabledButtons:false];
    
    UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:self.view.frame];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"vi-vn"];
    datePicker.contentMode=UIViewContentModeCenter;
    datePicker.maximumDate=[NSDate date];
    
    [datePicker l_v_setY:(self.l_v_h-datePicker.l_v_h)/2];
    
    if(_selectedDate)
        datePicker.date=_selectedDate;
    
    datePicker.alpha=0;
    [self.view alphaViewWithColor:[UIColor whiteColor]];
    self.view.alphaView.alpha=0;
    self.view.alphaView.userInteractionEnabled=false;
    [self.view addSubview:datePicker];
    
    self.view.userInteractionEnabled=false;
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        datePicker.alpha=1;
        self.view.alphaView.alpha=0.9f;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
    }];
    
    [datePicker addTarget:self action:@selector(dobChanged:) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.cancelsTouchesInView=false;
    tap.delaysTouchesEnded=false;
    tap.delaysTouchesBegan=false;
    tap.delegate=self;
    
    [self.view addGestureRecognizer:tap];
    
    _pickerView=datePicker;
}

-(void) dobChanged:(UIDatePicker*) dob
{
    _selectedDate=dob.date;
    
    if(_selectedDate)
        [lblDOB setText:[_selectedDate stringValueWithFormat:@"dd/MM/yyyy"]];
    else
        [lblDOB setText:@""];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        return !CGRectContainsPoint(CGRectMake(0, 0, _pickerView.l_v_w, _pickerView.l_v_h), [gestureRecognizer locationInView:_pickerView]);
    }
    
    return true;
}

-(void) showGenderPicker
{
    [self enabledButtons:false];
    
    UIPickerView *picker=[[UIPickerView alloc] initWithFrame:self.view.frame];
    picker.dataSource=self;
    picker.delegate=self;
    picker.showsSelectionIndicator=true;
    [picker selectRow:_selectedGender inComponent:0 animated:false];
    
    [picker l_v_setY:(self.l_v_h-picker.l_v_h)/2];
    
    picker.alpha=0;
    [self.view alphaViewWithColor:[UIColor whiteColor]];
    self.view.alphaView.alpha=0;
    self.view.alphaView.userInteractionEnabled=false;
    [self.view addSubview:picker];
    
    self.view.userInteractionEnabled=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        picker.alpha=1;
        self.view.alphaView.alpha=0.9f;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled=true;
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.cancelsTouchesInView=false;
    tap.delaysTouchesEnded=false;
    tap.delaysTouchesBegan=false;
    tap.delegate=self;
    
    [self.view addGestureRecognizer:tap];
    
    _pickerView=picker;
}

-(void) tap:(UITapGestureRecognizer*) tap
{
    if(_pickerView)
    {
        self.view.userInteractionEnabled=false;
        [UIView animateWithDuration:DURATION_DEFAULT animations:^{
            _pickerView.alpha=0;
            self.view.alphaView.alpha=0;
        } completion:^(BOOL finished) {
            [self.view removeAlphaView];
            [_pickerView removeFromSuperview];
            _pickerView=nil;
            self.view.userInteractionEnabled=true;
            
            [self enabledButtons:true];
        }];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return localizeGender(row);
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *lbl=[UILabel new];
    lbl.text=localizeGender(row);
    lbl.font=[UIFont fontWithName:@"Avenir-Roman" size:13];
    lbl.textAlignment=NSTextAlignmentCenter;
    return lbl;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedGender=row;
    [lblGender setText:localizeGender(row)];
}

- (IBAction)btnBackTouchUpInside:(id)sender {
    _avatars=[[_avatarController avatars] copy];
    [self popNavi];
}

-(void) popNavi
{
    [_navi popViewControllerAnimated:true];
    
    titleView.alpha=0;
    titleView.hidden=false;
    
    [UIView animateWithDuration:DURATION_NAVIGATION_PUSH animations:^{
        titleView.alpha=1;
        [titleView l_v_setX:0];
        backView.alpha=0;
        [backView l_v_setX:320];
    } completion:^(BOOL finished) {
        backView.hidden=true;
    }];
}

-(void)dealloc
{
    if(_operationUpdateUserProfile)
    {
        [_operationUpdateUserProfile clearDelegatesAndCancel];
        _operationUpdateUserProfile=nil;
    }
    
    if(_operationUserProfile)
    {
        [_operationUserProfile clearDelegatesAndCancel];
        _operationUserProfile=nil;
    }
    
    if(_operationFBGetProfile)
    {
        [_operationFBGetProfile cancel];
        _operationFBGetProfile=nil;
    }
    
    if(_operationGPGetUserProfile)
    {
        [_operationGPGetUserProfile cancel];
        _operationGPGetUserProfile=nil;
    }
}

- (IBAction)btnFacebookTouchUpInside:(id)sender {
    if([self validateAllowEdit])
        [[FacebookManager shareInstance] login];
}

- (IBAction)btnGooglePlusTouchUpInside:(id)sender {
    
    if(![self validateAllowEdit])
        return;
    
    GPPSignIn *gp = [GPPSignIn sharedInstance];
    gp.clientID=kClientId;
    gp.scopes=@[kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe];
    gp.delegate=self;
    gp.shouldFetchGooglePlusUser=true;
    gp.shouldFetchGoogleUserEmail=true;
    
    if(![gp trySilentAuthentication])
        [gp authenticate];
}

-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if(!error)
    {
        [self.view showLoading];
        
        [GooglePlusManager shareInstance].authentication=auth;
        _operationGPGetUserProfile=[[OperationGPGetUserProfile alloc] initWithAccessToken:auth.accessToken clientID:kClientId];
        _operationGPGetUserProfile.delegate=self;
        
        [_operationGPGetUserProfile start];
    }
}

-(IBAction)btnTermsTouchUpInside:(id)sender
{
    [[GUIManager shareInstance].rootViewController showTerms];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return [self validateAllowEdit];
}

@end
