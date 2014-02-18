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

@class UserPromotionViewController;

@protocol UserPromotionDelegate <SGViewControllerDelegate>

-(void) userPromotionTouchedNavigation:(UserPromotionViewController*) controller;

@end

@interface UserPromotionViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIButton *btnScanSmall;
    __weak IBOutlet UIButton *btnScanBig;
    
    ASIOperationUserPromotion *_operationUserPromotion;
    NSMutableArray *_userPromotions;
    int _page;
    bool _isLoadingMore;
    bool _canLoadingMore;
}

@property (nonatomic, weak) id<UserPromotionDelegate> delegate;

@end
