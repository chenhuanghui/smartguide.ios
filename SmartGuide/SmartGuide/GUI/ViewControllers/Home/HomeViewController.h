//
//  ShopCategoriesViewController.h
//  SmartGuide
//
//  Created by MacMini on 25/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class HomeViewController,TableHome, UserHome1, UserHome3, UserHome8, HomeTextField, Placelist, Shop;

@protocol HomeControllerDelegate <SGViewControllerDelegate>

-(void) homeControllerTouchedSearch:(HomeViewController*) controller;
-(void) homeControllerTouchedNavigation:(HomeViewController*) controller;
-(void) homeControllerTouched:(HomeViewController*) controller placeList:(Placelist*) placelist;
-(void) homeControllerTouched:(HomeViewController*) controller shop:(Shop*) shop;
-(void) homeControllerTouched:(HomeViewController*) controller idShops:(NSString*) idShops;
-(void) homeControllerTouched:(HomeViewController*) controller idPlacelist:(int) idPlacelist;
-(void) homeControllerTouched:(HomeViewController*) controller idShop:(int) idShop;

@end

@interface HomeViewController : SGViewController
{
    __weak IBOutlet HomeTextField *txtRefresh;
    __weak IBOutlet UIView *displayLoadingView;
    __weak IBOutlet TableHome *tableFeed;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet UIImageView *blurBottom;
    __weak IBOutlet UIButton *btnNumOfNotification;
    __weak IBOutlet UIButton *btnNotification;
    __weak IBOutlet UIImageView *imgvLogo;
    
    NSMutableArray *_homeSections;
    NSMutableArray *_homesAPI;
    
    int _page;
    bool _isLoadingMore;
    bool _canLoadMore;
    
    CGRect _qrFrame;
    CGRect _blurBottomFrame;
    CGRect _buttonScanBigFrame;
    CGRect _buttonScanSmallFrame;
    CGRect _textFieldFrame;
    CGRect _logoFrame;
    CGRect _tableFrame;
    
    float _scrollDistanceHeight;
    bool _isTouchedTextField;
    
    bool _isRegisterNotificationUserNotice;
}

@property (nonatomic, weak) id<HomeControllerDelegate> delegate;

@end

@interface TableHome : UITableView
{
}

@end

@interface HomeBGView : UIView

@end