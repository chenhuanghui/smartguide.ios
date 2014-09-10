//
//  ScanResultRelatedCell.m
//  Infory
//
//  Created by XXX on 9/9/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "ScanResultRelatedCell.h"
#import "Utility.h"
#import "ScanResultObjectCell.h"
#import "ScanResultObjectHeaderView.h"
#import "ScanCodeRelatedContain.h"

@interface ScanResultRelatedCell()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ScanResultRelatedCell

-(void)loadWithRelatedContain:(NSArray *)objs
{
    _objs=objs;
    
    [self setNeedsLayout];
}

-(float)calculatorHeight:(NSArray *)objs
{
    self.table.frame=CGRectMake(0, 0, self.SW, MIN(self.SH, UIApplicationSize().height));
    _objs=objs;
    
    [self.table reloadData];
    
    return self.table.contentSize.height;
}

-(void)layoutSubviews
{
    if(_isPrototypeCell)
        return;
    
    [super layoutSubviews];
    
    [self calculatorHeight:_objs];
    
    [self.table reloadData];
}

#pragma mark UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _objs.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_objs[section] relatiesObjects] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [ScanResultObjectHeaderView height];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ScanResultObjectHeaderView *view=[ScanResultObjectHeaderView new];
    
    [view loadWithObject:_objs[section]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader:)];
    [view addGestureRecognizer:tap];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj=[[_objs[indexPath.section] relatiesObjects] objectAtIndex:indexPath.row];
    
    return [[tableView scanResultObjectPrototypeCell] calculatorHeight:obj];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScanResultObjectCell *cell=[tableView scanResultObjectCell];
    id obj=[[_objs[indexPath.section] relatiesObjects] objectAtIndex:indexPath.row];
    
    [cell loadWithRelated:obj];
    
    return cell;
}

-(void) tapHeader:(UITapGestureRecognizer*) tap
{
    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.table.autoresizingMask=UIViewAutoresizingNone;
    self.autoresizesSubviews=false;
    self.contentView.autoresizesSubviews=false;
    
    [self.table registerScanResultObjectCell];
}

+(NSString *)reuseIdentifier
{
    return @"ScanResultRelatedCell";
}

@end

#import <objc/runtime.h>
static char ScanResultRelatedPrototypeCellKey;

@implementation UITableView(ScanResultRelatedCell)

-(void) registerScanResultRelatedCell
{
    [self registerNib:[UINib nibWithNibName:[ScanResultRelatedCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ScanResultRelatedCell reuseIdentifier]];
}

-(ScanResultRelatedCell*) scanResultRelatedCell
{
    ScanResultRelatedCell *obj=[self dequeueReusableCellWithIdentifier:[ScanResultRelatedCell reuseIdentifier]];
    
    obj.isPrototypeCell=false;
    
    return obj;
}

-(ScanResultRelatedCell *)scanResultRelatedPrototypeCell
{
    ScanResultRelatedCell *obj=objc_getAssociatedObject(self, &ScanResultRelatedPrototypeCellKey);

    if(!obj)
    {
        obj=[self scanResultRelatedCell];
        objc_setAssociatedObject(self, &ScanResultRelatedPrototypeCellKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    obj.isPrototypeCell=true;
    
    return obj;
}

@end