//
//  ShopInfoTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, ShopInfo;

@interface ShopInfoTableCell : UITableViewCell
{
    __weak IBOutlet Label *lblName;
    __weak IBOutlet Label *lblType;
    __weak IBOutlet UIImageView *imgvLogo;
    __weak IBOutlet UIView *line;
}

-(void) loadWithShop:(ShopInfo*) obj;
-(float) calculatorHeight:(ShopInfo*) obj;
+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, weak, readonly) ShopInfo* obj;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ShopInfoTableCell)

-(void) registerShopInfoTableCell;
-(ShopInfoTableCell*) shopInfoTableCell;
-(ShopInfoTableCell*) ShopInfoTablePrototypeCell;

@end