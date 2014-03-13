//
//  SGUserViewController.h
//  SmartGuide
//
//  Created by MacMini on 19/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "UserNewFeedViewController.h"
#import "UserInfomationViewController.h"
#import "UserHistoryViewController.h"
#import "UserCollectionViewController.h"

@class SGUserViewController;

@protocol UserControllerDelegate <SGViewControllerDelegate>

-(void) userControllerTouchedSetting:(SGUserViewController*) controller;

@end

@interface SGUserViewController : SGViewController<UIActionSheetDelegate,UINavigationControllerDelegate>
{
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIView *midView;
    __weak IBOutlet UIView *botView;
    __weak IBOutlet UILabel *lblTitle;
    __strong IBOutlet SGNavigationController *midNavigation;
    __weak IBOutlet SGViewController *emptyViewController;
    __weak UIViewController *willPopViewControlelr;
}

@property (nonatomic, weak) id<UserControllerDelegate> delegate;

@end
