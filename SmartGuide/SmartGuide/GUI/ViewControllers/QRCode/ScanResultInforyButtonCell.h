//
//  ScanResultInforyButtonCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeDecode;

@interface ScanResultInforyButtonCell : UITableViewCell
{
    __weak IBOutlet UIButton *btn;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(ScanCodeDecode*) decode;

@end

@interface UITableView(ScanResultInforyButtonCell)

-(void) registerScanResultInforyButtonCell;
-(ScanResultInforyButtonCell*) scanResultInforyButtonCell;

@end