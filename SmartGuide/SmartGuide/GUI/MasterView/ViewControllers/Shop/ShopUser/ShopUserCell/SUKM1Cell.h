//
//  SUKM1Cell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopKM1Cell.h"
#import "FTCoreTextView.h"
#import "ShopKM1.h"
#import "KM1Voucher.h"

@interface SUKM1Cell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIView *bgStatusView;
    __weak IBOutlet FTCoreTextView *lbl100K;
    __weak IBOutlet FTCoreTextView *lblSP;
    __weak IBOutlet FTCoreTextView *lblP;
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UILabel *lblSGP;
    __weak IBOutlet UIButton *btnReward;
    __weak IBOutlet UILabel *lblNotice;
    
    __weak ShopKM1* _km1;
}

-(void) loadWithKM1:(ShopKM1*) km1;

+(NSString *)reuseIdentifier;
+(float) heightWithKM1:(ShopKM1*) km1;

@end

@interface PromotionDetailView : UIView
{
    UIImage *img;
}

@end