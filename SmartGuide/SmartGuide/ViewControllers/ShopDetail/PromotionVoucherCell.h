//
//  PromotionVoucherCell.h
//  SmartGuide
//
//  Created by MacMini on 10/2/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"
#import "PromotionVoucher.h"

@interface PromotionVoucherCell : UIView
{
    __weak IBOutlet CBAutoScrollLabel *lbl;
    __weak IBOutlet UILabel *lblP;
}

-(void) setVoucher:(PromotionVoucher*) voucher;
+(CGSize) size;

@end
