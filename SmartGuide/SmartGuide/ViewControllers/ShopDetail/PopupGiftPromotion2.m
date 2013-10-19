//
//  PopupGiftPromotion2.m
//  SmartGuide
//
//  Created by MacMini on 10/3/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PopupGiftPromotion2.h"
#import "GiftPromotion2Cell.h"
#import "Utility.h"

@implementation PopupGiftPromotion2
@synthesize delegate;

-(PopupGiftPromotion2 *)initWithVouchers:(NSArray *)vouchesr delegate:(id<PopupGiftPromotionDelegate>)_delegate
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"PopupGiftPromotion2" owner:nil options:nil] objectAtIndex:0];
    
    _vouchers=[[NSMutableArray alloc] initWithArray:vouchesr];

    self.delegate=_delegate;
    
    [table registerNib:[UINib nibWithNibName:[GiftPromotion2Cell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[GiftPromotion2Cell reuseIdentifier]];
    table.layer.masksToBounds=true;
    
    float height=[GiftPromotion2Cell size].height;
    
    if(_vouchers.count==1)
        height+=HEIGHT_PHONE(0, 40);
    else if(_vouchers.count==2)
    {
        height=(table.frame.size.height-height*2)/2;
        height-=5;
        height+=HEIGHT_PHONE(0, 35);
    }
    else if(_vouchers.count>=3)
        height=HEIGHT_PHONE(0, 0);
    
    if(_vouchers.count<=3)
        table.scrollEnabled=false;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width, height)];
    view.backgroundColor=[UIColor clearColor];
    
    table.tableHeaderView=view;
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _vouchers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GiftPromotion2Cell *cell=[table dequeueReusableCellWithIdentifier:[GiftPromotion2Cell reuseIdentifier]];
    PromotionVoucher *voucher=[_vouchers objectAtIndex:indexPath.row];
    
    [cell setReward:voucher.desc p:[NSString stringWithFormat:@"%@",voucher.p] numberVoucher:voucher.numberVoucher];
    
    if(indexPath.row==_vouchers.count-1)
        [cell setLineVisible:false];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionVoucher *voucher=[_vouchers objectAtIndex:indexPath.row];
    [delegate popupGiftDidSelectedVoucher:self voucher:voucher];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GiftPromotion2Cell size].height+3;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate popupGiftDidCancelled:self];
}

@end
