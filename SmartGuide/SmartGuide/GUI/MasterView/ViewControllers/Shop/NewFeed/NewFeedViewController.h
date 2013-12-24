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

@class NewFeedViewController;

@protocol NewFeedControllerDelegate <SGViewControllerDelegate>

-(void) newFeedControllerTouchedTextField:(NewFeedViewController*) controller;
-(void) newFeedControllerTouchedNavigation:(NewFeedViewController*) controller;

@end

@interface NewFeedViewController : SGViewController<UITextFieldDelegate,ASIOperationPostDelegate,UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet UIView *displayLoadingView;
    __weak IBOutlet UITableView *table;
    
    ASIOperationUserHome *_operationUserHome;
    NSMutableArray *_homes;
    int _page;
    bool _isLoadingMore;
    bool _canLoadMore;
}

@property (nonatomic, assign) id<NewFeedControllerDelegate> delegate;

@end
