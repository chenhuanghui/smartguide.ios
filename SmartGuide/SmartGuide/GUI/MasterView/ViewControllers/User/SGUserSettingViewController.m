//
//  SGUserSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserSettingViewController.h"
#import "DataManager.h"
#import "TokenManager.h"
#import "GUIManager.h"

@interface SGUserSettingViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,AvatarControllerDelegate,ASIOperationPostDelegate>

@end

@implementation SGUserSettingViewController
@synthesize delegate;

- (id)init
{
    self = [super initWithNibName:@"SGUserSettingViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [imgvAvatar loadAvatarWithURL:currentUser().avatar completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image)
            [imgvBGAvatar setImage:[[image blur] convertToGrayscale]];
    }];
    
    [txtName setText:currentUser().name];
    [lblDOB setText:currentUser().birthday];
    [lblGender setText:localizeGender(currentUser().gender.integerValue)];
    _selectedGender=currentUser().gender.integerValue;
    _selectedAvatar=currentUser().avatar;
    
    [contentView addSubview:_navi.view];
    [_navi l_v_setH:contentView.l_v_h];
    
    _avatars=[NSMutableArray new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
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
        
        _operationUpdateUserProfile=[[ASIOperationUpdateUserProfile alloc] initWithName:currentUser().name cover:nil avatar:_selectedAvatar avatarImage:avatarBinary gender:currentUser().enumGender socialType:currentUser().enumSocialType birthday:currentUser().birthday];
        _operationUpdateUserProfile.delegatePost=self;
        
        [_operationUpdateUserProfile startAsynchronous];
        
        [self.view showLoading];
    }
    else
    {
        [SGData shareInstance].fScreen=[SGUserSettingViewController screenCode];
        [self.delegate userSettingControllerFinished:self];
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
            [SGData shareInstance].fScreen=[SGUserSettingViewController screenCode];
            [self.delegate userSettingControllerFinished:self];
        }
        
        _operationUpdateUserProfile=nil;
    }
    else if([operation isKindOfClass:[ASIOperationUserProfile class]])
    {
        [[GUIManager shareInstance] logout];
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
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
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
            [SGData shareInstance].fScreen=[SGUserSettingViewController screenCode];
            [self.delegate userSettingControllerTouchedSetting:self];
        }];
    }
    else
    {
        [SGData shareInstance].fScreen=[SGUserSettingViewController screenCode];
        [self.delegate userSettingControllerTouchedSetting:self];
    }
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
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
    [self showDOBPicker];
}

- (IBAction)btnEditGenderTouchUpInside:(id)sender {
    [self showGenderPicker];
}

- (IBAction)btnLogoutTouchUpInside:(id)sender {
    _accessToken=[[TokenManager shareInstance].accessToken copy];
    [[TokenManager shareInstance] setAccessToken:DEFAULT_USER_ACCESS_TOKEN];
    
    _operationUserProfile=[[ASIOperationUserProfile alloc] initOperation];
    _operationUserProfile.delegatePost=self;
    
    [_operationUserProfile startAsynchronous];
    
    [self.view showLoading];
}

-(void) showDOBPicker
{
    UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:self.view.frame];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"vi-vn"];
    datePicker.contentMode=UIViewContentModeCenter;
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
        self.view.alphaView.alpha=0.7f;
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
    UIPickerView *picker=[[UIPickerView alloc] initWithFrame:self.view.frame];
    picker.dataSource=self;
    picker.delegate=self;
    picker.showsSelectionIndicator=true;
    
    [picker l_v_setY:(self.l_v_h-picker.l_v_h)/2];
    
    picker.alpha=0;
    [self.view alphaViewWithColor:[UIColor whiteColor]];
    self.view.alphaView.alpha=0;
    self.view.alphaView.userInteractionEnabled=false;
    [self.view addSubview:picker];
    
    self.view.userInteractionEnabled=false;
    
    [UIView animateWithDuration:DURATION_DEFAULT animations:^{
        picker.alpha=1;
        self.view.alphaView.alpha=0.7f;
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
}

@end
