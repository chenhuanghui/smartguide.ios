//
//  ScanResultRelatedCell.h
//  Infory
//
//  Created by XXX on 9/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TableTableCell.h"

@class ScanCodeRelatedContain;

@interface ScanResultRelatedCell : TableTableCell

-(void) loadWithRelatedContain:(NSArray*) objs;
-(float) calculatorHeight:(NSArray*) objs;

+(NSString *)reuseIdentifier;

@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak, readonly) NSArray *objs;

@end

@interface UITableView(ScanResultRelatedCell)

-(void) registerScanResultRelatedCell;
-(ScanResultRelatedCell*) scanResultRelatedCell;
-(ScanResultRelatedCell*) scanResultRelatedPrototypeCell;

@end