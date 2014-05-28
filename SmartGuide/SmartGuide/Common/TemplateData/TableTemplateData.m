//
//  TableTemplateData.m
//  Infory
//
//  Created by XXX on 5/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TableTemplateData.h"
#import "Utility.h"
#import "LoadingMoreCell.h"

@interface TableTemplateData()<UITableViewDelegate,UITableViewDataSource>
{
    bool _isLoadingMore;
    bool _canLoadMore;
    bool _canRefresh;
    int _page;
}

@end

@implementation TableTemplateData

-(TableTemplateData *)initWithTableView:(UITableView *)tableView delegate:(id<TableTemplateDelegate>)delegate
{
    self=[super init];
    
    self.table=tableView;
    self.table.dataSource=self;
    self.table.delegate=self;
    self.delegate=delegate;
    
    [self.table registerLoadingMoreCell];
    
    [self makeData];
    _isLoadingMore=false;
    _canRefresh=[self.delegate tableTemplateCanRefresh:self];
    _page=-1;
    
    return self;
}

-(void) makeData
{
    _canLoadMore=[self.delegate tableTemplateCanLoadMore:self];
}

-(void)reloadData
{
    [self makeData];
    [self.table reloadData];
}

-(void)markLoadMoreDone
{
    _isLoadingMore=false;
    
    [self reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.delegate tableTemplateData:self].count>0?1:0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.delegate tableTemplateData:self].count+(_canLoadMore?1:0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore)
    {
        if(indexPath.row==[self.delegate tableTemplateData:self].count)
        {
            if([self.delegate respondsToSelector:@selector(tableTemplateLoadingMoreCellHeight:)])
                return [self.delegate tableTemplateLoadingMoreCellHeight:self];
            
            return 80;
        }
    }
    
    return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_canLoadMore)
    {
        if(indexPath.row==[self.delegate tableTemplateData:self].count)
        {
            if(!_isLoadingMore)
            {
                _isLoadingMore=true;
                
                [self.delegate tableTemplateLoadMore:self];
            }
            
            return [tableView loadingMoreCell];
        }
    }
    
    return [self.delegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if([cell isKindOfClass:[LoadingMoreCell class]])
        return;
    
    if([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.delegate scrollViewDidScroll:scrollView];
}

@end
