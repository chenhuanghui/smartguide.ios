//
//  TableTemplate.m
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "TableTemplate.h"
#import "LoadingCell.h"
#import "Utility.h"

@interface TableTemplate()

@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation TableTemplate
@synthesize delegate,page,datasource,lastContentOffset,isHoriTable,contentOffset,scrollDirection,currentIndexPath;
@synthesize alignAutoCell;

-(TableTemplate *)initWithTableView:(UITableView *)tableView withDelegate:(id<TableTemplateDelegate>)_delegate
{
    self=[super init];
    
    self.isHoriTable=false;
    
    self.datasource=[[NSMutableArray alloc] init];
    page=0;
    _tableView=tableView;
    
    tableView.delegate=self;
    tableView.dataSource=self;
    
    self.delegate=_delegate;
    
    _isAllowLoadMore=false;
    if([self isRepondsSEL:@selector(tableTemplateAllowLoadMore:)])
        _isAllowLoadMore=[delegate tableTemplateAllowLoadMore:self];
    
    NSString *loadingCell=[LoadingCell reuseIdentifier];
    if([delegate respondsToSelector:@selector(reuseIdentifierLoadingCell:)])
        loadingCell=[delegate reuseIdentifierLoadingCell:self];
    
    [_tableView registerNib:[UINib nibWithNibName:loadingCell bundle:nil] forCellReuseIdentifier:loadingCell];
    
    _isAllowAutoScrollFullCell=false;
    if([delegate respondsToSelector:@selector(tableTemplateAllowAutoScrollFullCell:)])
        _isAllowAutoScrollFullCell=[delegate tableTemplateAllowAutoScrollFullCell:self];
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [delegate numberOfSectionsInTableView:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRow=[delegate tableView:tableView numberOfRowsInSection:section];
    
    if(_isAllowLoadMore && numberOfRow>0)
    {
        numberOfRow++;
        _indexPathLoadingCell=[NSIndexPath indexPathForRow:numberOfRow-1 inSection:section];
    }
    
    return numberOfRow;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_isAllowLoadMore)
    {
        if(indexPath.row==[self tableView:tableView numberOfRowsInSection:indexPath.section]-1)
        {
            if([self respondsToSelector:@selector(reuseIdentifierLoadingCell:)])
            {
                UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[delegate reuseIdentifierLoadingCell:self]];
                if([cell respondsToSelector:@selector(startAnimation)])
                    [cell performSelector:@selector(startAnimation)];
                return cell;
            }
            
            LoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:[LoadingCell reuseIdentifier]];
            [cell startAnimation];
            
            if(!_isLoadingMore)
            {
                bool isWaited=false;
                [delegate tableTemplateLoadNext:self wait:&isWaited];
                if(!isWaited)
                    [self endLoadNext];
            }
            
            return cell;
        }
    }
    
    return [delegate tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isRepondsSEL:@selector(tableView:heightForRowAtIndexPath:)])
        return [delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    
    return tableView.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isRepondsSEL:@selector(tableView:didSelectRowAtIndexPath:)])
        [delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isRepondsSEL:@selector(tableView:didDeselectRowAtIndexPath:)])
        [delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

-(void)endLoadNext
{
    _isLoadingMore=false;
    [_tableView reloadData];
}

-(void)resetData
{
    _tableView.dataSource=nil;
    _tableView.delegate=nil;
    
    [_tableView reloadData];
    
    _tableView.dataSource=self;
    _tableView.delegate=self;
}

-(bool) isRepondsSEL:(SEL) selector
{
    return delegate && [delegate respondsToSelector:selector];
}

-(UITableView *)tableView
{
    return _tableView;
}

-(void)setTableView:(UITableView *)tableView
{
    _tableView=tableView;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    NSString *loadingCell=[LoadingCell reuseIdentifier];
    if([delegate respondsToSelector:@selector(reuseIdentifierLoadingCell:)])
        loadingCell=[delegate reuseIdentifierLoadingCell:self];
    
    [_tableView registerNib:[UINib nibWithNibName:loadingCell bundle:nil] forCellReuseIdentifier:loadingCell];
    
    [tableView reloadData];
}

-(void)setAllowLoadMore:(bool)isAllowLoadMore
{
    _isAllowLoadMore=isAllowLoadMore;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    lastContentOffset=contentOffset;
    contentOffset=scrollView.contentOffset;
    
    float a,a1=0;
    
    if(true)
    {
        a=contentOffset.y;
        a1=lastContentOffset.y;
    }
    else
    {
        a=contentOffset.x;
        a1=lastContentOffset.x;
    }
    
    if(a1>a)
        scrollDirection=TABLE_DIRECTION_TO_TOP;
    else
        scrollDirection=TABLE_DIRECTION_TO_BOTTOM;
    
    if([self isRepondsSEL:@selector(scrollViewDidScroll:)])
        [delegate scrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(!_isAllowAutoScrollFullCell)
        return;
    
    if(_tableView.indexPathsForVisibleRows.count<=1)
        return;
    
    if(scrollDirection==TABLE_DIRECTION_TO_BOTTOM)
    {
        CGRect rect=[_tableView rectForRowAtIndexPath:[_tableView indexPathsForVisibleRows].lastObject];
        rect.origin.y-=self.alignAutoCell;
        [_tableView scrollRectToVisible:rect animated:true];
//        [_tableView scrollToRowAtIndexPath:[_tableView indexPathsForVisibleRows].lastObject atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
    else if(scrollDirection==TABLE_DIRECTION_TO_TOP)
    {
        CGRect rect=[_tableView rectForRowAtIndexPath:[_tableView indexPathsForVisibleRows].firstObject];
        rect.origin.y+=self.alignAutoCell;
        [_tableView scrollRectToVisible:rect animated:true];
//        [_tableView scrollToRowAtIndexPath:[_tableView indexPathsForVisibleRows].firstObject atScrollPosition:UITableViewScrollPositionNone animated:true];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if([self isRepondsSEL:@selector(scrollViewDidEndDecelerating:)])
        [delegate scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if([self isRepondsSEL:@selector(scrollViewDidEndScrollingAnimation:)])
        [delegate scrollViewDidEndScrollingAnimation:scrollView];
}

@end
