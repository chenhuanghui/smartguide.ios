//
//  ScanResultDisconnectCell.h
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanResultDisconnectCell;

@protocol ScanResultDisconnectCellDelegate <NSObject>

-(void) scanResultDisconnectCellTouchedTry:(ScanResultDisconnectCell*) cell;

@end

@interface ScanResultDisconnectCell : UITableViewCell
{
    __weak IBOutlet UIButton *btn;
}

+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, weak) id<ScanResultDisconnectCellDelegate> delegate;

@end

@interface UITableView(ScanResultDisconnectCell)

-(void) registerScanResultDisconnectCell;
-(ScanResultDisconnectCell*) scanResultDisconnectCell;

@end