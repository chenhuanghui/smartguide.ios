//
//  ScanResultViewController.h
//  Infory
//
//  Created by XXX on 7/1/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

#define NOTIFICATION_SCAN_RELATED_REQUEST_LOADMORE @"scanRelatedRequestLoadMore"

@class ScanResultViewController, ScanResult;

@protocol ScanResultControllerDelegate <SGViewControllerDelegate>

-(void) scanResultController:(ScanResultViewController*) controller touchedObject:(ScanResult*) object;
-(void) scanResultControllerTouchedBack:(ScanResultViewController*) controller;

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

