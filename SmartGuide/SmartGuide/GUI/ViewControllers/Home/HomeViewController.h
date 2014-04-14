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
#import "HomeImagesType9Cell.h"
#import "QRCodeViewController.h"
#import "TextFieldSearch.h"

@class HomeViewController,TableHome;

@protocol HomeControllerDelegate <SGViewControllerDelegate>

-(void) homeControllerTouchedTextField:(HomeViewController*) controller;
-(void) homeControllerTouchedNavigation:(HomeViewController*) controller;
-(void) homeControllerTouchedHome1:(HomeViewController*) contorller home1:(UserHome1*) home1;
-(void) homeControllerTouchedPlacelist:(HomeViewController*) controller home3:(UserHome3*) home3;
-(void) homeControllerFinishedLoad:(HomeViewController*) controller;
-(void) homeControllerTouchedHome8:(HomeViewController*) controller home8:(UserHome8*) home8;
-(void) homeControllerTouchedStore:(HomeViewController*) controller store:(StoreShop*) store;
-(void) homeControllerTouchedIDShop:(HomeViewController*) controller idShop:(int) idShop;

@end

@interface HomeViewController : SGViewController<UITextFieldDelegate,ASIOperationPostDelegate,UITableViewDataSource,UITableViewDelegate,QRCodeControllerDelegate>
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIView *displayLoadingView;
    __weak IBOutlet TableHome *tableFeed;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet UIView *blackView;
    __weak IBOutlet UIImageView *blurBottom;
    __weak IBOutlet UIButton *btnNumOfNotification;
    
    ASIOperationUserHome *_operationUserHome;
    NSMutableArray *_homes;
    NSMutableArray *_ads;
    
    bool _isFinishedLoadData;
    
    int _page;
    bool _isLoadingMore;
    bool _canLoadMore;
    
    CGRect _qrFrame;
    CGRect _blurBottomFrame;
    CGRect _buttonScanBigFrame;
    CGRect _buttonScanSmallFrame;
    __weak IBOutlet TextFieldSearch *txtAni;
    float _startAngleY;
}

@property (nonatomic, assign) id<HomeControllerDelegate> delegate;
@property (nonatomic, readonly) CLLocationCoordinate2D homeLocation;

@end

@interface TableHome : UITableView
{
    CGPoint _offset;
}

-(CGPoint) offset;

@end

@interface HomeBGView : UIView

@end