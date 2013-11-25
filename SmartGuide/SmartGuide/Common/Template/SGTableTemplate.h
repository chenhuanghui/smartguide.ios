//
//  SGTableTemplate.h
//  SmartGuide
//
//  Created by MacMini on 29/10/2013.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SGTableTemplate;

@protocol SGTableTemplateDelegate <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@optional
-(void) SGTableTemplateLoadMore:(SGTableTemplate*) SGTemplate isWaited:(bool*) isWaited;
-(void) SGTableTemplateRefresh:(SGTableTemplate*) SGTemplate isWaited:(bool*) isWaited;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end

@interface SGTableTemplate : NSObject<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    bool _isLoadingMore;
}

-(SGTableTemplate*) initWithTableView:(UITableView*) table withDelegate:(id<SGTableTemplateDelegate>) delegate;

-(void) reset;
-(void) reload;
-(void) endLoadNext;
-(void) endRefresh;

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) id<SGTableTemplateDelegate> delegate;
@property (nonatomic, weak) UITableView *tableHandled;
@property (nonatomic, assign) bool isAllowLoadMore;
@property (nonatomic, assign) bool isAllowPullToRefresh;

@end
