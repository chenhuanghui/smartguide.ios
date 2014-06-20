//
//  RefreshingView.m
//  Infory
//
//  Created by XXX on 5/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "RefreshingView.h"
#import "Utility.h"

@implementation RefreshingView
@synthesize refreshState;

-(RefreshingView *)initWithTableView:(UITableView *)table
{
    self=[super initWithFrame:CGRectMake(0, 0, table.l_v_w, [RefreshingView height])];
    
    table.tableHeaderView=self;
    [table.tableHeaderView l_v_setH:[RefreshingView height]];
    
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.l_v_w, self.l_v_h)];
    imgv.autoresizingMask=UIViewAutoresizingAll();
    imgv.image=[UIImage imageNamed:@"icon_refresh.png"];
    imgv.contentMode=UIViewContentModeCenter;
    
    [self addSubview:imgv];
    
    imgvRefresh=imgv;
    
    refreshState=REFRESH_VIEW_STATE_NORMAL;
    
    return self;
}

-(void)tableDidScroll:(UITableView *)table
{
    if(self.refreshState==REFRESH_VIEW_STATE_REFRESHING ||
       self.refreshState==REFRESH_VIEW_STATE_DONE)
    {
        return;
    }
    
    float y=[table offsetYWithInsetTop];
    float iconRefreshHeight=18;
    float startYRotate=(self.l_v_h-iconRefreshHeight-4)+y;
    
    if(startYRotate<0)
    {
        startYRotate=fabsf(startYRotate);
        float angle=DEGREES_TO_RADIANS(startYRotate*4.5f);
        
        if(angle>M_PI*2)
        {
            [self.delegate refreshingViewNeedRefresh:self];
            imgvRefresh.transform=CGAffineTransformIdentity;
            imgvRefresh.image=[UIImage imageNamed:@"icon_refresh_blue.png"];
            refreshState=REFRESH_VIEW_STATE_REFRESHING;
            _isMarkRefreshDone=false;
            
            [UIView animateWithDuration:0.1f animations:^{
                table.contentInset=UIEdgeInsetsMake(self.l_v_h, 0, -self.l_v_h, 0);
            }];
            
            [self animationRefreshing:M_PI*2];
        }
        else
        {
            imgvRefresh.transform=CGAffineTransformMakeRotation(angle);
        }
    }
    else
        imgvRefresh.transform=CGAffineTransformIdentity;
}

-(void) animationRefreshing:(float) angle
{
    if(self.refreshState!=REFRESH_VIEW_STATE_REFRESHING)
        return;
    
    __weak RefreshingView *wSelf=self;
    
    [UIView animateWithDuration:0.15f animations:^{
        imgvRefresh.transform=CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
        if(wSelf)
            [wSelf animationRefreshing:angle+M_PI/4];
    }];
}

+(float)height
{
    return 42;
}

-(void)markRefreshDone:(UITableView *)table
{
    _isMarkRefreshDone=true;
    refreshState=REFRESH_VIEW_STATE_DONE;
    table.userInteractionEnabled=false;
    
    imgvRefresh.transform=CGAffineTransformIdentity;
    imgvRefresh.image=[UIImage imageNamed:@"icon_refresh_done.png"];
    
    [self callRefreshFinished:table];
}

-(void) callRefreshFinished:(UITableView*) table
{
    if(_isMarkRefreshDone && !_isUserDragging)
    {
        _isMarkRefreshDone=false;
        
        [UIView animateWithDuration:0.3f animations:^{
            table.contentInset=UIEdgeInsetsZero;
        }];
        
        table.userInteractionEnabled=true;
        refreshState=REFRESH_VIEW_STATE_NORMAL;
        imgvRefresh.image=[UIImage imageNamed:@"icon_refresh.png"];
        
        [self.delegate refreshingViewFinished:self];
    }
}

-(void)tableWillBeginDragging:(UITableView *)table
{
    _isUserDragging=true;
}

-(void)tableDidEndDecelerating:(UITableView *)table
{
    _isUserDragging=false;
    
    if(self.refreshState==REFRESH_VIEW_STATE_DONE)
        [self callRefreshFinished:table];
}

-(void)tableDidEndDragging:(UITableView *)table willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        _isUserDragging=false;
        
        if(self.refreshState==REFRESH_VIEW_STATE_DONE)
            [self callRefreshFinished:table];
    }
}

@end
