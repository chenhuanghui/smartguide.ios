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

@class ShopKM1ControllerCell;

@protocol ShopKM1ControllerCellDelegate <NSObject>

-(void) shopKM1ControllerCellTouchedScan:(ShopKM1ControllerCell*) km1;

@end

@interface ShopKM1ControllerCell : UITableViewCell
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

@property (nonatomic, weak) id<ShopKM1ControllerCellDelegate> delegate;

@end

@interface UITableView(ShopKM1ControllerCell)

-(void) registerShopKM1ControllerCell;
-(ShopKM1ControllerCell*) shopKM1ControllerCell;

@end