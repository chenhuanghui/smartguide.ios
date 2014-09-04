//
//  ScanResultInforyTextCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeDecode, Label;

@interface ScanResultInforyTextCell : UITableViewCell
{
    __weak IBOutlet Label *lbl;
}

-(void) loadWithDecode:(ScanCodeDecode*) obj;
-(float) calculatorHeight:(ScanCodeDecode*) obj;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) ScanCodeDecode *object;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ScanResultInforyTextCell)

-(void) registerScanResultInforyTextCell;
-(ScanResultInforyTextCell*) scanResultInforyTextCell;
-(ScanResultInforyTextCell*) scanResultInforyTextPrototypeCell;

@end