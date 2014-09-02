//
//  ShopInfoTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label, ShopInfo;

@interface ShopDescTableCell : UITableViewCell
{
    __weak IBOutlet Label *lblThongTin;
    __weak IBOutlet Label *lblDesc;
    __weak IBOutlet UIView *line;
}

-(void) loadWithShopInfo:(ShopInfo*) obj;
-(float) calculatorHeight:(ShopInfo*) obj;
+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, assign) bool isPrototypeCell;
@property (nonatomic, weak, readonly) ShopInfo *object;

@end

@interface UITableView(ShopDescTableCell)

-(void) registerShopDescTableCell;
-(ShopDescTableCell*) shopDescTableCell;
-(ShopDescTableCell*) shopDescTablePrototypeCell;

@end