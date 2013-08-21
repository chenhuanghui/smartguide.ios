//
//  TableTemplate.h
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableTemplate;

@protocol TableTemplateDelegate <NSObject,UITableViewDataSource,UITableViewDelegate>

-(bool) tableTemplateAllowLoadMore:(TableTemplate*) tableTemplate;

@optional
-(NSString*) reuseIdentifierLoadingCell:(TableTemplate*) tableTemplate;
-(void) tableTemplateLoadNext:(TableTemplate*) tableTemplate wait:(bool*) isWait;

@end

@interface TableTemplate : NSObject<UITableViewDelegate,UITableViewDataSource>
{
    bool _isAllowLoadMore;
    bool _isLoadingMore;
    
    __weak UITableView *_tableView;
    NSIndexPath *_indexPathLoadingCell;
}

-(TableTemplate*) initWithTableView:(UITableView*) tableView withDelegate:(id<TableTemplateDelegate>) delegate;

-(void) resetData;
-(void) endLoadNext;
-(UITableView*) tableView;
-(void) setTableView:(UITableView*) tableView;

-(void) setAllowLoadMore:(bool) isAllowLoadMore;

@property (nonatomic, assign) id<TableTemplateDelegate> delegate;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *datasource;

@end