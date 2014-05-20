//
//  RefreshingView.h
//  Infory
//
//  Created by XXX on 5/20/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <UIKit/UIKit.h>

enum REFRESH_VIEW_STATE
{
    REFRESH_VIEW_STATE_NORMAL=0,
    REFRESH_VIEW_STATE_REFRESHING=1,
    REFRESH_VIEW_STATE_DONE=2
};


@class RefreshingView;
@protocol RefreshingViewDelegate <NSObject>

-(void) refreshingViewNeedRefresh:(RefreshingView*) refreshView;
-(void) refreshingViewFinished:(RefreshingView*) refreshView;

@end

@interface RefreshingView : UIView
{
    __weak UIImageView *imgvRefresh;
    bool _isUserDragging;
    bool _isMarkRefreshDone;
}

-(RefreshingView*) initWithTableView:(UITableView*) table;
-(void) tableDidScroll:(UITableView*) table;
-(void) tableDidEndDecelerating:(UITableView*) table;
-(void) tableDidEndDragging:(UITableView*) table willDecelerate:(BOOL) decelerate;
-(void) tableWillBeginDragging:(UITableView*) table;
-(void) markRefreshDone:(UITableView*) table;

+(float) height;

@property (nonatomic, readonly) enum REFRESH_VIEW_STATE refreshState;
@property (nonatomic, weak) id<RefreshingViewDelegate> delegate;

@end
