//
//  ShopGalleryTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopGalleryTableCell.h"

@implementation ShopGalleryTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopGalleryTableCell";
}

@end

@implementation UITableView(ShopGalleryTableCell)

-(void) registerShopGalleryTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopGalleryTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopGalleryTableCell reuseIdentifier]];
}

-(ShopGalleryTableCell*) shopGalleryTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopGalleryTableCell reuseIdentifier]];
}

@end