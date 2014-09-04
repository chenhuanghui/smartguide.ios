//
//  ScanResultInforyImageCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeDecode;

@interface ScanResultInforyImageCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
-(float) calculatorHeight:(ScanCodeDecode*) object;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak, readonly) ScanCodeDecode *object;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ScanResultInforyImageCell)

-(void) registerScanResultInforyImageCell;
-(ScanResultInforyImageCell*) scanResultInforyImageCell;
-(ScanResultInforyImageCell*) scanResultInforyImagePrototypeCell;

@end