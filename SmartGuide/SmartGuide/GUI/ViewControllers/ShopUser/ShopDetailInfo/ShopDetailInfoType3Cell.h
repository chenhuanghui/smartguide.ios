//
//  ShopDetailInfoImageCell.h
//  SmartGuide
//
//  Created by MacMini on 03/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class Info3;

@interface ShopDetailInfoType3Cell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UIImageView *imgv;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *line;
    __weak IBOutlet UIView *textView;
    __weak Info3 *_info;
}

-(void) loadWithInfo3:(Info3*) info3;
-(Info3*) info;
-(void)setCellPos:(enum CELL_POSITION)cellPos;

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopDetailInfoType3Cell)

-(void) registerShopDetailInfoType3Cell;
-(ShopDetailInfoType3Cell*) shopDetailInfoType3Cell;

@end