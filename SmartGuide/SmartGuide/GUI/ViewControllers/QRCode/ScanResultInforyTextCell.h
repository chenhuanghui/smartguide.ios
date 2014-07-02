//
//  ScanResultInforyTextCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRCodeDecode;

@interface ScanResultInforyTextCell : UITableViewCell

-(void) loadWithDecode:(QRCodeDecode*) obj;

+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(QRCodeDecode*) obj;

@end

@interface UITableView(ScanResultInforyTextCell)

-(void) registerScanResultInforyTextCell;
-(ScanResultInforyTextCell*) scanResultInforyTextCell;

@end