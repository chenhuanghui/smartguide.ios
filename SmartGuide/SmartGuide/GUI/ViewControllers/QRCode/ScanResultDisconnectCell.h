//
//  ScanResultDisconnectCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultDisconnectCell : UITableViewCell

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ScanResultDisconnectCell)

-(void) registerScanResultDisconnectCell;
-(ScanResultDisconnectCell*) scanResultDisconnectCell;

@end