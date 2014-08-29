//
//  ShopInfoTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDescTableCell : UITableViewCell

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopDescTableCell)

-(void) registerShopDescTableCell;
-(ShopDescTableCell*) shopDescTableCell;

@end