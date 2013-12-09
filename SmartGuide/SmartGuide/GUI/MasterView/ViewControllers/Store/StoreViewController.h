//
//  StoreViewController.h
//  SmartGuide
//
//  Created by MacMini on 08/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"
#import "StoreShopViewController.h"
#import "SGQRCodeViewController.h"
#import "StoreShopInfoViewController.h"

@class StoreViewController,StoreScrollView;

@protocol StoreControllerDelegate <SGViewControllerDelegate>

-(void) storeControllerTouchedSetting:(StoreViewController*) controller;

@end

@interface StoreViewController : SGViewController<SGQRCodeControllerDelegate,StoreShopControllerDelegate>
{
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *qrView;
    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UIImageView *bgImageView;
    __weak IBOutlet UIView *rayView;
    IBOutlet SGNavigationController *storeNavigation;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnBack;
    
    CGRect _rayViewFrame;
    CGRect _bgViewFrame;
    CGRect _bgImageViewFrame;
}

-(UIView*) rayView;
-(CGRect) rayViewFrame;

-(UIView*) bgView;
-(UIImageView*) bgImageView;
-(CGRect) bgViewFrame;
-(CGRect) bgImageViewFrame;

@property (nonatomic, weak) id<StoreControllerDelegate> delegate;

@end

@interface StoreScrollView : UIScrollView

@end