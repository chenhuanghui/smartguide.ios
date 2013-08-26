//
//  RewardCell.h
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reward.h"
#import "CBAutoScrollLabel.h"

@class RewardCell;

@protocol RewardCellDelegate <NSObject>

-(void) rewardCellRequestReward:(RewardCell*) cell;

@end

@interface RewardCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvReward;
    __weak IBOutlet CBAutoScrollLabel *lblRewardName;
    __weak IBOutlet UILabel *lblPoint;
    __weak IBOutlet UIButton *btn;
    
    __weak Reward *_reward;
}

-(void) setReward:(Reward*) reward totalPoint:(int) totalPoint;
-(Reward*) reward;

+(NSString *)reuseIdentifier;
+(CGSize) size;

@property (nonatomic, assign) id<RewardCellDelegate> delegate;

@end
