//
//  RefreshTableView.m
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RefreshTableView.h"
#import "Utility.h"

enum REFRESH_STATE
{
    REFRESH_STATE_NORMAL=0,
    REFRESH_STATE_REFRESHING=1,
    REFRESH_STATE_DONE=2
};

#define REFRESH_TABLE_VIEW_HEIGHT 42.f

@interface RefreshTableView()
{
    enum REFRESH_STATE _state;
    CGPoint _anchorPoint;
}

@end

@implementation RefreshTableView

-(UIImage*) imageRefresh
{
    return [UIImage imageNamed:@"icon_refresh.png"];
}

-(UIImage*) imageRefreshing
{
    return [UIImage imageNamed:@"icon_refresh_blue.png"];
}

-(UIImage*) imageDone
{
    return [UIImage imageNamed:@"icon_refresh_done.png"];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    self.backgroundColor=[UIColor clearColor];
    self.userInteractionEnabled=false;
    self.autoresizesSubviews=false;
    
    _state=REFRESH_STATE_NORMAL;
    
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[self imageRefresh]];
    imgv.S=self.S;
    imgv.contentMode=UIViewContentModeCenter;
    
    [self addSubview:imgv];
    
    _imgvRefresh=imgv;
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgvRefresh.S=self.S;
}

-(void)setTable:(UITableView *)table
{
    if(_table)
        [_table removeObserver:self forKeyPath:@"contentOffset"];
    
    _table=table;
    
    if(_table)
    {
        _anchorPoint=self.O;
        [_table addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(_state!=REFRESH_STATE_NORMAL)
    {
        self.OY=_table.COY;
        return;
    }
    
    if(_table.COY<-REFRESH_TABLE_VIEW_HEIGHT)
    {
        self.OY=_table.COY;
    }
    
    if(_table.COY<-self.SH)
    {
//        float refreshDistance=REFRESH_TABLE_VIEW_HEIGHT*2;
        float y=_table.COY+self.SH;
        
        NSLog(@"y %f",y);
    }
}

-(void)dealloc
{
    self.table=nil;
}

@end

#import <objc/runtime.h>
static char RefreshTableViewKey;
@implementation UITableView(RefreshTableView)

-(RefreshTableView *)refreshView
{
    return objc_getAssociatedObject(self, &RefreshTableViewKey);
}

-(void)setRefreshView:(RefreshTableView *)refreshView
{
    objc_setAssociatedObject(self, &RefreshTableViewKey, refreshView, OBJC_ASSOCIATION_ASSIGN);
}

-(void)showRefresh
{
    [self showRefreshInRect:CGRectMake(0, -REFRESH_TABLE_VIEW_HEIGHT, self.SW, REFRESH_TABLE_VIEW_HEIGHT)];
}

-(void)showRefreshInRect:(CGRect)rect
{
    if(self.refreshView)
        return;
    
    RefreshTableView *view=[[RefreshTableView alloc] initWithFrame:rect];
    view.table=self;
    
    [self insertSubview:view atIndex:0];
    
    self.refreshView=view;
}

-(void)removeRefresh
{
    if(self.refreshView)
    {
        [self.refreshView removeFromSuperview];
        self.refreshView=nil;
    }
}

@end