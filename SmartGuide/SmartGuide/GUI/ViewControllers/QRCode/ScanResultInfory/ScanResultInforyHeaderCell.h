//
//  ScanResultInforyHeaderCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeDecode;

@interface ScanResultInforyHeaderCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UILabel *lbl;
    __weak ScanCodeDecode *_decode;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
+(NSString *)reuseIdentifier;

@end

@interface UITableView(ScanResultInforyHeaderCell)

-(void) registerScanResultInforyHeaderCell;
-(ScanResultInforyHeaderCell*) scanResultInforyHeaderCell;

@end