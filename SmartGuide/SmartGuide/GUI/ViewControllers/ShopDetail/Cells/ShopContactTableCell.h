//
//  ShopContactTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopInfo;

@interface ShopContactTableCell : UITableViewCell
{
    __weak IBOutlet UILabel *lblPhone;
    __weak IBOutlet UILabel *lblMail;
}

-(void) loadWithShopInfo:(ShopInfo*) obj;
+(NSString *)reuseIdentifier;
+(float) height;

@property (nonatomic, weak) ShopInfo *obj;

@end

@interface UITableView(ShopContactTableCell)

-(void) registerShopContactTableCell;
-(ShopContactTableCell*) shopContactTableCell;

@end