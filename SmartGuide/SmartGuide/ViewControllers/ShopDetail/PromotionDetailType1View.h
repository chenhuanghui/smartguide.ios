//
//  PromotionDetailView.h
//  SmartGuide
//
//  Created by XXX on 8/1/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"
#import "ShopDetailViewController.h"
#import "ASIOperationSGPToReward.h"
#import "FTCoreTextView.h"

@interface PromotionDetailType1View : UIView<UITableViewDataSource,UITableViewDelegate,PromotionDetailHandle,ASIOperationPostDelegate>
{
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UILabel *lblSgp;
    __weak IBOutlet UITableView *tableRank;
    __weak Shop *_shop;
    __weak IBOutlet FTCoreTextView *lblSP;
    __weak IBOutlet FTCoreTextView *lblP;
    __weak IBOutlet FTCoreTextView *lblCost;
    
    bool _isNeedAnimaionScore;
    
    NSNumberFormatter *_scoreFormater;
    bool _isAnimatingScore;
}

-(PromotionDetailType1View*) initWithShop:(Shop*) shop;
-(void) setShop:(Shop*) shop;
-(void) setSGP:(double) sgp;
-(void) animationScore;
-(void) setNeedAnimationScore;

@end
