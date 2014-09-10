//
//  ShopAddressTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, ShopInfo, Button;

@interface ShopAddressTableCell : UITableViewCell
{
    __weak IBOutlet Label *lblDiaChi;
    __weak IBOutlet Label *lblKM;
    __weak IBOutlet Label *lblAddress;
    __weak IBOutlet Button *btn;
    __weak IBOutlet UIView *line;
}

-(void) loadWithShopInfo:(ShopInfo*) obj;
-(float) calculatorHeight:(ShopInfo*) obj;
+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak) ShopInfo *object;

@end

@interface UITableView(ShopAddressTableCell)

-(void) registerShopAddressTableCell;
-(ShopAddressTableCell*) shopAddressTableCell;
-(ShopAddressTableCell*) shopAddressTablePrototypeCell;

@end