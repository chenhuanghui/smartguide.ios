//
//  ScanResultRelatedCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeRelatedContain;

@class MPMoviePlayerController, ScanResultRelatedCell, ScanCodeRelated, ScanCodeResult;

@protocol ScanResultRelatedCellDelegate <NSObject>

-(void) scanResultRelatedCell:(ScanResultRelatedCell*) cell touchedObject:(ScanCodeRelated*) obj;
-(void) scanResultRelatedCellTouchedMore:(ScanResultRelatedCell*) cell object:(ScanCodeRelatedContain*) object;

@end

@interface ScanResultRelatedCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UITableView *table;
    __weak ScanCodeResult *_result;
    float _tableHeight;
}

-(void) loadWithResult:(ScanCodeResult*) result height:(float) height;
-(void) tableDidScroll:(UITableView*) tableResult;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ScanResultRelatedCellDelegate> delegate;

@end

@interface UITableView(ScanResultRelatedCell)

-(void) registerScanResultRelatedCell;
-(ScanResultRelatedCell*) scanResultRelatedCell;

@end