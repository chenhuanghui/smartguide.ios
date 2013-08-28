//
//  GridViewTemplate.h
//  SmartGuide
//
//  Created by XXX on 8/27/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMGridView.h"

@protocol GridViewTemplate <NSObject,GMGridViewActionDelegate,GMGridViewDataSource,UIScrollViewDelegate>

-(bool) gridViewTemplateAllowLoadMore:(GMGridView*) gridView;

@optional
-(void) gridViewTemplateLoadNext:(GMGridView*) gridView needWait:(bool*) isWait;
-(NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView;

@end

@interface GridViewTemplate : NSObject<GMGridViewDataSource,GMGridViewActionDelegate,UIScrollViewDelegate>
{
    bool _isLoadingMore;
}

-(GridViewTemplate*) initWithGridView:(GMGridView*) gridView delegate:(id<GridViewTemplate>) delegate;
-(void) reset;
-(void) endLoadNext;

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) bool page;
@property (nonatomic, assign) bool isAllowLoadMore;
@property (nonatomic, assign) GMGridView *gView;
@property (nonatomic, assign) id<GridViewTemplate> delegate;
@property (nonatomic, assign) int selectedIndex;

@end
