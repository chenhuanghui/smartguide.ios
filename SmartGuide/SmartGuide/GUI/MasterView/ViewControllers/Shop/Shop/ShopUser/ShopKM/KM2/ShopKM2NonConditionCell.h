//
//  ShopKM2NonConditionCell.h
//  SmartGuide
//
//  Created by MacMini on 22/01/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KM2Voucher.h"

@interface ShopKM2NonConditionCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblType;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIImageView *icon;
    
    __weak KM2Voucher *_voucher;
}

-(void) loadWithVoucher:(KM2Voucher*) voucher;

+(float) heightWithVoucher:(KM2Voucher*) voucher;
+(NSString *)reuseIdentifier;

@end
