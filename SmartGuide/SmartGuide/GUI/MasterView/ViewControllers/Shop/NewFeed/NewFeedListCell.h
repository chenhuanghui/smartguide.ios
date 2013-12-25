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

enum NEW_FEED_LIST_DATA_MODE {
    NEW_FEED_LIST_DATA_HOME3 = 0,
    NEW_FEED_LIST_DATA_HOME4 = 1,
    NEW_FEED_LIST_DATA_HOME5 = 2,
    };

@interface NewFeedListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIButton *btnNext;
    
    NSMutableArray *_homes;
    enum NEW_FEED_LIST_DATA_MODE _dataMode;
}

-(void) loadWithHome3:(NSArray*) home3;
-(void) loadWithHome4:(NSArray*) home4;
-(void) loadWithHome5:(NSArray*) home5;

+(float) height;
+(NSString *)reuseIdentifier;

@end
