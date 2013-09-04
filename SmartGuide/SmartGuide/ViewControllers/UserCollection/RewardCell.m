//
//  RewardCell.m
//  SmartGuide
//
//  Created by XXX on 8/26/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "RewardCell.h"
#import "Utility.h"
#import "UIImageView+AFNetworking.h"
#import "Constant.h"

@implementation RewardCell
@synthesize delegate;

- (IBAction)btnTouchUpInside:(id)sender {
    [delegate rewardCellRequestReward:self];
}

-(void)setReward:(Reward *)reward totalPoint:(int)totalPoint
{
    _reward=reward;
    
    lblRewardName.font=[UIFont boldSystemFontOfSize:12];
    lblRewardName.textColor=[UIColor whiteColor];
    lblRewardName.backgroundColor=[UIColor clearColor];
    [imgvReward setSmartGuideImageWithURL:[NSURL URLWithString:reward.thumbnail] placeHolderImage:UIIMAGE_LOADING_REWARD success:nil failure:nil];
    lblPoint.text=[[NSNumberFormatter numberFromNSNumber:reward.score] stringByAppendingString:@" point"];
    lblRewardName.text=reward.content;
    btn.enabled=reward.status.boolValue;
    
    btn.alpha=btn.enabled?1:0.5f;
    
    [lblRewardName scrollLabelIfNeeded];
}

-(Reward *)reward
{
    return _reward;
}

+(NSString *)reuseIdentifier
{
    return @"RewardCell";
}

+(CGSize)size
{
    return CGSizeMake(200, 46);
}

@end
