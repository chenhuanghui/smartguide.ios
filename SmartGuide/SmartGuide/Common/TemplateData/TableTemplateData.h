//
//  TableTemplateData.h
//  Infory
//
//  Created by XXX on 5/28/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableTemplateData;

@protocol TableTemplateDelegate <UITableViewDataSource,UITableViewDelegate>

-(NSArray*) tableTemplateData:(TableTemplateData*) tableTemplate;
-(bool) tableTemplateCanLoadMore:(TableTemplateData*) tableTemplate;
-(bool) tableTemplateCanRefresh:(TableTemplateData*) tableTemplate;
-(void) tableTemplateLoadMore:(TableTemplateData*) tableTemplate;
-(void) tableTemplateRefresh:(TableTemplateData*) tableTemplate;

@optional
-(float) tableTemplateLoadingMoreCellHeight:(TableTemplateData*) tableTemplate;

@end

@interface TableTemplateData : NSObject
{
    
}

-(TableTemplateData*) initWithTableView:(UITableView*) tableView delegate:(id<TableTemplateDelegate>) delegate;
-(void) reloadData;
-(void) markLoadMoreDone;

@property (nonatomic, weak) id<TableTemplateDelegate> delegate;
@property (nonatomic, weak) UITableView *table;

@end
