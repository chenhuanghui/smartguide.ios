//
//  ScanResultInforyCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultInforyCell : UITableViewCell
{
    __weak IBOutlet UITableView *table;
    NSArray *_items;
}

-(void) loadWithDecode:(NSArray*) array;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(NSArray*) array;

@end

@interface UITableView(ScanResultInforyCell)

-(void) registerScanResultInforyCell;
-(ScanResultInforyCell*) scanResultInforyCell;

@end