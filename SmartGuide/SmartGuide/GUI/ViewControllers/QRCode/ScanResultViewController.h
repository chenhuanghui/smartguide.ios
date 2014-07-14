//
//  ScanResultViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

#define NOTIFICATION_SCAN_RELATED_REQUEST_LOADMORE @"scanRelatedRequestLoadMore"

@class ScanResultViewController, UserNotificationAction, ScanCodeRelated, ScanCodeRelatedContain;

@protocol ScanResultControllerDelegate <SGViewControllerDelegate>

-(void) scanResultControllerTouchedBack:(ScanResultViewController*) controller;
-(void) scanResultController:(ScanResultViewController*) controller touchedAction:(UserNotificationAction*) action;
-(void) scanResultController:(ScanResultViewController*) controller touchedRelated:(ScanCodeRelated*) related;
-(void) scanResultController:(ScanResultViewController*) controller touchedMore:(ScanCodeRelatedContain*) object;

@end

@interface ScanResultViewController : SGViewController
{
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UILabel *lblTitle;
}

-(ScanResultViewController*) initWithCode:(NSString*) code;

@property (nonatomic, weak) id<ScanResultControllerDelegate> delegate;

@end

@interface TableResult : UITableView

@end