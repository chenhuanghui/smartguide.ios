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
#import "ASIOperationGetTotalSP.h"
#import "UpdateVersion.h"

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SwitchSettingDelegate,FeedbackViewDelegate,TutorialViewDelegate,IntroViewDelegate,ASIOperationPostDelegate,UpdateVersionDelegate>
{
    NSMutableArray *_settings;
    __weak IBOutlet UIImageView *avatar;
//    __weak IBOutlet UILabel *lblSP;
    __weak IBOutlet SwitchSetting *switchLocation;
    __weak IBOutlet UITableView *tableSetting;
    __weak IBOutlet UIView *containAvatar;
    __weak IBOutlet UILabel *lblCity;
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UILabel *lblName;
    
    bool _isShowOtherView;
//    ASIOperationGetTotalSP *getTotalSP;
}

-(void) loadSetting;
-(bool) isShowOtherView;

@end