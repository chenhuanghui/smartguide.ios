//
//  ShopListPlaceCell.h
//  SmartGuide
//
//  Created by MacMini on 18/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class Placelist, UserHome3;

@interface ShopListPlaceCell : UITableViewCell<TableViewCellDynamicHeight>
{
    __weak IBOutlet UIImageView *imgvIcon;
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UILabel *lblAuthorName;
    __weak IBOutlet UILabel *lblNumOfView;
    __weak IBOutlet UILabel *lblContent;
    __weak IBOutlet UIImageView *imgvAuthorAvatar;
    
    __weak Placelist *_obj;
}

-(void) loadWithPlace:(Placelist*) place;

+(NSString *)reuseIdentifier;
+(float)titleHeight;

@end

@interface UITableView(ShopListPlaceCell)

-(void) registerShopListPlaceCell;
-(ShopListPlaceCell*) shopListPlaceCell;

@end