//
//  SUKM1Cell.m
//  SmartGuide
//
//  Created by MacMini on 04/12/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SUKM1Cell.h"
#import "Utility.h"

@implementation SUKM1Cell
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
    return [ShopKM1Cell heightWithContent:[_km1.listVoucherObjects[indexPath.row] name]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopKM1Cell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopKM1Cell reuseIdentifier]];
    
    KM1Voucher *voucher=_km1.listVoucherObjects[indexPath.row];
    
    [cell setVoucher:voucher.type content:voucher.name sgp:voucher.sgp isHighlighted:voucher.isAfford.boolValue];
    
    return cell;
}

+(NSString *)reuseIdentifier
{
    return @"SUKM1Cell";
}

+(float)heightWithKM1:(ShopKM1 *)km1
{
    float height=161;
    for(KM1Voucher *voucher in km1.listVoucherObjects)
    {
        height+=[ShopKM1Cell heightWithContent:voucher.name];
    }
    
    return height;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerNib:[UINib nibWithNibName:[ShopKM1Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopKM1Cell reuseIdentifier]];
    
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
    [self.delegate km1TouchedScan:self];
}

@end