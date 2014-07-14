//
//  ScanResultRelatedMoreCell.h
//  Infory
//
//  Created by XXX on 7/14/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanResultRelatedMoreCell : UITableViewCell
{
}

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ScanResultRelatedMoreCell)

-(void) registerScanResultRelatedMoreCell;
-(ScanResultRelatedMoreCell*) scanResultRelatedMoreCell;

@end