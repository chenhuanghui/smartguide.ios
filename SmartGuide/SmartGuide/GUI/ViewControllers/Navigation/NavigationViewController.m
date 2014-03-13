//
//  SGSettingViewController.m
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "NavigationViewController.h"
#import "DataManager.h"

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
    [self.delegate navigationTouchedUserSetting:self];
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
    [self.delegate navigationTouchedTutorial:self];
}

@end
