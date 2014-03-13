//
//  SGSearchController.h
//  SmartGuide
//
//  Created by MacMini on 25/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "SGNavigationController.h"

@class SGShopSearchController;

@protocol ShopSearchControllerDelegate <SGViewControllerDelegate>

-(void) shopSearchControllerTouchedSetting:(SGShopSearchController*) controller;

@end

@interface SGShopSearchController : SGViewController<UITextFieldDelegate>
{
    __weak IBOutlet UIView *searchbarView;
    __weak IBOutlet UIView *displaySearchView;
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UITextField *txtSearch;
    __weak IBOutlet UIButton *btnSetting;
    __weak IBOutlet UIButton *btnCancel;
}


@property (weak, nonatomic) IBOutlet SGNavigationController *childNavigationController;
@property (nonatomic, weak) id<ShopSearchControllerDelegate> delegate;

@end
