//
//  NewFeedInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome6.h"
#import "UserPromotion.h"

@protocol homeInfoCellDelegate <NSObject>

-(void) homeInfoCellTouchedGoTo:(id) home;

@end

@interface HomeInfoCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIButton *btnName;
    __weak IBOutlet UILabel *lblDate;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *imgvCover;
    __weak IBOutlet UIButton *btnGoTo;
    __weak IBOutlet UILabel *lblGoTo;

    __weak id _obj;
}

-(void) loadWithHome6:(UserHome6*) home;
-(void) loadWithUserPromotion:(UserPromotion*) obj;

+(float) heightWithHome6:(UserHome6*) home;
+(float) heightWithUserPromotion:(UserPromotion*) obj;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<homeInfoCellDelegate> delegate;

@end

@interface ButtonGoTo : UIButton
{
    UIImage *imgLeft;
    UIImage *imgMid;
    UIImage *imgRight;
    UIImage *imgIcon;
}

@end