//
//  StoreShopInfoViewController.h
//  SmartGuide
//
//  Created by MacMini on 09/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGViewController.h"
#import "StoreShopItemCell.h"
#import "GMGridView.h"
#import "SGScrollView.h"

@class StoreShopInfoScrollView,StoreShopInfoViewController,StoreViewController;

@interface StoreShopInfoViewController : SGViewController<GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate>
{
    __weak IBOutlet StoreShopInfoScrollView *scroll;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet GMGridView *grid;
    __weak IBOutlet UILabel *lblNameBot;
    
    CGRect _gridFrame;
    CGRect _lblNameBotFrame;
}

-(void) prepareOnBack;

@property (nonatomic, weak) StoreViewController *storeController;

@end

@interface StoreShopInfoScrollView : SGScrollView
{
}

@end