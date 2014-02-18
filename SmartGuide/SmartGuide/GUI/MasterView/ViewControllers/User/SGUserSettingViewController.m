//
//  SGUserSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGUserSettingViewController.h"
#import "DataManager.h"

@interface SGUserSettingViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate,AvatarControllerDelegate>

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
    
    [btnAvatar loadImage:currentUser().avatar onCompleted:^(UIImage *image) {
        if(image)
            [imgvBGAvatar setImage:[[image blur] convertToGrayscale]];
    }];
    
    [txtName setText:currentUser().name];
    [lblDOB setText:currentUser().birthday];
    [lblGender setText:localizeGender(currentUser().gender.integerValue)];
    
    [contentView addSubview:_navi.view];
    _avatars=[NSMutableArray new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDoneTouchUpInside:(id)sender {
    [self.delegate userSettingControllerTouchedClose:self];
}

- (IBAction)btnSettingTouchUpInside:(id)sender {
    [self.delegate userSettingControllerTouchedSetting:self];
}

- (IBAction)btnAvatarTouchUpInside:(id)sender {
    AvatarViewController *vc=[[AvatarViewController alloc] initWithAvatars:_avatars avatarImage:nil];
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
        [btnAvatar setDefaultImage:_avatarImage highlightImage:_avatarImage];
        [imgvBGAvatar setImage:[[_avatarImage blur] convertToGrayscale]];
    }
    else if(avatar.length>0)
    {
        [imgvBGAvatar setImage:nil];
        [btnAvatar loadImage:avatar onCompleted:^(UIImage *image) {
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
        [lblDOB setText:[NSString stringWithFormat:@"%02i tháng %02i năm %i",_selectedDate.day,_selectedDate.month,_selectedDate.year]];
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

@end
