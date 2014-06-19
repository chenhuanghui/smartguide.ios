//
//  SUKM2Cell.h
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopKM2.h"

@class ShopKM2ControllerCell;

@protocol ShopKM2ControllerCellDelegate <NSObject>

-(void) shopKM2ControllerCellDelegateTouchedScan:(ShopKM2ControllerCell*) cell;

@end

@interface ShopKM2ControllerCell : UICollectionViewCell<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UILabel *lblDuration;
    __weak IBOutlet UILabel *lblText;
    __weak IBOutlet UIButton *btnScan;
    __weak IBOutlet UIButton *btnCode;
    __weak IBOutlet UILabel *lblNote;
    __weak IBOutlet UITableView *table;
    
    __weak ShopKM2 *_km2;
    NSArray *_vouchers;
}

-(void) loadWithKM2:(ShopKM2*) km2;

+(NSString *)reuseIdentifier;
+(float) heightWithKM2:(ShopKM2*) km2;

@property (nonatomic, weak) id<ShopKM2ControllerCellDelegate> delegate;

@end

@interface UICollectionView(ShopKM2ControllerCell)

-(void) registerShopKM2ControllerCell;
-(ShopKM2ControllerCell*) shopKM2ControllerCellForIndexPath:(NSIndexPath*) indexPath;

@end