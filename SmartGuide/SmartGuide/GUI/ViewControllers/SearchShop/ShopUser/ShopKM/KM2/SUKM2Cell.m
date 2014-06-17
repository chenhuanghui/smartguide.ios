//
//  SUKM2Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUKM2Cell.h"
#import "ShopKM2Cell.h"
#import "ShopKM2NonConditionCell.h"

@implementation SUKM2Cell
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
    
    [table registerNib:[UINib nibWithNibName:[ShopKM2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM2Cell reuseIdentifier]];
    [table registerNib:[UINib nibWithNibName:[ShopKM2NonConditionCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM2NonConditionCell reuseIdentifier]];
}

+(NSString *)reuseIdentifier
{
    return @"SUKM2Cell";
}

+(float)heightWithKM2:(ShopKM2 *)km2
{
    float height=161;
    
    for(KM2Voucher *voucher in km2.listVoucherObjects)
    {
        if(voucher.condition.length==0)
            height+=[ShopKM2NonConditionCell heightWithVoucher:voucher];
        else
            height+=[ShopKM2Cell heightWithKM2:voucher];
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
    return voucher.voucherHeight.floatValue;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KM2Voucher *voucher=_vouchers[indexPath.row];
    
    if(voucher.condition.length==0)
    {
        ShopKM2NonConditionCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM2NonConditionCell reuseIdentifier]];
        
        [cell loadWithVoucher:voucher];
        
        return cell;
    }
    else
    {
        ShopKM2Cell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM2Cell reuseIdentifier]];
        
        [cell loadWithKM2:voucher];
        
        return cell;
    }
}

- (IBAction)scanTouchUpInside:(id)sender {
    [self.delegate km2TouchedScan:self];
}

@end
