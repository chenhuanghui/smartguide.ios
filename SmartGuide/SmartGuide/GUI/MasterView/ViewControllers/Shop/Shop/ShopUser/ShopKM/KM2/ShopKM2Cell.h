//
//  ShopKM2Cell.h
//  SmartGuide
//
//  Created by MacMini on 04/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KM2Voucher.h"
#import "FTCoreTextView.h"
#import "LabelTopText.h"

@interface ShopKM2Cell : UITableViewCell
{
    __weak KM2Voucher *_voucher;
    __weak IBOutlet UILabel *lblType;
    __weak IBOutlet LabelTopText *lblTitle;
    __weak IBOutlet FTCoreTextView *lblCondition;
    __weak IBOutlet UIImageView *icon;
}

-(void) loadWithKM2:(KM2Voucher*) voucher;

+(NSString *)reuseIdentifier;
+(float) heightWithKM2:(KM2Voucher*) voucher;

@end
