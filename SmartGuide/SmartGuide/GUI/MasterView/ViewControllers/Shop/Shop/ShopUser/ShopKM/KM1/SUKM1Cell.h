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

@class SUKM1Cell;

@protocol SUKM1Delegate <NSObject>

-(void) km1TouchedScan:(SUKM1Cell*) km1;

@end

@interface SUKM1Cell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet FTCoreTextView *lbl100K;
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UIButton *btnFirstScan;
    __weak IBOutlet UIView *hasSGPView;
    __weak IBOutlet UILabel *lblText;
    
    __weak ShopKM1* _km1;
}

-(void) loadWithKM1:(ShopKM1*) km1;

+(NSString *)reuseIdentifier;
+(float) heightWithKM1:(ShopKM1*) km1;

@property (nonatomic, weak) id<SUKM1Delegate> delegate;

@end