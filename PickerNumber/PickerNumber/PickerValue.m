//
//  PickerValue.m
//  PickerNumber
//
//  Created by MacMini on 11/12/2013.
//  Copyright (c) 2013 MacMini. All rights reserved.
//

#import "PickerValue.h"

@implementation PickerValue

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    if(self.subviews.count==0)
    {
        CGRect rect=self.frame;
        rect.size=CGSizeMake(46, 65);
        self.frame=rect;
        
        rect.origin.x=0;
        rect.origin.y=23;
        rect.size.height=17;
        UITableView *table=[[UITableView alloc] initWithFrame:rect];
        table.separatorStyle=UITableViewCellSelectionStyleNone;
        table.showsHorizontalScrollIndicator=false;
        table.showsVerticalScrollIndicator=false;
        table.delaysContentTouches=false;
        table.canCancelContentTouches=false;
        table.bouncesZoom=false;
        table.backgroundColor=[UIColor whiteColor];
        table.dataSource=self;
        table.delegate=self;
        
        [self addSubview:table];
        
        rect.origin=CGPointMake(0, -2);
        rect.size.width=46;
        rect.size.height=65;
        UILabel *lbl=[[UILabel alloc] initWithFrame:rect];
        lbl.backgroundColor=[UIColor clearColor];
        lbl.textAlignment=NSTextAlignmentLeft;
        lbl.textColor=[UIColor grayColor];
        lbl.text=@"x";
        
        [self addSubview:lbl];
        
        rect.origin=CGPointZero;
        rect.size=CGSizeMake(46, 23);
        PickerView *view=[[PickerView alloc] initWithFrame:rect];
        view.backgroundColor=[UIColor colorWithRed:235.f/255 green:235.f/255 blue:235.f/255 alpha:1];
        view.table=table;
        
        [self addSubview:view];
        
        rect.origin=CGPointMake(0, 40);
        rect.size.height=25;
        view=[[PickerView alloc] initWithFrame:rect];
        view.backgroundColor=[UIColor colorWithRed:235.f/255 green:235.f/255 blue:235.f/255 alpha:1];
        view.table=table;
        
        [self addSubview:view];
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    UITableView *table=(UITableView*)scrollView;
    NSIndexPath *indexPath=[table indexPathForRowAtPoint:CGPointMake(targetContentOffset->x, targetContentOffset->y)];
    
    if(indexPath)
    {
        targetContentOffset->y=[table rectForRowAtIndexPath:indexPath].origin.y;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65-23-25;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *lbl=nil;
    
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        CGRect rect=tableView.frame;
        rect.origin=CGPointZero;
        UILabel *label=[[UILabel alloc] initWithFrame:rect];
        label.backgroundColor=[UIColor redColor];
        label.font=[UIFont systemFontOfSize:8];
        label.textAlignment=NSTextAlignmentCenter;
        
        [cell.contentView addSubview:label];
    }
    
    lbl=cell.contentView.subviews[0];
    
    lbl.text=[NSString stringWithFormat:@"%i",indexPath.row];
    
    return cell;
}

@end

@implementation PickerView
@synthesize table;

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view=[super hitTest:point withEvent:event];
    
    if(view==self)
        return table;
    
    return view;
}

@end