//
//  ShopMenu.m
//  SmartGuide
//
//  Created by XXX on 7/31/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "ShopMenu.h"
#import "ShopProduct.h"
#import "ShopMenuCell.h"

@implementation ShopMenu
@synthesize isProcessedData,handler;

-(ShopMenu *)initWithShop:(Shop *)shop
{
    self=[[[NSBundle mainBundle] loadNibNamed:NIB_PHONE(@"ShopMenu") owner:nil options:nil] objectAtIndex:0];
    
    _productType=[NSMutableDictionary dictionary];
    _productTypeName=[NSArray array];
    [self setShop:shop];
    [tableMenu registerNib:[UINib nibWithNibName:[ShopMenuCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopMenuCell reuseIdentifier]];
    
    _priceFormat=[[NSNumberFormatter alloc] init];
    [_priceFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_priceFormat setMinimumFractionDigits:0];
    [_priceFormat setMaximumFractionDigits:0];
    _priceFormat.currencySymbol=@"";
    
    return self;
}

-(void)processFirstDataBackground:(NSMutableArray *)firstData
{
    _productType=[[NSMutableDictionary alloc] init];
    _productTypeName=[[firstData valueForKey:ShopProduct_Cat_name] copy];
    _productTypeName=[_productTypeName sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSMutableArray *array=[NSMutableArray array];
    
    for(NSString *str in _productTypeName)
    {
        if(![array containsObject:str])
            [array addObject:str];
    }
    
    _productTypeName=[[NSMutableArray alloc] initWithArray:array];
    
    for(NSString *str in _productTypeName)
    {
        NSArray *arr=[firstData filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@",ShopProduct_Cat_name,str]];
        arr=[arr sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:ShopProduct_Name ascending:true]]];
        [_productType setObject:arr forKey:str];
    }
    
    isProcessedData=true;
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        if(self.superview)
        {
            [tableMenu reloadData];
            [self removeLoading];
        }
    });
    
}

-(void)reset
{
    _productTypeName=[NSArray array];
    _productType=[NSMutableDictionary dictionary];
    
    [tableMenu reloadData];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if(!isProcessedData)
    {
        [self showLoadingWithTitle:nil];
    }
    else
    {
        [self removeLoading];
        [tableMenu reloadData];
    }
}

-(void)cancel
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void)setShop:(Shop *)shop
{
    _shop=shop;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _shop==nil?0:_productType.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key=[_productTypeName objectAtIndex:section];
    return ((NSArray*)[_productType objectForKey:key]).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopMenuCell *cell=[tableView dequeueReusableCellWithIdentifier:[ShopMenuCell reuseIdentifier]];
    NSString *key=[_productTypeName objectAtIndex:indexPath.section];
    ShopProduct *product=[[_productType objectForKey:key] objectAtIndex:indexPath.row];
    
    [cell setName:product.name setPrice:product.price];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key=[_productTypeName objectAtIndex:indexPath.section];
    ShopProduct *product=[[_productType objectForKey:key] objectAtIndex:indexPath.row];
    return [ShopMenuCell heightWithContent:product.name];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 21)];
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 21)];
    lbl.font=[UIFont boldSystemFontOfSize:9];
    lbl.text=[_productTypeName objectAtIndex:section];
    
    [view addSubview:lbl];
    
    return view;
}

-(UITableView *)tableMenu
{
    return tableMenu;
}

@end
