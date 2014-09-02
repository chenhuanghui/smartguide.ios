//
//  ShopEventTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopInfoEvent, Label, Button;

@interface ShopEventTableCell : UITableViewCell
{
    __weak IBOutlet Label *lblDuration;
    __weak IBOutlet Label *lblTitle;
    __weak IBOutlet Label *lblContent;
    __weak IBOutlet Button *btn;
    __weak IBOutlet UIImageView *imgvImage;
    __weak IBOutlet UIView *line;
}

-(void) loadWithEvent:(ShopInfoEvent*) obj;
-(float) calculatorHeight:(ShopInfoEvent*) obj;
+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, weak, readonly) ShopInfoEvent *object;
@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ShopEventTableCell)

-(void) registerShopEventTableCell;
-(ShopEventTableCell*) shopEventTableCell;
-(ShopEventTableCell*) shopEventTablePrototypeCell;

@end