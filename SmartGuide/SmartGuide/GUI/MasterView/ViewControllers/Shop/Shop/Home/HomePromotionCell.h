//
//  NewFeedPromotionCell.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome1.h"
#import "UserHome8.h"
#import "Shop.h"

@interface HomePromotionCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lbl;
    __weak IBOutlet UIView *bg;
}

-(void) loadWithHome1:(UserHome1*) home;
-(void) loadWithHome8:(UserHome8*) home;
-(void) alignContent;

+(float) heightWithHome1:(UserHome1*) home;
+(float) heightWithHome8:(UserHome8*) home;
+(NSString *)reuseIdentifier;

@end
