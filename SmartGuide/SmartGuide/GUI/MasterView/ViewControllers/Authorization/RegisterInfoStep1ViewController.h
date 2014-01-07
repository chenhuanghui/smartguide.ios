//
//  RegisterInfoStep1ViewController.h
//  SmartGuide
//
//  Created by MacMini on 07/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class RegisterInfoStep1ViewController;

@protocol RegisterInfoStep1Contorller <SGViewControllerDelegate>

-(void) registerInfoStep1ControllerTouchedAvatar:(RegisterInfoStep1ViewController*) contorller;

@end

@interface RegisterInfoStep1ViewController : SGViewController
{
    __weak IBOutlet UIButton *btnAvatar;
    __weak IBOutlet UITextField *txt;
    NSString *_avatar;
    UIImage *_avatarImage;
}

-(NSString*) avatar;
-(UIImage*) avatarImage;
-(NSString*) name;

-(void) setAvatar:(NSString*) avatar;
-(void) setAvatarImage:(UIImage*) avatar;

-(void) focusName;

@property (nonatomic, weak) id<RegisterInfoStep1Contorller> delegate;

@end