//
//  ShopContactTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopContactTableCell : UITableViewCell

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopContactTableCell)

-(void) registerShopContactTableCell;
-(ShopContactTableCell*) shopContactTableCell;

@end