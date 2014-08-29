//
//  ShopUserGalleryTableCell.h
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopUserGalleryTableCell : UITableViewCell

+(NSString *)reuseIdentifier;

@end

@interface UITableView(ShopUserGalleryTableCell)

-(void) registerShopUserGalleryTableCell;
-(ShopUserGalleryTableCell*) shopUserGalleryTableCell;

@end