//
//  UserPromotionViewController.h
//  SmartGuide
//
//  Created by MacMini on 17/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "HomeInfoCell.h"
#import "ASIOperationUserPromotion.h"
#import "TextFieldSearch.h"

@class UserPromotionViewController,TableUserPromotion;

@protocol UserPromotionDelegate <SGViewControllerDelegate>

-(void) userPromotionTouchedNavigation:(UserPromotionViewController*) controller;
-(void) userPromotionTouchedIDShops:(UserPromotionViewController*) controller idShops:(NSString*) idShops;
-(void) userPromotionTouchedTextField:(UserPromotionViewController*) controller;

@end

@interface UserPromotionViewController : SGViewController
{
    __weak IBOutlet TableUserPromotion *table;
    __weak IBOutlet TextFieldSearch *txt;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet UIButton *btnScanBig;
    __weak IBOutlet UIImageView *imgvBlurBottom;
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIButton *btnNumOfNotification;
    __weak IBOutlet UIButton *btnNotification;
    
    CGRect _qrFrame;
    CGRect _buttonScanBigFrame;
    CGRect _buttonScanSmallFrame;
    CGRect _blurBottomFrame;
    CGRect _textFieldFrame;
    CGRect _logoFrame;
    
    ASIOperationUserPromotion *_operationUserPromotion;
    NSMutableArray *_userPromotions;
    int _page;
    bool _isLoadingMore;
    bool _canLoadingMore;
    
    float _txtPerWidth;
    float _scrollPerY;
    float _scrollDistanceHeight;
    float _startYAngle;
    
    bool _isCanRefresh;
    bool _isAPIFinished;
    bool _isUserReleaseTouched;
    bool _isTrackingTouch;
    bool _isTouchedTextField;
}

@property (nonatomic, weak) id<UserPromotionDelegate> delegate;

@end

@interface TableUserPromotion : UITableView
{
}

@property (nonatomic, assign) float maxY;

@end