//
//  ScanResultInforyTitleCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeDecode;

@interface ScanResultInforyTitleCell : UITableViewCell
{
    __weak IBOutlet UILabel *lbl;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(ScanCodeDecode*) decode;

@end

@interface UITableView(ScanResultInforyTitleCell)

-(void) registerScanResultInforyTitleCell;
-(ScanResultInforyTitleCell*) scanResultInforyTitleCell;

@end