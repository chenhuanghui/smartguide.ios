//
//  TableTemplates.h
//  Infory
//
//  Created by XXX on 8/26/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableView : UITableView

@end

@class TableAPI;

@protocol TableAPIDataSource <UITableViewDataSource>

@optional
-(void) tableLoadMore:(TableAPI*) tableAPI;
-(void) tableRefresh:(TableAPI*) tableAPI;

@end

@interface TableAPI : TableView

@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, assign) bool canRefresh;
@property (nonatomic, weak) id<TableAPIDataSource> dataSource;

@end