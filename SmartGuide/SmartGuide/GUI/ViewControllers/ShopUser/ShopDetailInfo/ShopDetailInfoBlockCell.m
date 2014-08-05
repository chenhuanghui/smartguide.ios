//
//  ShopDetailInfoBlockCell.m
//  Infory
//
//  Created by XXX on 7/30/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ShopDetailInfoBlockCell.h"
#import "ShopDetailInfoType1Cell.h"
#import "ShopDetailInfoType2Cell.h"
#import "ShopDetailInfoType3Cell.h"
#import "ShopDetailInfoType4Cell.h"
#import "ASIOperationShopDetailInfo.h"

@interface ShopDetailInfoBlockCell()<ShopDetailInfoType2Delegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation ShopDetailInfoBlockCell
@synthesize suggestHeight, isCalculatingSuggestHeight;

-(void)loadWithInfoObject:(InfoTypeObject *)obj
{
    _obj=obj;
    [self setNeedsLayout];
}

-(void)calculatingSuggestHeight
{
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    table.dataSource=self;
    table.delegate=self;
    [table l_v_setH:self.tableDetail.l_v_h];
    [table reloadData];
    
    suggestHeight=table.contentSize.height;
}

-(void)tableDidScroll:(UITableView *)tableDetail
{
    NSIndexPath *idx=[tableDetail indexPathForCell:self];
    CGRect headerRect=[tableDetail rectForHeaderInSection:idx.section];
    CGRect rect=[tableDetail rectForRowAtIndexPath:idx];
    
    float y=tableDetail.contentOffset.y+headerRect.size.height;
    
    if(y>rect.origin.y)
    {
        float diff=y-rect.origin.y;
        [table l_v_setY:diff];
        [table l_co_setY:diff];
    }
    else
    {
        [table l_v_setY:0];
        [table l_co_setY:0];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MIN(1,_obj.items.count);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _obj.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item=_obj.items[indexPath.row];
    
    switch (_obj.enumType) {
        case DETAIL_INFO_TYPE_1:
            return [ShopDetailInfoType1Cell heightWithInfo1:item];
            
        case DETAIL_INFO_TYPE_2:
            return [ShopDetailInfoType2Cell heightWithInfo2:item];
            
        case DETAIL_INFO_TYPE_3:
        {
            ShopDetailInfoType3Cell *cell=[tableView shopDetailInfoType3Cell];
            [cell loadWithInfo3:item];
            [cell calculatingSuggestHeight];
            
            return [cell suggestHeight];
        }
            
        case DETAIL_INFO_TYPE_4:
            return [ShopDetailInfoType4Cell heightWithInfo4:item];
            
        case DETAIL_INFO_TYPE_UNKNOW:
            return 0;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id info=_obj.items[indexPath.row];
    switch (_obj.enumType) {
        case DETAIL_INFO_TYPE_1:
        {
            ShopDetailInfoType1Cell *cell=[tableView shopDetailInfoType1Cell];
         
            [cell loadWithInfo1:info];
            [cell setCellPos:[tableView getCellPosition:indexPath]];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_2:
        {
            ShopDetailInfoType2Cell *cell=[tableView shopDetailInfoType2Cell];
            
            [cell loadWithInfo2:info];
            [cell setCellPos:[tableView getCellPosition:indexPath]];
            cell.delegate=self;
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_3:
        {
            ShopDetailInfoType3Cell *cell=[tableView shopDetailInfoType3Cell];
            
            [cell loadWithInfo3:info];
            [cell setCellPos:[tableView getCellPosition:indexPath]];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_4:
        {
            ShopDetailInfoType4Cell *cell=[tableView shopDetailInfoType4Cell];
            
            [cell loadWithInfo4:info];
            [cell setCellPos:[tableView getCellPosition:indexPath]];
            
            return cell;
        }
            
        case DETAIL_INFO_TYPE_UNKNOW:
            return [UITableViewCell new];
    }
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([selectedCell isKindOfClass:[ShopDetailInfoType3Cell class]])
    {
        ShopDetailInfoType3Cell *cell=(id)selectedCell;
        
        if([cell.info.idShop hasData])
            [self.delegate shopDetailInfoBlockCell:self touchedIDShop:cell.info.idShop.integerValue];
    }
}

-(void)shopDetailInfoType2TouchedURL:(ShopDetailInfoType2Cell *)cell url:(NSURL *)url
{
    [self.delegate shopDetailInfoBlockCell:self touchedURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"ShopDetailInfoBlockCell";
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerShopDetailInfoType1Cell];
    [table registerShopDetailInfoType2Cell];
    [table registerShopDetailInfoType3Cell];
    [table registerShopDetailInfoType4Cell];
}

@end

@implementation UITableView(ShopDetailInfoBlockCell)

-(void)registerShopDetailInfoBlockCell
{
    [self registerNib:[UINib nibWithNibName:[ShopDetailInfoBlockCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ShopDetailInfoBlockCell reuseIdentifier]];
}

-(ShopDetailInfoBlockCell *)shopDetailInfoBlockCell
{
    return [self dequeueReusableCellWithIdentifier:[ShopDetailInfoBlockCell reuseIdentifier]];
}

@end