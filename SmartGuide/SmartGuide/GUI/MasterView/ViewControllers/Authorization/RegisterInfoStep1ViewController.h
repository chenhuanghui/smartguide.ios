//
//  RegisterInfoStep1ViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class RegisterInfoStep1ViewController,RegisterViewController;

@protocol RegisterInfoStep1Contorller <SGViewControllerDelegate>

-(void) registerInfoStep1ControllerTouchedAvatar:(RegisterInfoStep1ViewController*) contorller;

@end

@interface RegisterInfoStep1ViewController : SGViewController
{
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UITextField *txt;
    NSString *_avatar;
    UIImage *_avatarImage;
    __weak IBOutlet UIButton *btnSelectAvatar;
    __weak IBOutlet UIButton *btnName;
}

-(NSString*) avatar;
-(UIImage*) avatarImage;
-(NSString*) name;

-(void) setAvatar:(NSString*) avatar;
-(void) setAvatarImage:(UIImage*) avatar;

-(void) focusName;

-(void) setAvatars:(NSMutableArray*) avatars avatarImage:(UIImage*) avatarImage;

@property (nonatomic, weak) id<RegisterInfoStep1Contorller> delegate;
@property (nonatomic, weak) RegisterViewController *registerController;

@end