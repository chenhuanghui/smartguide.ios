//
//  UserCollectionViewController.h
//  SmartGuide
//
//  Created by XXX on 8/7/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ViewController.h"
#import "ASIOperationUserCollection.h"
#import "TableTemplate.h"
#import "RewardCell.h"
#import "Reward.h"
#import "ASIOperationGetRewards.h"
#import "ASIOperationSGToReward.h"
#import "ASIOperationGetSG.h"

@interface UserCollectionViewController : ViewController<ASIOperationPostDelegate,TableTemplateDelegate,RewardCellDelegate>
{
    __weak IBOutlet UILabel *lblPoint;
    __weak IBOutlet UIButton *btnPoint;
    __weak IBOutlet UIImageView *avatar;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UITableView *tableReward;
    ASIOperationUserCollection *_operation;
    ASIOperationGetRewards *_getRewards;
    TableTemplate *templateTable;
    TableTemplate *templateReward;
    __weak IBOutlet UIView *blurTop;
    __weak IBOutlet UIView *blurBottom;
    
    int _totalPoint;
}

-(void) loadUserCollection;

@end

@interface UserCollectionView : UIView

@end