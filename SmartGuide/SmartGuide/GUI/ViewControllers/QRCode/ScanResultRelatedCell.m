//
//  ScanResultRelatedCell.m
//  Infory
//
//  Created by XXX on 7/2/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedCell.h"
#import "ScanResultObjectCell.h"
#import "ScanCodeRelated.h"
#import "ScanCodeResult.h"
#import "ScanCodeRelatedContain.h"
#import "ScanResultViewController.h"
#import "ScanResultRelatedMoreCell.h"
#import "ScanResultObjectHeaderView.h"

@interface ScanResultRelatedCell()<UITableViewDataSource,UITableViewDelegate, ScanResultObjectCellDelegate>

@end

@implementation ScanResultRelatedCell
@synthesize suggestHeight;

-(void)loadWithResult:(ScanCodeResult *)result height:(float)height
{
    _result=result;
    _tableHeight=height;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [table l_v_setH:_tableHeight];
    [table reloadData];
    table.userInteractionEnabled=true;
    table.scrollEnabled=false;
    
    suggestHeight=table.contentSize.height;
}

-(void)tableDidScroll:(UITableView *)tableResult
{
    NSIndexPath *indexPath=[tableResult indexPathForCell:self];
    CGRect rect=[tableResult rectForRowAtIndexPath:indexPath];
    CGRect headerRect=[tableResult rectForHeaderInSection:indexPath.section];
    float y=tableResult.l_co_y+headerRect.size.height;
    
    if(y-rect.origin.y>0)
    {
        [table l_v_setY:y-rect.origin.y];
        [table l_co_setY:y-rect.origin.y];
    }
    else
    {
        [table l_v_setY:0];
        [table l_co_setY:0];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _result.relatedContainObjects.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ScanCodeRelatedContain *obj=_result.relatedContainObjects[section];
    
    int count=obj.relatiesObjects.count;
    
    // Chỉ hiển thị 5 item đầu tiên
    count=MIN(count,5);
    
    // Item xem thêm
    if(count>0)
        count++;
    
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanCodeRelatedContain *objContain=_result.relatedContainObjects[indexPath.section];
    
    int count=objContain.relatiesObjects.count;
    
    count=MIN(count,5)+1;
    
    if(indexPath.row==count-1)
        return [ScanResultRelatedMoreCell height];
    
    ScanCodeRelated *obj=objContain.relatiesObjects[indexPath.row];
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
    [cell loadWithRelated:obj];
    [cell layoutSubviews];
    
    return cell.suggestHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanCodeRelatedContain *objContain=_result.relatedContainObjects[indexPath.section];
    
    int count=objContain.relatiesObjects.count;
    
    count=MIN(count,5)+1;
    
    if(indexPath.row==count-1)
        return [tableView scanResultRelatedMoreCell];
    
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
    
    cell.delegate=self;
    [cell loadWithRelated:objContain.relatiesObjects[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[table cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[ScanResultObjectCell class]])
    {
    }
    else if([cell isKindOfClass:[ScanResultRelatedMoreCell class]])
    {
        [self.delegate scanResultRelatedCellTouchedMore:self object:_result.relatedContainObjects[indexPath.section]];
    }
}

-(void)scanResultObjectCellTouched:(ScanResultObjectCell *)cell
{
    [self.delegate scanResultRelatedCell:self touchedObject:cell.obj];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [ScanResultObjectHeaderView height];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ScanResultObjectHeaderView *header=[ScanResultObjectHeaderView new];
    [header loadWithObject:_result.relatedContainObjects[section]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader:)];
    
    [header addGestureRecognizer:tap];
    
    return header;
}

-(void) tapHeader:(UITapGestureRecognizer*) tap
{
    ScanResultObjectHeaderView *header=(ScanResultObjectHeaderView*)tap.view;
    
    if([header isKindOfClass:[ScanResultObjectHeaderView class]])
    {
        [self.delegate scanResultRelatedCellTouchedMore:self object:header.object];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [table registerScanResultObjectCell];
    [table registerScanResultRelatedMoreCell];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultRelatedCell";
}

@end

@implementation UITableView(ScanResultRelatedCell)

-(void)registerScanResultRelatedCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultRelatedCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultRelatedCell reuseIdentifier]];
}

-(ScanResultRelatedCell *)scanResultRelatedCell
{
    return [self dequeueReusableCellWithIdentifier:[ScanResultRelatedCell reuseIdentifier]];
}

@end