//
//  DataAPI.h
//  Infory
//
//  Created by XXX on 9/4/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataAPI, ASIOperationPost;

@protocol DataAPIDelegate <NSObject>

-(void) dataAPIFinished:(DataAPI*) dataAPI;
-(void) dataAPIFailed:(DataAPI*) dataAPI;

@end

@interface DataAPI : NSObject

+(instancetype) manager;

-(void) cancelAllRequest;
-(void) requestData;
-(void) loadMore;

-(ASIOperationPost*) createOperationAtPage:(int) page;
-(void) prepareDataWithOperation:(ASIOperationPost*) operation;

-(void) addObserver:(id<DataAPIDelegate>) observer;

@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableArray *observer;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, assign) bool loadingMore;
@property (nonatomic, strong) ASIOperationPost *currentOperation;

@end

@interface DataAPIObserver : NSObject

@property (nonatomic, weak) id<DataAPIDelegate> observer;

@end

@interface HomeDataAPI : DataAPI

-(NSArray*) objectsMap;

@end

@interface EventDataAPI : DataAPI

-(NSArray*) objectsMap;

@end