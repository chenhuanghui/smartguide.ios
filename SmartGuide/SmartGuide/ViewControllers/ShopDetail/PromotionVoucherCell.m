//
//  PromotionVoucherCell.m
//  SmartGuide
//
//  Created by MacMini on 10/2/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionVoucherCell.h"

@implementation PromotionVoucherCell

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"PromotionVoucherCell" owner:nil options:nil] objectAtIndex:0];
    if (self) {
        lbl.font=[UIFont boldSystemFontOfSize:15];
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.textColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setVoucher:(PromotionVoucher *)voucher
{
    lbl.text=voucher.desc;
    [lbl scrollLabelIfNeeded];
    lblP.text=[NSString stringWithFormat:@"%i",voucher.p.integerValue];
}

+(CGSize)size
{
    return CGSizeMake(260, 35);
}

@end
