//
//  ShopInfoTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Label;

@interface ShopDescTableCell : UITableViewCell
{
    __weak IBOutlet Label *lblThongTin;
    __weak IBOutlet Label *lblDesc;
    __weak IBOutlet UIView *line;
    
}

+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, assign) bool isPrototypeCell;

@end

@interface UITableView(ShopDescTableCell)

-(void) registerShopDescTableCell;
-(ShopDescTableCell*) shopDescTableCell;
-(ShopDescTableCell*) shopDescTablePrototypeCell;

@end