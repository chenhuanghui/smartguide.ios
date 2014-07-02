//
//  ScanResultInforyButtonCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRCodeDecode;

@interface ScanResultInforyButtonCell : UITableViewCell

-(void) loadWithDecode:(QRCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(QRCodeDecode*) decode;

@end

@interface UITableView(ScanResultInforyButtonCell)

-(void) registerScanResultInforyButtonCell;
-(ScanResultInforyButtonCell*) ScanResultInforyButtonCell;

@end