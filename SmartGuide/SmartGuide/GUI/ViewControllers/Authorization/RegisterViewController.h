//
//  RegisterViewController.h
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "RegisterInfoStep1ViewController.h"
#import "RegisterInfoStep2ViewController.h"
#import "FacebookManager.h"
#import "OperationFBGetProfile.h"
#import "OperationGPGetUserProfile.h"
#import "ASIOperationUploadSocialProfile.h"
#import "ASIOperationUpdateUserProfile.h"
#import <GooglePlus/GooglePlus.h>

@class AuthorizationViewController;
@class RegisterViewController;
@class RegisterInfo;

@protocol RegisterControllerDelegate <SGViewControllerDelegate>

-(void) registerControllerFinished:(RegisterViewController*) controller;

@end

@interface RegisterViewController : SGViewController<RegisterInfoStep1Contorller,OperationURLDelegate,ASIOperationPostDelegate>
{
    __weak IBOutlet UIButton *btnConfirm;
    __weak IBOutlet UIButton *btnFacebook;
    __weak IBOutlet UIButton *btnGooglePlus;
    __weak IBOutlet UIView *containNavi;
    __weak IBOutlet UIButton *btnStep1;
    __weak IBOutlet UIButton *btnStep2;
    __weak IBOutlet UIView *stepView;
    __weak IBOutlet UIButton *btnCreate;
    __weak IBOutlet UIView *socialView;
    __weak IBOutlet UIView *registerView;
    __weak IBOutlet UIView *displayPickerView;
    
    __weak SGNavigationController *registerNavi;
    
    __weak RegisterInfoStep1ViewController *registerStep1;
    __weak RegisterInfoStep2ViewController *registerStep2;
    
    RegisterInfo *_registerInfo;
    
    OperationFBGetProfile *_operationFBGetProfile;
    OperationGPGetUserProfile *_operationGPGetUserProfile;
    ASIOperationUploadSocialProfile *_operationUploadSocialProfile;
    ASIOperationUpdateUserProfile *_operationUpdateUserProfile;
    
    NSMutableArray *_avatars;
    
    bool _isShowedDatePicker;
    __weak UIDatePicker *_datePicker;
}

-(UIButton*) buttonNext;

-(UIDatePicker*) showDatePicker;
-(void) removeDatePicker;
-(bool) isShowedDatePicker;

-(RegisterInfo*) registerInfo;

@property (nonatomic, weak) AuthorizationViewController *authorizationController;
@property (nonatomic, weak) id<RegisterControllerDelegate> delegate;

@end

@interface RegisterInfo : NSObject

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) UIImage *selectedAvatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) enum GENDER_TYPE gender;
@property (nonatomic, strong) NSDate *selectedDate;

@end