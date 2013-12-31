//
//  NewFeedInfoCell.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome6.h"
#import "UserHome7.h"
#import "LabelTopText.h"

@protocol homeInfoCellDelegate <NSObject>

-(void) homeInfoCellTouchedGoTo:(id) home;

@end

@interface HomeInfoCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UILabel *lblDate;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet LabelTopText *lblContent;
    __weak IBOutlet UIImageView *imgvCover;
    __weak IBOutlet UIButton *btnGoTo;
    
    __weak UserHome6 *_home6;
    __weak UserHome7 *_home7;
}

-(void) loadWithHome6:(UserHome6*) home;
-(void) loadWithHome7:(UserHome7*) home;

+(float) heightWithHome6:(UserHome6*) home;
+(float) heightWithHome7:(UserHome7*) home;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<homeInfoCellDelegate> delegate;

@end

@interface ButtonGoTo : UIButton
{
    UIImage *imgLeft;
    UIImage *imgMid;
    UIImage *imgRight;
}

@end