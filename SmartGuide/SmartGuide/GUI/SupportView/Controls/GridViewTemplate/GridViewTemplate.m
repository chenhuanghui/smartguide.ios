//
//  GridViewTemplate.m
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import "GridViewTemplate.h"
#import <QuartzCore/QuartzCore.h>

@interface GridViewTemplate()

@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) CGPoint lastContentOffset;
@property (nonatomic, readonly) int scrollDirection;

@end

@implementation GridViewTemplate
@synthesize gView,isAllowLoadMore,page,datasource,delegate,selectedIndex;
@synthesize contentOffset,lastContentOffset,isAutoFullCell,scrollDirection;

-(GridViewTemplate *)initWithGridView:(GMGridView *)gridView delegate:(id<GridViewTemplate>)_delegate
{
    self=[super init];
    
    self.datasource=[[NSMutableArray alloc] init];
    self.page=0;
    self.gView=gridView;
    _isLoadingMore=false;
    
    gridView.dataSource=self;
    gridView.actionDelegate=self;
    gridView.delegate=self;
    
    self.delegate=_delegate;
    
    self.isAllowLoadMore=[delegate gridViewTemplateAllowLoadMore:gridView];
    
    return self;
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    selectedIndex=position;

    return [delegate GMGridView:gridView didTapOnItemAtIndex:position];
}

-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return self.datasource.count+(self.isAllowLoadMore?1:0);
}

-(GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    if(self.isAllowLoadMore)
    {
        if(index==[self numberOfItemsInGMGridView:gridView]-1)
        {
            GMGridViewCell *cell=[gridView dequeueReusableCellWithIdentifier:@"LoadingCell"];
            UIView *view;
            UIActivityIndicatorView *indicator;
            
            if(!cell)
            {
                cell=[[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, gridView.frame.size.width, gridView.frame.size.height)];
                cell.backgroundColor=[UIColor clearColor];

                view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
                
                view.layer.masksToBounds=true;
                view.layer.cornerRadius=8;
                view.backgroundColor=[UIColor blackColor];
                
                cell.contentView=view;
                
                indicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                indicator.center=CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
                
                [view addSubview:indicator];
            }
            else
            {
                indicator=[cell.contentView.subviews objectAtIndex:0];
            }
            
            [indicator startAnimating];
            
            if(!_isLoadingMore)
            {
                _isLoadingMore=true;
                
                bool isWaited=false;
                
                [delegate gridViewTemplateLoadNext:gridView needWait:&isWaited];
                
                if(!isWaited)
                    [self endLoadNext];
            }
            
            return cell;
        }
    }
    
    return [delegate GMGridView:gridView cellForItemAtIndex:index];
}

-(CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return [delegate GMGridView:gridView sizeForItemsInInterfaceOrientation:orientation];
}

-(void) endLoadNext
{
    _isLoadingMore=false;
    [self.gView reloadData];
}

-(void)reset
{
    gView.dataSource=nil;
    gView.delegate=nil;
    gView.actionDelegate=nil;
    
    [self.datasource removeAllObjects];
    self.datasource=[[NSMutableArray alloc] init];
    self.page=0;
    
    gView.dataSource=self;
    gView.delegate=self;
    gView.actionDelegate=self;
    
    [gView reloadData];
}

-(void)setGView:(GMGridView *)_gView
{
    gView=_gView;
    
    gView.dataSource=self;
    gView.actionDelegate=self;
    gView.delegate=self;
}

-(GMGridView *)gView
{
    return gView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    lastContentOffset=contentOffset;
    contentOffset=scrollView.contentOffset;
    
    float a,a1=0;
    a=contentOffset.x;
    a1=lastContentOffset.x;
    
    if(a1>a)
        scrollDirection=GRID_DIRECTION_TO_TOP;
    else
        scrollDirection=GRID_DIRECTION_TO_BOTTOM;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(!isAutoFullCell)
        return;
    
    if(datasource.count<=1)
        return;
    
    return;
    if(scrollDirection==GRID_DIRECTION_TO_BOTTOM)
    {
        if(self.gView.itemSubviews.count>2)
            [self.gView scrollRectToVisible:[[self.gView.itemSubviews objectAtIndex:self.gView.itemSubviews.count-2] frame] animated:true];
    }
    else if(scrollDirection==GRID_DIRECTION_TO_TOP)
    {
        if(self.gView.itemSubviews.count>2)
            [self.gView scrollRectToVisible:[[self.gView.itemSubviews objectAtIndex:1] frame] animated:true];
    }
}

@end
