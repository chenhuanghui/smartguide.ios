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

enum NEW_FEED_LIST_DISPLAY_MODE {
    NEW_FEED_LIST_DISPLAY_TUTORIAL = 0,
    NEW_FEED_LIST_DISPLAY_USED = 1,
    };

@class NewFeedListCell;

@protocol NewFeedListDelegate <NSObject>

-(void) newFeedListTouched:(NewFeedListCell*) cell;

@end

@interface NewFeedListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tablePlace;
    __weak IBOutlet UITableView *tableTutorial;
    __weak IBOutlet UIButton *btnNext;
    
    NSMutableArray *_homes;
    NSMutableArray *_tutorials;
    
    enum NEW_FEED_LIST_DATA_MODE _dataMode;
    enum NEW_FEED_LIST_DISPLAY_MODE _displayMode;
}

-(void) loadWithHome3:(NSArray*) home3 displayMode:(enum NEW_FEED_LIST_DISPLAY_MODE) displayMode;
-(void) loadWithHome4:(NSArray*) home4 displayMode:(enum NEW_FEED_LIST_DISPLAY_MODE) displayMode;
-(void) loadWithHome5:(NSArray*) home5 displayMode:(enum NEW_FEED_LIST_DISPLAY_MODE) displayMode;

-(id) currentHome;

+(float) heightWithMode:(enum NEW_FEED_LIST_DISPLAY_MODE) displayMode;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<NewFeedListDelegate> delegate;

@end
