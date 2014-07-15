//
//  ScanResultRelatedViewController.h
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "SGViewController.h"

@class ScanCodeRelatedContain, ScanResultRelatedViewController, ScanCodeRelated;

@protocol ScanResultRelatedControllerDelegate <SGViewControllerDelegate>

-(void) scanResultRelatedControllerTouchedBack:(ScanResultRelatedViewController*) controller;
-(void) scanResultRelatedController:(ScanResultRelatedViewController*) controller touchedRelatedObject:(ScanCodeRelated*) obj;

@end

@interface ScanResultRelatedViewController : SGViewController
{
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UITableView *table;
    
    __weak ScanCodeRelatedContain *_relatedContain;
}

-(ScanResultRelatedViewController*) initWithRelatedContain:(ScanCodeRelatedContain*) object;

@property (nonatomic, weak) id<ScanResultRelatedControllerDelegate> delegate;

@end
