//
//  ScanResultInforyTextCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeDecode;

@interface ScanResultInforyTextCell : UITableViewCell
{
    __weak IBOutlet UILabel *lbl;
}

-(void) loadWithDecode:(ScanCodeDecode*) obj;

+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(ScanCodeDecode*) obj;

@end

@interface UITableView(ScanResultInforyTextCell)

-(void) registerScanResultInforyTextCell;
-(ScanResultInforyTextCell*) scanResultInforyTextCell;

@end