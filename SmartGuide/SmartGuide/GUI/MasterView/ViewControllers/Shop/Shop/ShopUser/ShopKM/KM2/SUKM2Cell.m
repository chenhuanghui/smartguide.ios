//
//  SUKM2Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUKM2Cell.h"
#import "ShopKM2Cell.h"

@implementation SUKM2Cell

-(void)loadWithKM2:(ShopKM2 *)km2
{
    _km2=km2;
    
    lblDuration.text=km2.duration;
    lblNote.text=km2.note;
    lblText.text=km2.text;
    
    [table reloadData];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopKM2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM2Cell reuseIdentifier]];
}

+(NSString *)reuseIdentifier
{
    return @"SUKM2Cell";
}

+(float)heightWithKM2:(ShopKM2 *)km2
{
    float height=161;
    
    for(KM2Voucher *voucher in km2.listVoucherObjects)
        height+=[ShopKM2Cell heightWithKM2:voucher];
    
    return height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _km2.listVoucherObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _km2.listVoucherObjects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopKM2Cell heightWithKM2:_km2.listVoucherObjects[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopKM2Cell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM2Cell reuseIdentifier]];
    
    [cell loadWithKM2:_km2.listVoucherObjects[indexPath.row]];
    
    return cell;
}

@end
