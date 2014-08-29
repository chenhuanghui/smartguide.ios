//
//  ShopUserGalleryTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopUserGalleryTableCell.h"

@implementation ShopUserGalleryTableCell

+(NSString *)reuseIdentifier
{
    return @"ShopUserGalleryTableCell";
}

@end

@implementation UITableView(ShopUserGalleryTableCell)

-(void) registerShopUserGalleryTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopUserGalleryTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopUserGalleryTableCell reuseIdentifier]];
}

-(ShopUserGalleryTableCell*) shopUserGalleryTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopUserGalleryTableCell reuseIdentifier]];
}

@end