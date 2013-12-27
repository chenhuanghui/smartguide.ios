//
//  NewFeedListCell.h
//  SmartGuide
//
//  Created by MacMini on 24/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHome.h"
#import "PageControl.h"

enum NEW_FEED_LIST_DATA_MODE {
    NEW_FEED_LIST_DATA_HOME3 = 0,
    NEW_FEED_LIST_DATA_HOME4 = 1,
    NEW_FEED_LIST_DATA_HOME5 = 2,
    };

enum NEW_FEED_LIST_DISPLAY_MODE {
    NEW_FEED_LIST_DISPLAY_SLIDE = 0,
    NEW_FEED_LIST_DISPLAY_USED = 1,
    };

@class NewFeedListCell;

@protocol NewFeedListDelegate <NSObject>

-(void) newFeedListTouched:(NewFeedListCell*) cell;

@end

@interface NewFeedListCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tablePlace;
    __weak IBOutlet UITableView *tableSlide;
    __weak IBOutlet UIButton *btnNext;
    __weak IBOutlet PageControlNext *pageControl;
    
    NSMutableArray *_homes;
    NSMutableArray *_images;
    
    enum NEW_FEED_LIST_DATA_MODE _dataMode;
    enum NEW_FEED_LIST_DISPLAY_MODE _displayMode;
}

-(void) loadWithHome3:(UserHome*) home;
-(void) loadWithHome4:(UserHome*) home;
-(void) loadWithHome5:(UserHome*) home;

-(id) currentHome;

+(float) heightWithHome:(UserHome*) home;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<NewFeedListDelegate> delegate;

@end
