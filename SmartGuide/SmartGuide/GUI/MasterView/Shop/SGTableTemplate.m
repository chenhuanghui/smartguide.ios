//
//  SGTableTemplate.m
//  SmartGuide
//
//  Created by MacMini on 29/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "SGTableTemplate.h"
#import "ODRefreshControl.h"
#import "LoadingCell.h"

@interface SGTableTemplate()

@property (nonatomic, weak) ODRefreshControl *refreshControl;

@end

@implementation SGTableTemplate
@synthesize datasource,page,delegate,tableHandled,isAllowLoadMore,isAllowPullToRefresh;
@synthesize refreshControl;

-(SGTableTemplate *)initWithTableView:(UITableView *)table withDelegate:(id<SGTableTemplateDelegate>)_delegate
{
    self=[super init];
    
    self.delegate=_delegate;
    
    self.datasource=[NSMutableArray array];
    self.page=0;
    
    self.tableHandled=table;
    
    self.tableHandled.dataSource=self;
    self.tableHandled.delegate=self;
    
    self.isAllowLoadMore=false;
    self.isAllowPullToRefresh=false;
    
    [self.tableHandled registerNib:[UINib nibWithNibName:[LoadingCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[LoadingCell reuseIdentifier]];
    
    return self;
}

-(void)reload
{
    [self.tableHandled reloadData];
}

-(void)reset
{
    self.tableHandled.dataSource=nil;
    self.tableHandled.delegate=nil;
    
    self.datasource=[NSMutableArray array];
    self.page=0;
    
    self.tableHandled.dataSource=self;
    self.tableHandled.delegate=self;
    
    [self.tableHandled reloadData];
}

-(void)endRefresh
{
    
}

-(void)endLoadNext
{
    _isLoadingMore=false;
    [self.tableHandled reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return datasource.count==0?0:1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isAllowLoadMore && indexPath.row==datasource.count-1)
    {
        LoadingCell *cell=[tableView dequeueReusableCellWithIdentifier:[LoadingCell reuseIdentifier]];
        [cell startAnimation];
        
        if(!_isLoadingMore)
        {
            _isLoadingMore=true;
            
            bool isWaited=false;
            
            
            [self.delegate SGTableTemplateLoadMore:self isWaited:&isWaited];
            
            if(!isWaited)
                [self endLoadNext];
        }
        
        return cell;
    }
    
    return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    
    return tableView.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
        [self.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

-(void)setIsAllowPullToRefresh:(bool)_isAllowPullToRefresh
{
    isAllowPullToRefresh=_isAllowPullToRefresh;
    
    if(isAllowPullToRefresh)
    {
        if(!self.refreshControl)
        {
            ODRefreshControl *refresh=[[ODRefreshControl alloc] initInScrollView:self.tableHandled];
            
            [refreshControl addTarget:self action:@selector(refreshControLRefresh:) forControlEvents:UIControlEventValueChanged];
            
            self.refreshControl=refresh;
        }
    }
    else
    {
        if(self.refreshControl)
        {
            [self.refreshControl removeFromSuperview];
            self.refreshControl=nil;
        }
    }
}

-(void) refreshControLRefresh:(ODRefreshControl*) refresh
{
    
}

@end
