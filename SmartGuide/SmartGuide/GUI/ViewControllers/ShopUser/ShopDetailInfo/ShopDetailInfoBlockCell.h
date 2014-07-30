//
//  ShopDetailInfoBlockCell.h
//  Infory
//
//  Created by XXX on 7/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class InfoTypeObject;

@interface ShopDetailInfoBlockCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UITableView *table;
    
    __weak InfoTypeObject *_obj;
}

-(void) loadWithInfoObject:(InfoTypeObject*) obj;

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopDetailInfoBlockCell)

-(void) registerShopDetailInfoBlockCell;
-(ShopDetailInfoBlockCell*) shopDetailInfoBlockCell;

@end