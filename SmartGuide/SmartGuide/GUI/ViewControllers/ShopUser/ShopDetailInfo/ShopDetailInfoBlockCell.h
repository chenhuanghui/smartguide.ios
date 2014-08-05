//
//  ShopDetailInfoBlockCell.h
//  Infory
//
//  Created by XXX on 7/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class InfoTypeObject, ShopDetailInfoBlockCell;

@protocol ShopDetailInfoBlockCellDelegate <NSObject>

-(void) shopDetailInfoBlockCell:(ShopDetailInfoBlockCell*) cell touchedURL:(NSURL*) url;
-(void) shopDetailInfoBlockCell:(ShopDetailInfoBlockCell*) cell touchedIDShop:(int) idShop;

@end

@interface ShopDetailInfoBlockCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UITableView *table;
    
    __weak InfoTypeObject *_obj;
}

-(void) loadWithInfoObject:(InfoTypeObject*) obj;
-(void) tableDidScroll:(UITableView*) tableDetail;

+(NSString *)reuseIdentifier;

@property (nonatomic, weak) id<ShopDetailInfoBlockCellDelegate> delegate;
@property (nonatomic, weak) UITableView *tableDetail;

@end

@interface UITableView(ShopDetailInfoBlockCell)

-(void) registerShopDetailInfoBlockCell;
-(ShopDetailInfoBlockCell*) shopDetailInfoBlockCell;

@end