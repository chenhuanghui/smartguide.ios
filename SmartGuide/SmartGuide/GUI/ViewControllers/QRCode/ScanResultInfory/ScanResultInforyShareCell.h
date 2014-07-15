//
//  ScanResultInforyShareCell.h
//  Infory
//
//  Created by XXX on 7/15/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultInforyShareCell : UITableViewCell
{
    __weak IBOutlet UIButton *btnFB;
    __weak IBOutlet UIButton *btnGP;
    NSURL *_url;
}

-(void) loadWithLink:(NSString*) url;
+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ScanResultInforyShareCell)

-(void) registerScanResultInforyShareCell;
-(ScanResultInforyShareCell*) scanResultInforyShareCell;

@end