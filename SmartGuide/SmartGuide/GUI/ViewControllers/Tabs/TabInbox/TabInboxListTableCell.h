//
//  TabInboxListTableCell.h
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label;

enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE
{
    TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_SMALL=0,
    TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE_FULL=1,
};

@class MessageList;

@interface TabInboxListTableCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvBG;
    __weak IBOutlet UIView *circleView;
    __weak IBOutlet UIView *displayView;
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet Label *lblTime;
    __weak IBOutlet UIImageView *imgvImage;
    __weak IBOutlet Label *lblTitle;
    __weak IBOutlet Label *lblContent;
    __weak IBOutlet UIView *buttonsView;
    __weak IBOutlet UIView *line;
}

-(void) loadWithMessageList:(MessageList*) obj displayType:(enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE) displayType;
-(float) calculatorHeight:(MessageList*) obj displayType:(enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE) displayType;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) MessageList *obj;
@property (nonatomic, assign, readonly) enum TAB_INBOX_LIST_TABLE_CELL_DISPLAY_TYPE displayType;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(TabInboxListTableCell)

-(void) registerTabInboxListTableCell;
-(TabInboxListTableCell*) tabInboxListTableCell;
-(TabInboxListTableCell*) tabInboxListTablePrototypeCell;

@end