//
//  ScanResultRelatedCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultRelatedCell : UITableViewCell
{
    __weak IBOutlet UITableView *table;
    NSArray *_relaties;
}

-(void) loadWithRelaties:(NSArray*) relaties;

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ScanResultRelatedCell)

-(void) registerScanResultRelatedCell;
-(ScanResultRelatedCell*) scanResultRelatedCell;

@end