//
//  ScanResultInforyVideoCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeDecode;

@interface ScanResultInforyVideoCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(ScanCodeDecode*) decode;

@end

@interface UITableView(ScanResultInforyVideoCell)

-(void) registerScanResultInforyVideoCell;
-(ScanResultInforyVideoCell*) scanResultInforyVideoCell;

@end