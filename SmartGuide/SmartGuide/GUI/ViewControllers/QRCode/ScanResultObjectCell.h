//
//  ScanResultObjectCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultObjectCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
}

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ScanResultObjectCell)

-(void) registerScanResultObjectCell;
-(ScanResultObjectCell*) scanResultObjectCell;

@end