//
//  ScanResultInforyVideoCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class ScanCodeDecode, ScanResultInforyVideoCell, MPMoviePlayerController;

@protocol ScanResultInforyVideoCellDelegate <NSObject>

-(MPMoviePlayerController*) scanResultInforyVideoCellRequestMoviePlayer:(ScanResultInforyVideoCell*) cell;

@end

@interface ScanResultInforyVideoCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UIButton *btn;
    __weak IBOutlet UIView *videoView;
    __weak IBOutlet UIImageView *imgvPlay;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
-(float) calculatorHeight:(ScanCodeDecode*) object;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ScanResultInforyVideoCellDelegate> delegate;
@property (nonatomic, weak, readonly) ScanCodeDecode *object;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ScanResultInforyVideoCell)

-(void) registerScanResultInforyVideoCell;
-(ScanResultInforyVideoCell*) scanResultInforyVideoCell;
-(ScanResultInforyVideoCell*) scanResultInforyVideoPrototypeCell;

@end