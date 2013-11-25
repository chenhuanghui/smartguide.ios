//
//  ShopKM1Cel.h
//  SmartGuide
//
//  Created by MacMini on 21/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopKM1Cell : UITableViewCell
{
    __weak IBOutlet UIView *containView;
    __weak IBOutlet UILabel *lblVoucher;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *imgvFlag;
    __weak IBOutlet UILabel *lblSGP;
}

-(void) setVoucher:(NSString*) voucher content:(NSString*) content sgp:(NSString*) sgp isHighlighted:(bool) isHighlighted;

+(NSString *)reuseIdentifier;
+(float) heightWithContent:(NSString*) content;

@end
