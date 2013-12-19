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

-(void)loadWithKM1:(ShopKM1 *)km1
{
    _km1=km1;
    
    lblDuration.text=_km1.duration;
    lblSGP.text=_km1.sgp;

    [lbl100K setText:[NSString stringWithFormat:@"<text>Với mỗi <k>%@</k> trên hoá đơn bạn nhận được 1 lượt quét thẻ</text>",_km1.money]];
    [lblSP setText:[NSString stringWithFormat:@"<text><sp>%@</sp> tích luỹ</text>",_km1.sp]];
    [lblP setText:[NSString stringWithFormat:@"<text><p>%@</p> cho <p>1 SGP</p></text>",_km1.p]];
    
    lblNotice.text=_km1.notice;
    
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
    float height=208;
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
    
    bgStatusView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_status.png"]];
    
    FTCoreTextStyle *style=[FTCoreTextStyle styleWithName:@"k"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor redColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:11];
    
    [lbl100K addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"sp"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:11];
    
    [lblSP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"p"];
    style.textAlignment=FTCoreTextAlignementLeft;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Heavy" size:11];
    
    [lblP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lbl100K addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lblSP addStyle:style];
    
    style=[FTCoreTextStyle styleWithName:@"text"];
    style.textAlignment=FTCoreTextAlignementCenter;
    style.color=[UIColor darkGrayColor];
    style.font=[UIFont fontWithName:@"Avenir-Roman" size:10];
    
    [lblP addStyle:style];
    
    [lbl100K setText:@"<text>Với mỗi <k>100k</k> trên hoá đơn bạn nhận được 1 lượt quét thẻ</text>"];
    [lblSP setText:@"<text><sp>300 SP</sp> tích luỹ</text>"];
    [lblP setText:@"<text><p>10 P</p> cho <p>1 SGP</p></text>"];
}

@end

@implementation PromotionDetailView

-(void)drawRect:(CGRect)rect
{
    if(!img)
        img=[UIImage imageNamed:@"pattern_promotion.png"];
    
    rect.origin=CGPointZero;
    
    [img drawAsPatternInRect:rect];
}

@end