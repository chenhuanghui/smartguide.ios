//
//  TableTemplates.m
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "TableTemplates.h"
#import "LoadMoreView.h"
#import "RefreshTableView.h"
#import "Utility.h"

@interface TableView()
{
}

@end

@implementation TableView

@end

@interface TableAPI()
{
    bool _loadingMore;
    bool _refreshing;
}

@end

@implementation TableAPI

-(void)reloadData
{
    [super reloadData];
    
    _loadingMore=false;
    float height=80;
    
    if(_canLoadMore)
    {
        if(!self.loadMoreView)
        {
            [UIView animateWithDuration:0.15f animations:^{
                self.contentInset=UIEdgeInsetsMake(0, 0, height, 0);
            }];
        }
        
        [self showLoadMoreInRect:CGRectMake(0, self.CSH, self.SW, height)];
    }
    else
    {
        if(self.loadMoreView)
        {
            [UIView animateWithDuration:0.15f animations:^{
                self.contentInset=UIEdgeInsetsZero;
            }];
            [self removeLoadMore];
        }
    }
    
    if(_canRefresh)
    {
        if(!self.refreshView)
            [self showRefresh];
    }
    else
    {
        if(self.refreshView)
        {
            [self removeRefresh];
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_canLoadMore && self.loadMoreView)
    {
        if(!_loadingMore)
        {
            float y=self.loadMoreView.OY-self.COY-self.SH;
            
            if(y<0)
            {
                _loadingMore=true;
                
                [self.dataSource tableLoadMore:self];
            }
        }
    }
    
    if(_canRefresh && self.refreshView)
    {
        
    }
}

@end
