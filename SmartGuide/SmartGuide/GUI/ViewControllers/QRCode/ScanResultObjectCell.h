//
//  ScanResultObjectCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanCodeRelated, ScanResultObjectCell;

@protocol ScanResultObjectCellDelegate <NSObject>

-(void) scanResultObjectCellTouched:(ScanResultObjectCell*) cell;

@end

@interface ScanResultObjectCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    
    __weak ScanCodeRelated *_related;
}

-(void) loadWithRelated:(ScanCodeRelated*) obj;
-(ScanCodeRelated*) obj;

+(NSString *)reuseIdentifier;
+(float) heightWithRelated:(ScanCodeRelated*) obj;

@property (nonatomic, weak) id<ScanResultObjectCellDelegate> delegate;

@end

@interface UITableView(ScanResultObjectCell)

-(void) registerScanResultObjectCell;
-(ScanResultObjectCell*) scanResultObjectCell;

@end