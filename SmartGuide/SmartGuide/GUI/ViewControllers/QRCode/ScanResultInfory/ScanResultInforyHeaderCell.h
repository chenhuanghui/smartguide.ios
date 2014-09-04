//
//  ScanResultInforyHeaderCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeDecode, Label;

@interface ScanResultInforyHeaderCell : UITableViewCell
{
    __weak IBOutlet Label *lbl;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
-(float) calculatorHeight:(ScanCodeDecode*) object;

+(NSString *)reuseIdentifier;

@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak, readonly) ScanCodeDecode *object;

@end

@interface UITableView(ScanResultInforyHeaderCell)

-(void) registerScanResultInforyHeaderCell;
-(ScanResultInforyHeaderCell*) scanResultInforyHeaderCell;
-(ScanResultInforyHeaderCell*) scanResultInforyHeaderPrototypeCell;

@end