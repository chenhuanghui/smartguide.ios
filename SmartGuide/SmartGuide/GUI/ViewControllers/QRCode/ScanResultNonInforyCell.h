//
//  ScanResultNonInforyCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultNonInforyCell : UITableViewCell

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ScanResultNonInforyCell)

-(void) registerScanResultNonInforyCell;
-(ScanResultNonInforyCell*) scanResultNonInforyCell;

@end