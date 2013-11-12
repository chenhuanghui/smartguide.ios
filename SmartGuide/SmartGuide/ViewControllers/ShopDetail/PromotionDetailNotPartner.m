//
//  PromotionDetailNotPartner.m
//  SmartGuide
//
//  Created by MacMini on 11/11/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "PromotionDetailNotPartner.h"
#import "PromotionDetailNotPartnerCell.h"
#import "PromotionVoucher.h"

@implementation PromotionDetailNotPartner
@synthesize handler;

-(PromotionDetailNotPartner *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"PromotionDetailNotPartner") owner:nil options:nil] objectAtIndex:0];
    
    tableFrame=tablePromotion.frame;
    
    [tablePromotion registerNib:[UINib nibWithNibName:[PromotionDetailNotPartnerCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[PromotionDetailNotPartnerCell reuseIdentifier]];
    
    [self setShop:shop];
    
    return self;
}

-(void)setShop:(Shop *)shop
{
    if(!shop)
    {
        [self reset];
        return;
    }
    
    _shop=shop;
    
    lblDuration.text=_shop.promotionDetail.duration;
    
    tablePromotion.dataSource=self;
    tablePromotion.delegate=self;
    
    [tablePromotion reloadData];
    
    if(tablePromotion.contentSize.height<tablePromotion.frame.size.height)
    {
        CGRect rect=tablePromotion.frame;
        rect.origin.y=(tablePromotion.frame.size.height-tablePromotion.contentSize.height)/2+tableFrame.origin.y;
        tablePromotion.frame=rect;
        
        NSLog(@"tablePromotion %@ %@",NSStringFromCGRect(tablePromotion.frame),NSStringFromCGRect(self.frame));
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shop.promotionDetail.vouchers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionVoucher *voucher=_shop.promotionDetail.vouchersObjects[indexPath.row];
    PromotionDetailNotPartnerCell *cell=[tableView dequeueReusableCellWithIdentifier:[PromotionDetailNotPartnerCell reuseIdentifier]];
    
    [cell loadWithTitle:voucher.title content:voucher.content];
    
    if(_shop.promotionDetail.vouchersObjects.count==1)
        [cell setLineVisible:false];
    else if(indexPath.row==_shop.promotionDetail.vouchersObjects.count-1)
        [cell setLineVisible:false];
    else
        [cell setLineVisible:true];
        
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionVoucher *voucher=_shop.promotionDetail.vouchersObjects[indexPath.row];
    
    return [PromotionDetailNotPartnerCell heightWithContent:voucher.content];
}

-(void)reset
{
    _shop=nil;
    tablePromotion.dataSource=nil;
    tablePromotion.delegate=nil;
}

-(void)reloadWithShop:(Shop *)shop
{
    [self setShop:shop];
}

@end
