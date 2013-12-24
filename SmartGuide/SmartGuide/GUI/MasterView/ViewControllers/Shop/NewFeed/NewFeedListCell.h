//
//  NewFeedListCell.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome3.h"
#import "UserHome4.h"
#import "UserHome5.h"

@interface NewFeedListCell : UITableViewCell

-(void) loadWithHome3:(UserHome3*) home3;
-(void) loadWithHome4:(UserHome4*) home4;
-(void) loadWithHome5:(UserHome5*) home5;

+(float) height;
+(NSString *)reuseIdentifier;

@end
