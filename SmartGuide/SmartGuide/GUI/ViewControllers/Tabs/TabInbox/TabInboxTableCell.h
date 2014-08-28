//
//  TabInboxTableCell.h
//  Infory
//
//  Created by XXX on 8/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, MessageSender;

@interface TabInboxTableCell : UITableViewCell
{
    __weak IBOutlet UIView *circleView;
    __weak IBOutlet Label *lblTitle;
    __weak IBOutlet Label *lblContent;
    __weak IBOutlet UIView *line;
}

-(void) loadWithMessageSender:(MessageSender*) obj;
-(float) calculatorHeight:(MessageSender*) obj;

+(NSString *)reuseIdentifier;

@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak) MessageSender *object;

@end

@interface UITableView(TabInboxTableCell)

-(void) registerTabInboxTableCell;
-(TabInboxTableCell*) tabInboxTableCell;
-(TabInboxTableCell*) tabInboxTablePrototypeCell;

@end