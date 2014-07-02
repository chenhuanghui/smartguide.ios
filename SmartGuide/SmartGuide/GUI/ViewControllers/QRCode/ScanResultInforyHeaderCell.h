//
//  ScanResultInforyHeaderCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRCodeDecode;

@interface ScanResultInforyHeaderCell : UITableViewCell
{
    __weak IBOutlet UILabel *lbl;
}

-(void) loadWithDecode:(QRCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(QRCodeDecode*) decode;

@end

@interface UITableView(ScanResultInforyHeaderCell)

-(void) registerScanResultInforyHeaderCell;
-(ScanResultInforyHeaderCell*) scanResultInforyHeaderCell;

@end