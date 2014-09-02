//
//  ShopContactTableCell.m
//  Infory
//
//  Created by XXX on 8/29/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopContactTableCell.h"
#import "ShopInfo.h"

@implementation ShopContactTableCell

-(void)loadWithShopInfo:(ShopInfo *)obj
{
    _obj=obj;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    lblMail.text=@"";
    lblPhone.text=_obj.telDisplay;
}

+(NSString *)reuseIdentifier
{
    return @"ShopContactTableCell";
}

+(float)height
{
    return 108;
}

@end

@implementation UITableView(ShopContactTableCell)

-(void) registerShopContactTableCell
{
    [self registerNib:[UINib nibWithNibName:[ShopContactTableCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopContactTableCell reuseIdentifier]];
}

-(ShopContactTableCell*) shopContactTableCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopContactTableCell reuseIdentifier]];
}

@end