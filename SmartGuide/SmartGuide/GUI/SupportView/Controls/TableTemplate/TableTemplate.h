//
//  TableTemplate.h
//  SmartGuide
//
//  Created by XXX on 7/19/13.
//  Copyright (c) 2013 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

enum TABLE_DIRECTION {
    TABLE_DIRECTION_TO_TOP = 0,//user scroll bot->top
    TABLE_DIRECTION_TO_BOTTOM = 1,//user scroll top->bot
    TABLE_DIRECTION_NONE = 2
    };

@class TableTemplate;

@protocol TableTemplateDelegate <NSObject,UITableViewDataSource,UITableViewDelegate>

-(bool) tableTemplateAllowLoadMore:(TableTemplate*) tableTemplate;

@optional
-(NSString*) reuseIdentifierLoadingCell:(TableTemplate*) tableTemplate;
-(void) tableTemplateLoadNext:(TableTemplate*) tableTemplate wait:(bool*) isWait;
-(bool) tableTemplateAllowAutoScrollFullCell:(TableTemplate*) tableTemplate;
-(enum TABLE_DIRECTION) tableTemplateManualProcessDirectionWithVelocity:(CGPoint) velocity lastVelocity:(CGPoint) lastVelocity;

@end

@interface TableTemplate : NSObject<UITableViewDelegate,UITableViewDataSource>
{
    bool _isAllowLoadMore;
    bool _isLoadingMore;
    bool _isAllowAutoScrollFullCell;
    
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
@property (nonatomic, readonly) int scrollDirection;
@property (nonatomic, assign) bool isHoriTable;
@property (nonatomic, assign) float alignAutoCell;

@end