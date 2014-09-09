//
//  ScanButtonCollectionCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageAction, ScanButtonCollectionCell;

@protocol ScanButtonCollectionCellDelegate <NSObject>

-(void) scanButtonCollectionCellTouchedAction:(ScanButtonCollectionCell*) cell;

@end

@interface ScanButtonCollectionCell : UICollectionViewCell
{
    __weak IBOutlet UIButton *btn;
    __weak MessageAction *_action;
}

-(void) loadWithAction:(MessageAction*) action;
-(MessageAction*) action;
+(NSString *)reuseIdentifier;
+(float) widthWithAction:(MessageAction*) action;

@property (nonatomic, weak) id<ScanButtonCollectionCellDelegate> delegate;

@end

@interface UICollectionView(ScanButtonCollectionCell)

-(void) registerScanButtonCollectionCell;
-(ScanButtonCollectionCell*) scanButtonCollectionCellForIndexPath:(NSIndexPath*) indexPath;

@end