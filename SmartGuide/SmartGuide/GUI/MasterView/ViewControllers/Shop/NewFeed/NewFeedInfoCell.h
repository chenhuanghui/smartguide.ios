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

@interface NewFeedInfoCell : UITableViewCell

-(void) loadWithHome6:(UserHome6*) home;
-(void) loadWithHome7:(UserHome7*) home;

+(float) heightWithHome6:(UserHome6*) home;
+(float) heightWithHome7:(UserHome7*) home;
+(NSString *)reuseIdentifier;

@end
