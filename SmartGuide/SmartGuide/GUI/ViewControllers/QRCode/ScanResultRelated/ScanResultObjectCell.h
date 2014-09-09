//
//  ScanResultObjectCell.h
//  Infory
//
//  Created by XXX on 7/3/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@protocol ScanResultObjectData <NSObject>

-(NSString*) name;
-(NSString*) content;
-(NSString*) logo;

@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect contentRect;

@end

@class ScanCodeRelated, ScanResultObjectCell, Label;

@protocol ScanResultObjectCellDelegate <NSObject>

-(void) scanResultObjectCellTouched:(ScanResultObjectCell*) cell;

@end

@interface ScanResultObjectCell : UITableViewCell
{
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet Label *lblTitle;
    __weak IBOutlet Label *lblContent;
    __weak IBOutlet UIView *line;
    __weak IBOutlet UIImageView *imgvArrow;
}

-(void) loadWithRelated:(id<ScanResultObjectData>) obj;
-(float) calculatorHeight:(id<ScanResultObjectData>) obj;
+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ScanResultObjectCellDelegate> delegate;
@property (nonatomic, weak, readonly) id<ScanResultObjectData> object;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ScanResultObjectCell)

-(void) registerScanResultObjectCell;
-(ScanResultObjectCell*) scanResultObjectCell;
-(ScanResultObjectCell*) scanResultObjectPrototypeCell;

@end