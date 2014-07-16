//
//  ScanResultInforyVideoCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

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
    
    __weak ScanCodeDecode *_decode;
}

-(void) loadWithDecode:(ScanCodeDecode*) decode;
+(NSString *)reuseIdentifier;
+(float) heightWithDecode:(ScanCodeDecode*) decode;

@property (nonatomic, weak) id<ScanResultInforyVideoCellDelegate> delegate;

@end

@interface UITableView(ScanResultInforyVideoCell)

-(void) registerScanResultInforyVideoCell;
-(ScanResultInforyVideoCell*) scanResultInforyVideoCell;

@end