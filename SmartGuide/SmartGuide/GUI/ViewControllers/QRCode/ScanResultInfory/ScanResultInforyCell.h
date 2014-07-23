//
//  ScanResultInforyCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class MPMoviePlayerController, ScanResultInforyCell, UserNotificationAction;

@protocol ScanResultInforyCellDelegate <NSObject>

-(MPMoviePlayerController*) scanResultInforyCellRequestMoviePlayer:(ScanResultInforyCell*) cell;
-(void) scanResultInforyCell:(ScanResultInforyCell*) cell touchedAction:(UserNotificationAction*) action;

@end

@interface ScanResultInforyCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UITableView *table;
    NSArray *_items;
}

-(void) loadWithDecode:(NSArray*) array;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ScanResultInforyCellDelegate> delegate;

@end

@interface UITableView(ScanResultInforyCell)

-(void) registerScanResultInforyCell;
-(ScanResultInforyCell*) scanResultInforyCell;

@end