//
//  SUKM2Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopKM2ControllerCell.h"
#import "ShopKM2ConditionCell.h"
#import "ShopKM2NonConditionCell.h"

@implementation ShopKM2ControllerCell
@synthesize delegate;

-(void)loadWithKM2:(ShopKM2 *)km2
{
    _km2=km2;
    
    lblDuration.text=km2.duration;
    lblNote.text=km2.note;
    lblText.text=km2.text;
    
    _vouchers=km2.listVoucherObjects;
    
    [table reloadData];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerShopKM2NonConditionCell];
    [table registerShopKM2ConditionCell];
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM2ControllerCell";
}

+(float)heightWithKM2:(ShopKM2 *)km2
{
    float height=161;
    
    for(KM2Voucher *voucher in km2.listVoucherObjects)
    {
        if(voucher.condition.length==0)
            height+=[ShopKM2NonConditionCell heightWithVoucher:voucher];
        else
            height+=[ShopKM2ConditionCell heightWithKM2:voucher];
    }
    
    return height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _vouchers.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _vouchers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KM2Voucher *voucher=_vouchers[indexPath.row];
    
    if(voucher.condition.length==0)
        return [ShopKM2NonConditionCell heightWithVoucher:voucher];
    else
        return [ShopKM2ConditionCell heightWithKM2:voucher];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KM2Voucher *voucher=_vouchers[indexPath.row];
    
    if(voucher.condition.length==0)
    {
        ShopKM2NonConditionCell *cell=[tableView shopKM2NonConditionCell];
        
        [cell loadWithVoucher:voucher];
        
        return cell;
    }
    else
    {
        ShopKM2ConditionCell *cell=[tableView shopKM2ConditionCell];
        
        [cell loadWithKM2:voucher];
        
        return cell;
    }
}

- (IBAction)scanTouchUpInside:(id)sender {
    [self.delegate shopKM2ControllerCellDelegateTouchedScan:self];
}

@end

@implementation UICollectionView(ShopKM2ControllerCell)

-(void)registerShopKM2ControllerCell
{
    [self registerNib:[UINib nibWithNibName:[ShopKM2ControllerCell reuseIdentifier] bundle:nil] forCellWithReuseIdentifier:[ShopKM2ControllerCell reuseIdentifier]];
}

-(ShopKM2ControllerCell *)shopKM2ControllerCellForIndexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:[ShopKM2ControllerCell reuseIdentifier] forIndexPath:indexPath];
}

@end
