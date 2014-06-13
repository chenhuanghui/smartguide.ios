//
//  SUKM1Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopKM1ControllerCell.h"
#import "Utility.h"

@implementation ShopKM1ControllerCell
@synthesize delegate;

-(void)loadWithKM1:(ShopKM1 *)km1
{
    _km1=km1;
    
    btnFirstScan.hidden=km1.hasSGP.integerValue==1;
    hasSGPView.hidden=!btnFirstScan.hidden;
    
    lblDuration.text=_km1.duration;

    [lbl100K setText:[NSString stringWithFormat:@"<text>Với mỗi <k>%@</k> trên hoá đơn bạn nhận được 1 lượt quét thẻ</text>",_km1.money]];
    
    lblText.text=_km1.text;
    
    table.dataSource=self;
    table.delegate=self;
    [table reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _km1.listVoucherObjects.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _km1.listVoucherObjects.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ShopKM1Cell heightWithVoucher:_km1.listVoucherObjects[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopKM1Cell *cell=[tableView shopKM1Cell];
    
    KM1Voucher *voucher=_km1.listVoucherObjects[indexPath.row];
    
    [cell setVoucher:voucher.type content:voucher.name sgp:voucher.sgp isHighlighted:voucher.isAfford.boolValue];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"ShopKM1ControllerCell";
}

+(float)heightWithKM1:(ShopKM1 *)km1
{
    float height=161;
    for(KM1Voucher *voucher in km1.listVoucherObjects)
    {
        height+=[ShopKM1Cell heightWithVoucher:voucher];
    }
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerShopKM1Cell];
    
//    bgStatusView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"k"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor colorWithRed:1.000 green:0.314 blue:0.165 alpha:1];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:11];
    
    [lbl100K addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor colorWithRed:0.616 green:0.616 blue:0.616 alpha:1];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lbl100K addStyle:style];
    
    [lbl100K setText:@"<text>Với mỗi <k>100k</k> trên hoá đơn bạn nhận được 1 lượt quét thẻ</text>"];
}

- (IBAction)scanTouchUpInside:(id)sender {
    [self.delegate shopKM1ControllerCellTouchedScan:self];
}

@end

@implementation UITableView(ShopKM1ControllerCell)

-(void)registerShopKM1ControllerCell
{
    [self registerNib:[UINib nibWithNibName:[ShopKM1ControllerCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM1ControllerCell reuseIdentifier]];
}

-(ShopKM1ControllerCell *)shopKM1ControllerCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopKM1ControllerCell reuseIdentifier]];
}

@end