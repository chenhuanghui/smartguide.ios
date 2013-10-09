//
//  PromotionDetailCell.h
//  SmartGuide
//
//  Created by XXX on 8/1/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAutoScrollLabel.h"
#import "PromotionRequire.h"

@interface PromotionDetailCell : UITableViewCell
{
    __weak IBOutlet UIImageView *bar;
    __weak IBOutlet UILabel *lblSgp;
    __weak IBOutlet CBAutoScrollLabel *lblContent;
    __weak IBOutlet UILabel *lblNumberVoucher;
}

-(void) setPromotionRequire:(PromotionRequire*) require;

+(NSString *)reuseIdentifier;
+(float) height;

@end
