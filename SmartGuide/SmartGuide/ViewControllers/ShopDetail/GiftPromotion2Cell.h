//
//  GiftPromotion2Cell.h
//  SmartGuide
//
//  Created by MacMini on 10/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"
#import "FTCoreTextView.h"

@interface GiftPromotion2Cell : UITableViewCell
{
    __weak IBOutlet CBAutoScrollLabel *lblReward;
    __weak IBOutlet FTCoreTextView *lblP;
    __weak IBOutlet UILabel *lblVoucherNumber;
    __weak IBOutlet UILabel *line;
}

-(void) setReward:(NSString*) reward p:(NSString*) p numberVoucher:(NSString*) numberVoucher;
-(void) setLineVisible:(bool) isVisible;

+(CGSize) size;
+(NSString *)reuseIdentifier;

@end
