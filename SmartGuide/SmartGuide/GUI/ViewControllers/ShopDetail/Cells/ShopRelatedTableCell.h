//
//  ShopRelatedTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopRelatedTableCell : UITableViewCell

+(NSString *)reuseIdentifier;
+(float) height;

@end

@interface UITableView(ShopRelatedTableCell)

-(void) registerShopRelatedTableCell;
-(ShopRelatedTableCell*) shopRelatedTableCell;

@end