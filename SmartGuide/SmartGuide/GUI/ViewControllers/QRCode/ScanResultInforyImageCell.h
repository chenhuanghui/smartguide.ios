//
//  ScanResultInforyImageCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QRCodeDecode;

@interface ScanResultInforyImageCell : UITableViewCell

-(void) loadWithDecode:(QRCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(QRCodeDecode*) decode;

@end

@interface UITableView(ScanResultInforyImageCell)

-(void) registerScanResultInforyImageCell;
-(ScanResultInforyImageCell*) scanResultInforyImageCell;

@end