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
    
    [imgvAvatar loadAvatarWithURL:currentUser().avatar completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if(image)
            [imgvBGAvatar setImage:[[image blur] convertToGrayscale]];
    }];
    
    lblName.text=currentUser().name;
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
    [self.delegate settingTouchedStore:self];
}

- (IBAction)otherView:(id)sender {
    [self.delegate settingTouchedOtherView:self];
}

- (IBAction)btnPromotionTouchUpInside:(id)sender {
    [self.delegate settingTouchedPromotion:self];
}

@end
