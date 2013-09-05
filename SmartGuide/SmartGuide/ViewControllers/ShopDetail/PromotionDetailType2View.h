//
//  PromotionDetailType2View.h
//  SmartGuide
//
//  Created by XXX on 8/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopDetailViewController.h"
#import "ASIOperationGetRewardPromotionType2.h"
#import "FTCoreTextView.h"

@interface PromotionDetailType2View : UIView<PromotionDetailHandle,ASIOperationPostDelegate>
{
    __weak IBOutlet UIButton *btnReward;
    __weak IBOutlet FTCoreTextView *lblDesc;
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet FTCoreTextView *lblP;
    
    ASIOperationGetRewardPromotionType2 *_operation;
    
    __weak Shop *_shop;
}

-(PromotionDetailType2View*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

@end
