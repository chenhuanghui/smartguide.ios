//
//  SettingViewController.h
//  SmartGuide
//
//  Created by XXX on 7/17/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "SDNestedTableViewController.h"
#import "SwitchSetting.h"
#import "FeedbackView.h"
#import "TutorialView.h"
#import "RootViewController.h"
#import "FrontViewController.h"
#import "ShopDetailViewController.h"
#import "IntroView.h"

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SwitchSettingDelegate,FeedbackViewDelegate,TutorialViewDelegate,IntroViewDelegate>
{
    NSMutableArray *_settings;
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet UILabel *lblPoint;
    __weak IBOutlet UILabel *lblSGP;
    __weak IBOutlet SwitchSetting *switchLocation;
    __weak IBOutlet UILabel *lblAddress;
    __weak IBOutlet UITableView *tableSetting;
    __weak IBOutlet UIView *containAvatar;
    __weak IBOutlet UILabel *lblCity;
    __weak IBOutlet UIView *containView;
    
    bool _isShowOtherView;
}

-(void) loadSetting;
-(bool) isShowOtherView;

@end