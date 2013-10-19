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
#import "PopupGiftPromotion2.h"
#import "FTCoreTextView.h"

@interface PromotionDetailType2View : UIView<PromotionDetailHandle,PopupGiftPromotionDelegate>
{
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UIButton *btnReward;
    __weak IBOutlet UIButton *btnListReward;
    __weak IBOutlet FTCoreTextView *lblP;
    

    __weak Shop *_shop;
    
    UIView *_rootView;
}

-(PromotionDetailType2View*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;

- (IBAction)bntRewardTouchUpInside:(id)sender;
- (IBAction)btnListRewardTouchUpInside:(id)sender;

@end
