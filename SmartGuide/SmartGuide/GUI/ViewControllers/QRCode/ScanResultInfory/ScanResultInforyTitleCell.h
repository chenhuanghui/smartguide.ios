//
//  ScanResultInforyTitleCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeDecode, Label;

@interface ScanResultInforyTitleCell : UITableViewCell
{
    __weak IBOutlet Label *lbl;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
-(float) calculatorHeight:(ScanCodeDecode*) object;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) ScanCodeDecode *object;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ScanResultInforyTitleCell)

-(void) registerScanResultInforyTitleCell;
-(ScanResultInforyTitleCell*) scanResultInforyTitleCell;
-(ScanResultInforyTitleCell*) scanResultInforyTitlePrototypeCell;

@end