//
//  ScanResultInforyButtonCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeDecode, ScanResultInforyButtonCell, UserNotificationAction;

@protocol ScanResultInforyButtonCellDelegate <NSObject>

-(void) scanResultInforyButtonCellTouchedAction:(ScanResultInforyButtonCell*) cell action:(UserNotificationAction*) action;

@end

@interface ScanResultInforyButtonCell : UITableViewCell
{
    __weak IBOutlet UICollectionView *collection;
    
    __weak ScanCodeDecode *_decode;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(ScanCodeDecode*) decode;
+(float) height;

@property (nonatomic, weak) id<ScanResultInforyButtonCellDelegate> delegate;

@end

@interface UITableView(ScanResultInforyButtonCell)

-(void) registerScanResultInforyButtonCell;
-(ScanResultInforyButtonCell*) scanResultInforyButtonCell;

@end