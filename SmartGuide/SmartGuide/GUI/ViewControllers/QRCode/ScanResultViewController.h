//
//  ScanResultViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ViewController.h"

#define NOTIFICATION_SCAN_RELATED_REQUEST_LOADMORE @"scanRelatedRequestLoadMore"

@class ScanResultViewController, UserNotificationAction, ScanCodeRelated, ScanCodeRelatedContain;

@protocol ScanResultControllerDelegate <ViewControllerDelegate>

-(void) scanResultController:(ScanResultViewController*) controller touchedAction:(UserNotificationAction*) action;
-(void) scanResultController:(ScanResultViewController*) controller touchedRelated:(ScanCodeRelated*) related;
-(void) scanResultController:(ScanResultViewController*) controller touchedMore:(ScanCodeRelatedContain*) object;

@end

@interface ScanResultViewController : ViewController
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIButton *btnBack;
}

-(ScanResultViewController*) initWithCode:(NSString*) code;

@property (nonatomic, weak) id<ScanResultControllerDelegate> delegate;

@end

@interface TableResult : UITableView

@end