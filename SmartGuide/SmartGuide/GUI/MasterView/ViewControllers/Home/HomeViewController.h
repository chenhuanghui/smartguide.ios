//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "ASIOperationUserHome.h"
#import "HomePromotionCell.h"
#import "HomeImagesCell.h"
#import "HomeListCell.h"
#import "HomeInfoCell.h"
#import "ASIOperationShopUser.h"

@class HomeViewController,TableHome;

@protocol HomeControllerDelegate <SGViewControllerDelegate>

-(void) homeControllerTouchedTextField:(HomeViewController*) controller;
-(void) homeControllerTouchedNavigation:(HomeViewController*) controller;
-(void) homeControllerTouchedHome1:(HomeViewController*) contorller home1:(UserHome1*) home1;
-(void) homeControllerTouchedPlacelist:(HomeViewController*) controller home3:(UserHome3*) home3;

@end

@interface HomeViewController : SGViewController<UITextFieldDelegate,ASIOperationPostDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIView *displayLoadingView;
    __weak IBOutlet TableHome *tableFeed;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIView *blackView;
    __weak IBOutlet UIImageView *blurBottom;
    
    ASIOperationUserHome *_operationUserHome;
    ASIOperationShopUser *_operationShopUser;
    NSMutableArray *_homes;
    NSMutableArray *_ads;
    
    int _page;
    bool _isLoadingMore;
    bool _canLoadMore;
    
    CGRect _qrFrame;
    CGRect _blurBottomFrame;
}

@property (nonatomic, assign) id<HomeControllerDelegate> delegate;

@end

@interface TableHome : UITableView
{
    CGPoint _offset;
}

-(CGPoint) offset;

@end

@interface HomeBGView : UIView

@end