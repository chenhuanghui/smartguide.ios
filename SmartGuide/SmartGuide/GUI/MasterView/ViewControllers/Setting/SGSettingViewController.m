//
//  SGSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGSettingViewController.h"
#import "DataManager.h"

@interface SGSettingViewController ()

@end

@implementation SGSettingViewController
@synthesize delegate,slideView;

- (id)init
{
    self = [super initWithNibName:@"SGSettingViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [imgvAvatar loadUserAvatar:currentUser() onCompleted:^(UIImage *avatar, UIImage *avatarBlurr) {
        if(avatarBlurr)
            [imgvBGAvatar setImage:avatarBlurr];
    }];
    
    lblName.text=[currentUser().name uppercaseString];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SGData shareInstance].fScreen=[SGSettingViewController screenCode];
}

+(NSString *)screenCode
{
    return SCREEN_CODE_NAVIGATION;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUserTouchUpInside:(id)sender {
    [self.delegate settingTouchedUser:self];
}

- (IBAction)btnHomeTouchUpInside:(id)sender {
    [self.delegate settingTouchedCatalog:self];
}

-(IBAction)btnUserSettingTouchUpInside:(id)sender {
    [self.delegate settingTouchedUserSetting:self];
}

- (IBAction)btnStoreTouchUpInside:(id)sender {
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Sẽ xuất hiện trong phiên bản kế tiếp!" onOK:nil];
    return;
    
    [self.delegate settingTouchedStore:self];
}

- (IBAction)btnPromotionTouchUpInside:(id)sender {
    [self.delegate settingTouchedPromotion:self];
}

- (IBAction)btnTutorialTouchUpInside:(id)sender {
    [self.delegate settingTouchedTutorial:self];
}

@end
