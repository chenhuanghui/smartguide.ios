//
//  ShopEventTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopEventTableCell : UITableViewCell

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ShopEventTableCell)

-(void) registerShopEventTableCell;
-(ShopEventTableCell*) shopEventTableCell;

@end