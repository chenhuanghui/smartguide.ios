//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ASIOperationUserHome.h"
#import "NewFeedPromotionCell.h"
#import "NewFeedImagesCell.h"
#import "NewFeedListCell.h"
#import "NewFeedInfoCell.h"
#import "ASIOperationShopUser.h"

@class NewFeedViewController;

@protocol NewFeedControllerDelegate <SGViewControllerDelegate>

-(void) newFeedControllerTouchedTextField:(NewFeedViewController*) controller;
-(void) newFeedControllerTouchedNavigation:(NewFeedViewController*) controller;
-(void) newFeedControllerTouchedHome1:(NewFeedViewController*) contorller home1:(UserHome1*) home1;
-(void) newFeedControllerTouchedPlacelist:(NewFeedViewController*) controller home3:(UserHome3*) home3;

@end

@interface NewFeedViewController : SGViewController<UITextFieldDelegate,ASIOperationPostDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIView *displayLoadingView;
    __weak IBOutlet UITableView *tableFeed;
    __weak IBOutlet UITableView *tableAds;
    __weak IBOutlet UIView *adsView;
    __weak IBOutlet UIView *qrView;
    
    ASIOperationUserHome *_operationUserHome;
    ASIOperationShopUser *_operationShopUser;
    NSMutableArray *_homes;
    NSMutableArray *_ads;
    
    int _page;
    bool _isLoadingMore;
    bool _canLoadMore;
    
    CGRect _adsFrame;
    CGRect _qrFrame;
}

@property (nonatomic, assign) id<NewFeedControllerDelegate> delegate;

@end
