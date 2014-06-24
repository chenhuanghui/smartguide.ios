//
//  SGSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NavigationViewController.h"
#import "DataManager.h"
#import "GUIManager.h"
#import "WebViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController
@synthesize delegate,slideView;

- (id)init
{
    self = [super initWithNibName:@"NavigationViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [btnUpdate setTitle:[@"v" stringByAppendingString:SMARTUIDE_VERSION] forState:UIControlStateNormal];
    lblVersion.text=[@"v" stringByAppendingString:SMARTUIDE_VERSION];
    
    [self loadData];
}

-(void)loadData
{
    [imgvAvatar loadUserAvatar:currentUser() onCompleted:^(UIImage *avatar, UIImage *avatarBlurr) {
        if(avatarBlurr)
            [imgvBGAvatar setImage:avatarBlurr];
    }];
    
    lblName.text=[currentUser().name uppercaseString];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SGData shareInstance].fScreen=[NavigationViewController screenCode];
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

- (IBAction)btnHomeTouchUpInside:(id)sender {
    [self.delegate navigationTouchedHome:self];
}

-(IBAction)btnUserSettingTouchUpInside:(id)sender {
    
    switch (currentUser().enumDataMode) {
        case USER_DATA_TRY:
        {
            [[GUIManager shareInstance] showLoginDialogWithMessage:localizeLoginRequire() onOK:^{
                btnUserSetting.userInteractionEnabled=false;
            } onCancelled:^{
                btnUserSetting.userInteractionEnabled=true;
            } onLogined:^(bool isLogined) {
                btnUserSetting.userInteractionEnabled=true;
                
                if(isLogined)
                {
                    [self.delegate navigationTouchedUserSetting:self];
                }
            }];
        }
            break;
            
        case USER_DATA_CREATING:
        case USER_DATA_FULL:
            [self.delegate navigationTouchedUserSetting:self];
            break;
    }
}

- (IBAction)btnStoreTouchUpInside:(id)sender {
    
    [AlertView showAlertOKWithTitle:nil withMessage:@"Sẽ xuất hiện trong phiên bản kế tiếp!" onOK:nil];
    return;
    
    [self.delegate navigationTouchedStore:self];
}

- (IBAction)btnPromotionTouchUpInside:(id)sender {
    [self.delegate navigationTouchedPromotion:self];
}

- (IBAction)btnTutorialTouchUpInside:(id)sender {

    WebViewController *vc=[[WebViewController alloc] initWithURL:URL(URL_TUTORIAL)];
    [[GUIManager shareInstance].rootNavigation presentSGViewController:vc animate:true completion:^{
        
        CGRect rect=[GUIManager shareInstance].rootViewController.view.frame;
        
        if(NSFoundationVersionNumber<=NSFoundationVersionNumber_iOS_6_1)
            rect.origin.y=UIStatusBarHeight();
        else
            rect.origin.y=0;
        
        vc.view.frame=rect;
    }];
}

@end
